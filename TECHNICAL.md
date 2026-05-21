# Technical notes

Architecture, data model and deployment for the ECHO Indications app. For the user-facing description, see [README.md](README.md).

> **Note on scope.** This repo contains only the Xojo application source. The clinical content (indication seeds, decision-tree seed, source-guideline references), schema migrations, secrets, and database dumps live **outside** the repo. Building from this source alone gives you a runnable app that talks to an empty database; you also need the content and schema to make it useful. Contact the maintainer for access if you're collaborating clinically.

---

## Stack

| Layer | Choice |
|---|---|
| Application framework | [Xojo Web 2](https://www.xojo.com) |
| Backend host | Xojo Cloud |
| Database | MySQL / MariaDB (`MySQLCommunityServer` plugin) |
| Email | MailJet (transactional; outbound SMTP code retired) |
| Source control | Git / GitHub |

Single-binary compiled by Xojo, stateless beyond per-`Session` data. Persistent state lives in the database; secrets and large assets live outside the repo.

---

## Repository layout

```
echo_indications/
├── Classes/            Model classes (Indication, DecisionNode, Context, User, WebNavigationManager)
├── Containers/         Reusable web sub-components (page header, etc.)
├── Dialogs/            Modal dialogs (dlg_Indication, dlg_cds, dlg_user, dlg_ChangeRequest, …)
├── Modules/            Cross-cutting helpers (AuditTracker, Secrets, EmailHelper, PubSub, …)
├── Windows/            Top-level WebPages (wp_LandingPage, wp_indications, wp_cds_editor,
│                       wp_audit, wp_settings, wp_users, wp_issues)
├── Session.xojo_code   Per-user session state (auth, DB connection)
├── EchoIndicationsApp.xojo_code   App entry, startup wiring
├── Build Automation.xojo_code      Build hooks
├── Graphics/           Icons and image assets
├── ECHO_indications.xojo_project   Xojo project file
├── ECHO_indications.xojo_resources Binary resources bundled by Xojo
├── secrets.env.example Template for the out-of-tree secrets file
└── README.md / TECHNICAL.md / LICENSE / .gitignore
```

Everything **not** in this list (clinical content seeds, schema migrations, database dumps, source-guideline PDFs, deployment notes, working files) lives in the sibling folder `../echo_indications resources/` and is **not** in git.

---

## Data model

### Core tables

- **`indications`** &mdash; the AUC catalogue. Per row: `title`, `keywords`, `comments`, three setting-specific verdicts (`primary_care`, `secondary_inpatient`, `secondary_outpatient`), one `urgency`, source flags (`source_ase`, `source_eacvi`, `source_bse`, `source_bhvs`, `source_consensus`) and timestamps.
- **`contexts`** &mdash; clinical groupings (Chest pain, Heart failure, Valve disease, …) with `sort_order` and `is_active`.
- **`indication_contexts`** &mdash; many-to-many join.
- **`decision_nodes`** &mdash; the Clinical Decision Support tree. Self-referencing tree via `parent_id`. Per row: `option_label`, `sort_order`, optional `prompt`/`rationale`, and optional `indication_id`.

### Decision tree contract

One rule determines whether a node is a verdict leaf or a branch:

> **A node is terminal iff `indication_id IS NOT NULL`.**

There are no verdict columns on `decision_nodes`. Verdicts and urgency come from the linked indication &mdash; the tree's only job is to walk the clinician to the right indication. An earlier design with per-leaf verdict overrides was abandoned in May 2026; see the comment on `DecisionNode.IsTerminal()`.

### Editorial / system tables

- **`users`** &mdash; accounts (`username`, PBKDF2 `password_hash`/`password_salt`/`password_iterations`, `email`, `OTP`, `is_active`).
- **`audit`** &mdash; append-only log for create/update/delete on indications, contexts, decision_nodes and users. Captures `audit_user`, `audit_table`, `audit_primarykey`, `action`, `changed_fields`, `old_values`, `new_values` (JSON).
- **`changelog`** &mdash; release notes shown on the landing page.
- **`changes`** &mdash; user-submitted change requests against specific indications, plus general issues.
- **`rate_limit`** &mdash; IP-based throttling for auth endpoints.

---

## Content and schema

Indication seeds, the decision-tree seed and schema migrations are **not** in this repo &mdash; they live in `../echo_indications resources/` alongside DB dumps and source-guideline PDFs. The maintainer applies them via the `mysql` CLI in this order on a fresh DB:

1. Schema migrations (dated files, applied in order).
2. The blended indications seed (idempotent: UPDATE-or-INSERT by `title`).
3. Any incremental content packs (same idempotent pattern; order-independent against the blended seed).
4. The decision-tree seed, which DELETEs and rebuilds `decision_nodes` from scratch, resolving leaf links by `title` (portable across DB rebuilds because AUTO_INCREMENT ids vary).

If you rename indication titles in the content seeds, the decision-tree seed must be re-applied so its title-based lookups still resolve.

If you're collaborating and need access to the content files, contact the maintainer.

---

## Key files

| Concern | File |
|---|---|
| Model &mdash; indications | `Classes/Indication.xojo_code` |
| Model &mdash; decision nodes | `Classes/DecisionNode.xojo_code` |
| Indication list / detail | `Windows/wp_indications.xojo_code`, `Dialogs/dlg_Indication.xojo_code` |
| CDS user-facing dialog | `Dialogs/dlg_cds.xojo_code` |
| CDS admin editor | `Windows/wp_cds_editor.xojo_code` |
| Audit log UI | `Windows/wp_audit.xojo_code`, `Dialogs/dlg_AuditEntry.xojo_code` |
| Settings (contexts, changelog) | `Windows/wp_settings.xojo_code`, `Dialogs/dlg_ChangeLogEditor.xojo_code` |
| Users admin | `Windows/wp_users.xojo_code`, `Dialogs/dlg_user.xojo_code` |
| Change requests / issues | `Windows/wp_issues.xojo_code`, `Dialogs/dlg_ChangeRequest.xojo_code`, `Dialogs/dlg_Issue.xojo_code` |
| Audit tracker | `Modules/AuditTracker.xojo_code` |
| Secrets loading | `Modules/Secrets.xojo_code` |
| Outbound email | `Modules/EmailHelper.xojo_code` |
| Pub/sub between controls | `Modules/PubSub.xojo_code` |
| Session / auth state | `Session.xojo_code` |
| Routing / deep links | `Classes/WebNavigationManager.xojo_code`, `EchoIndicationsApp.xojo_code` |

---

## Secrets

Credentials are **not** committed. The `Secrets` module loads keys (database, MailJet API, etc.) from an out-of-tree file at app startup:

- **Local / on-prem**: `/etc/ECHOINDICATIONS/secrets.env` (`SpecialFolder.Etc.Child("ECHOINDICATIONS")`).
- **Xojo Cloud**: `SharedDocuments/ECHOINDICATIONS/secrets.env`.

The shape of the file is in `secrets.env.example`. Keys are loaded once by `Secrets.Load` at startup and accessed via module-level getters. To add a new key: declare it in `Modules/Secrets.xojo_code` (parse + getter), then add the key to both the local template and every deployed secrets file.

---

## Audit log

Every create / update / delete on `indications`, `contexts`, `decision_nodes` and `users` goes through `AuditTracker`. The handler diffs old vs new field values and stores the changed-only set as JSON; the **Audit** page renders this with row-level expand and create/update/delete colour coding.

**Audit failures never roll back the originating write.** See `DecisionNode.SaveWithAudit` for the pattern: the save commits first, then audit logging is best-effort with a `Try/Catch` so a logging glitch doesn't lose the edit.

---

## Deep linking

Indication URLs of the form `https://echoindications.org/?id=42` open that indication immediately on launch. Routing is handled in `EchoIndicationsApp` startup and `Classes/WebNavigationManager.xojo_code`, which also tracks intra-app navigation history so post-login redirects land back where the user expected.

---

## Deployment

The app is built as a 64-bit Xojo Web binary and pushed to Xojo Cloud. The site is served at [https://echoindications.org](https://echoindications.org) with HTTPS terminated at the Xojo Cloud edge.

Database backups: dumps live in `../echo_indications resources/` (not in git).

---

## Source guidelines

Indications are cited per row via the `source_*` flags (ASE/ACC AUCs, BSE, BHVS, EACVI, local consensus). The full reference list and the ASE/ACC numeric-score &rarr; enum mapping used to translate AUC median scores into the app's three-value verdict are kept with the content files outside this repo. The mapping rule, in summary:

| ASE/ACC median appropriateness score | App verdict |
|---|---|
| 7-9 | `indicated` |
| 4-6 | `can_be_considered` |
| 1-3 | `not_indicated` |

---

## Licence

Apache 2.0. See [LICENSE](LICENSE).

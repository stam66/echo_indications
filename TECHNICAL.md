# Technical notes

Architecture, data model, content workflow and deployment for the ECHO Indications app. For the user-facing description, see [README.md](README.md).

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
├── content/            Clinical content seeds (idempotent SQL, applied via mysql CLI)
├── migrations/         Schema migrations (dated, applied in order)
├── decision_nodes_content_draft.sql   Decision tree seed (rebuilds the whole tree)
├── secrets.env.example   Template for the out-of-tree secrets file
└── README.md / TECHNICAL.md / LICENSE
```

Off-repo material (DB dumps, source PDFs, working files) lives in the sibling folder `../echo_indications resources/` &mdash; **not** in git.

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

## Content workflow

Indications and the decision tree are seeded by idempotent SQL files, applied via the `mysql` CLI.

### Indications

`content/blended_echo_indications_seed.sql` is the canonical "big bang" content pack, paraphrased from the source guidelines listed in `content/blended_echo_auc_sources.md`. It:

1. Inserts missing `contexts` rows.
2. Stages all indications in a temp table `import_blended_indications`, keyed by `title`.
3. **UPDATE**s existing rows whose title matches, then **INSERT**s any new ones.
4. Rebuilds `indication_contexts` links for the touched rows.

Incremental content packs (e.g. `content/2026-05-21_brugada_myocarditis_pericarditis.sql`) follow the same staging &rarr; UPDATE-or-INSERT &rarr; refresh-contexts pattern. They're safe to re-run and order-independent against the blended seed.

### Decision tree

`decision_nodes_content_draft.sql` rebuilds the entire `decision_nodes` table on every run:

1. Stages every node in a temp table `_decision_node_seed` with **`indication_title`** instead of `indication_id` (so the seed is portable across DB rebuilds; AUTO_INCREMENT ids vary).
2. Runs a **VALIDATION CHECKPOINT** `SELECT` that lists any unresolved titles.
3. `DELETE FROM decision_nodes` and re-inserts everything, resolving titles to ids at insert time. FK checks are briefly disabled so the single `INSERT` can include parents and children together.
4. Resets `AUTO_INCREMENT = 1000` so future editor-created nodes are visually distinct from the authored set.

**If you rename indication titles in `content/`, re-run the decision tree file too** so its title-based lookups still resolve.

### Schema migrations

DDL changes live in `migrations/` as dated files (e.g. `migrations/2026-05-19_add_bhvs_source.sql`). Apply in order, **before** the content seeds.

### Typical refresh on a fresh DB

```sh
mysql -u <user> -p <db> < migrations/2026-05-19_add_bhvs_source.sql
mysql -u <user> -p <db> < content/blended_echo_indications_seed.sql
mysql -u <user> -p <db> < content/2026-05-21_brugada_myocarditis_pericarditis.sql
mysql -u <user> -p <db> < decision_nodes_content_draft.sql
```

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

## Source guidelines (full list)

Cited per indication via the `source_*` flags. The full reference list is in `content/blended_echo_auc_sources.md`, along with the ASE/ACC numeric-score &rarr; enum mapping used to translate AUC median scores into the app's three-value verdict:

| ASE/ACC median appropriateness score | App verdict |
|---|---|
| 7-9 | `indicated` |
| 4-6 | `can_be_considered` |
| 1-3 | `not_indicated` |

---

## Licence

Apache 2.0. See [LICENSE](LICENSE).

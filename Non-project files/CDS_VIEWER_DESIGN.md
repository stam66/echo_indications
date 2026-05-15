# Clinical Decision Support — Viewer (`dlg_cds`)

End-user-facing dialog that walks a clinician through a decision tree to reach
an Appropriate Use Criteria (AUC) verdict. Read-only: the clinician selects
options, the dialog displays the corresponding verdict at terminal nodes.

The viewer is a `WebDialog` because the interaction is focused and modal — pick
a path, read the verdict, close. It runs on top of the landing page or wherever
the user invoked it from.

---

## Purpose

Provide a guided path through clinical reasoning that ends in one of the
existing AUC entries, eliminating the need for the clinician to know the
indication library by title. The tree's job is **navigation**, not encoding
verdicts — verdicts live in the `indications` table and remain the single
source of truth.

---

## Data model

One table: **`decision_nodes`** (self-referential adjacency list).

```sql
CREATE TABLE decision_nodes (
  id            INT PRIMARY KEY AUTO_INCREMENT,
  parent_id     INT NULL REFERENCES decision_nodes(id),
  option_label  VARCHAR(255) NOT NULL,   -- the button text shown to the user
  prompt        VARCHAR(500) NULL,        -- the question for THIS node's children
  sort_order    INT DEFAULT 0,            -- ordering among siblings
  verdict       ENUM('indicated','not_indicated','can_be_considered') NULL,
  urgency       ENUM('routine','soon','urgent') NULL,
  rationale     TEXT NULL,
  indication_id INT NULL REFERENCES indications(id),   -- preferred verdict source
  created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### Node taxonomy

| Role | Distinguishing fields |
|---|---|
| **Root** | `parent_id IS NULL`. The starting list of presenting complaints. |
| **Branch** | `parent_id IS NOT NULL`, `prompt IS NOT NULL`, no verdict set. Has children. |
| **Verdict leaf — linked** *(preferred)* | `indication_id IS NOT NULL`. Verdict comes from that indication's GP/IP/OP cells. |
| **Verdict leaf — custom** *(escape hatch)* | `verdict IS NOT NULL`, no `indication_id`. Single verdict for cases the AUC table doesn't cover, or where context modifies it. |

`rationale` is the tree's tree-specific explanatory text — independent of the
indication's own comments. Optional.

### Why one table

The adjacency-list pattern (self-referential `parent_id`) scales fine for
clinical trees (typically 50–500 nodes). Sub-cases that *don't* fit:

- **Shared sub-trees** (same workup reachable from multiple presenting complaints).
  Would require a node–edge split (nodes + many-to-many edges = DAG). Defer
  until content authoring shows real duplication.
- **Verdict that branches further** ("indicated, but if X also true, escalate").
  Already supported: a single node can carry both `verdict` *and* children.
  `dlg_cds` keeps showing options when both are present.

---

## UI structure

Controls on the dialog (left → right, top → bottom):

| Control | Role |
|---|---|
| `lblDialogTitle` | "Clinical Decision Support" header (inside `Rectangle2`). |
| `breadcrumb_cds` (WebBreadcrumb) | Path through the tree. First crumb is always "Start over". Click any crumb to navigate back to that level. |
| `lblCurrentPrompt` (WebLabel) | The question being asked at this level. |
| `lstOptions` (WebListBox) | One row per child option. Click a row → drill into that child. |
| `rectVerdict` (WebRectangle) | Container for the verdict view. Hidden until a terminal node is reached. |
| → `lblVerdict` (WebLabel, bold) | The indication title (or the verdict word, for custom-verdict nodes). |
| → `lblGP`, `lblIP`, `lblOP` *(to add)* | Three small RAG chips, ~80 × 38 px. Bg colour set in code from indication's verdict per setting. Caption is short e.g. "Yes", "No", "?". |
| → `lblRationale` (WebLabel, multiline) | The tree's tree-specific rationale, or the indication's comments fallback. |
| → `btnOpenIndication` *(to add)* | Opens `dlg_Indication` for the linked indication's full detail (sources, contexts, last reviewed). Hidden for custom-verdict leaves. |
| `btnClose` | Closes the dialog. |

### State transitions

| State | Visible | Hidden |
|---|---|---|
| Root or branch | `lblCurrentPrompt`, `lstOptions` | `rectVerdict` (and all its children) |
| Terminal — linked indication | `rectVerdict`, `lblVerdict`, `lblGP/IP/OP`, `lblRationale` (if text), `btnOpenIndication` | `lblCurrentPrompt`, `lstOptions` |
| Terminal — custom verdict | `rectVerdict`, `lblVerdict`, `lblRationale` (if text) | `lblCurrentPrompt`, `lstOptions`, the 3 RAG chips, `btnOpenIndication` |

A node carrying *both* a verdict and children is shown in branch state (verdict
hidden in favour of the next prompt) — the verdict acts as a summary only when
no further refinement is available.

---

## Behaviour

### Opening
- `Session.NavigationManager`/`dlg.Show` opens the dialog.
- `Shown` event calls `ResetToRoot` → root options shown.

### Walking the tree
- `lstOptions.Pressed(row, col)` → push the child's ID onto `PathIDs` stack,
  set `CurrentNodeID`, call `RenderStep`.
- `RenderStep`:
  1. Rebuild breadcrumb from `PathIDs` (always prepend "Start over").
  2. If current node is terminal (has `verdict` or `indication_id`), call `ShowVerdict`.
  3. Else fetch children of current node, populate `lstOptions`, show prompt.

### Reaching a verdict
- `ShowVerdict`:
  - If `n.IndicationID > 0`: load the indication via `Indication.GetByID`,
    set `lblVerdict.Text` to indication title, paint the 3 RAG chips from the
    indication's `primary_care` / `secondary_inpatient` / `secondary_outpatient`,
    set `lblRationale` to the tree's rationale OR fall back to indication's `comments`,
    show `btnOpenIndication`.
  - Else if `n.Verdict <> ""`: set `lblVerdict.Text` to the verdict word + urgency,
    hide the 3 RAG chips and the open-details button.
  - Hide `lblCurrentPrompt` and `lstOptions`; show `rectVerdict`.

### Backtracking
- `breadcrumb_cds.Pressed(index)`:
  - Index 0 → `ResetToRoot`.
  - Otherwise: truncate `PathIDs` to `index` entries, set `CurrentNodeID` to
    the new tail, call `RenderStep`.

### Opening linked indication
- `btnOpenIndication.Pressed`:
  - Create `dlg_Indication`, set `IndicationID = (current node's indication_id)`,
    show it.
  - The user can read the full AUC entry, then close to return to `dlg_cds`.

---

## Shared with the rest of the app

- **RAG colour logic**: should be a single shared helper (currently lives in
  `wp_indications.AucRenderer`). Move to a module — `Modules/AucStyling.xojo_code`
  with `AucColor(value As String) As Color` and `AucShortLabel(value As String) As String`.
  Both `wp_indications` and `dlg_cds` use it.
- **`DecisionNode` class** (already exists in `Classes/`): `GetRoots`, `GetChildren`,
  `GetByID`, `IsTerminal` is the read-side API the viewer uses.

---

## Known/accepted limitations

- **One verdict per setting per leaf.** If a clinical scenario warrants
  different verdicts per setting *and* differs from any existing indication,
  the answer is to add a new indication for that scenario, not to make the
  tree itself encode three independent verdicts.
- **No back-button for partial paths.** The breadcrumb is the only "back"
  affordance. There's no separate ← button.
- **Linear path only.** No "and/or" branches — the user picks one option per
  level. Multi-criteria logic (e.g. "both X and Y") has to be encoded as
  composite option labels.
- **Tree, not DAG.** Shared subtrees require duplication. See the Editor doc
  for the migration path if this becomes a problem.

---

## Implementation status

| Piece | Status |
|---|---|
| Schema (`decision_nodes_migration.sql`) | ✅ Done |
| Seed data (`decision_nodes_seed.sql`) | ✅ Done — but uses custom verdicts; needs at least some leaves migrated to `indication_id`. |
| `Classes/DecisionNode.xojo_code` | ✅ Done — GetRoots / GetChildren / GetByID / IsTerminal. |
| `dlg_cds` controls (breadcrumb, prompt, options, verdict rect) | ✅ Done |
| Drilling, breadcrumb navigation, custom-verdict display | ✅ Done |
| **Linked-indication verdict display** (3 RAG chips + Open button) | ⏳ Pending — needs IDE controls `lblGP`, `lblIP`, `lblOP`, `btnOpenIndication`; needs `ShowVerdict` rewrite. |
| Shared RAG styling module | ⏳ Pending |
| Seed leaves linked to real indications | ⏳ Pending — needs decision on which 5–10 leaves to link and which indication IDs. |

## Open questions (deferred)

- Multiple **independent decision trees** (e.g. local vs national guidelines).
  Would require a `tree_id` column and a tree-selector UI. Add only when a
  second tree is actually needed.
- Migration to a **DAG model** for shared subtrees. Easy mechanical migration
  (one INSERT) when needed; don't pre-empt.

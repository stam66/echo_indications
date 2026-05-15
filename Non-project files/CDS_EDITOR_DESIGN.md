# Clinical Decision Support — Editor (`wp_cds_editor`)

Admin-only authoring surface for the decision tree consumed by `dlg_cds`.
This is a **WebPage**, not a dialog — the control count, multi-column layout,
and editing duration all justify a full-screen surface. Sits alongside
`wp_users`, `wp_settings`, `wp_audit`, etc. as an admin-only navigation
destination.

Reachable from the segmented button on `wc_WebPageHeader` (visible to authenticated
admins only).

---

## Purpose

Provide full CRUD over `decision_nodes` without exposing admins to SQL.
Critical workflows:

- **Create** a new root (presenting complaint) and its sub-tree top-down.
- **See parallel sub-flows at every level** simultaneously — siblings, not
  just the chosen path. The viewer's drill-down doesn't help here.
- **Edit** any node's label, prompt, rationale, or verdict linkage.
- **Reorder** siblings (sort_order shuffling).
- **Delete** a node and its subtree, with confirmation.
- **Link a leaf to an indication** via search-as-you-type.
- **All changes audited** via `AuditTracker` for accountability.

---

## Why Miller columns (the chosen layout)

The viewer is drill-down — clinically appropriate (one path at a time), but
the wrong shape for authoring. An admin editing "Acute → ACS suspected" needs
to see "Chronic" alongside it without losing their place.

A Xojo Web tree widget doesn't exist; building one from scratch via custom
HTML is heavy. **Miller columns** (Finder-style horizontal cascade of lists)
gives the same affordance with stock `WebListBox`es:

- Each column is a list of siblings at one depth.
- Click a row → the next column populates with that row's children.
- The selected path is highlighted in each column.
- All siblings at every visible depth are visible at once.

Implementation: a fixed number of `WebListBox` columns (start with 4, allow
horizontal scroll for deeper trees) plus a detail panel below them.

---

## UI structure

```
┌─ Decision tree editor ────────────────────────────────────────────────┐
│                                                                       │
│ Roots         Children of    Children of     Children of              │
│               "Chest pain"   "Acute"         "ACS suspected"          │
│ ┌──────────┐  ┌──────────┐   ┌──────────┐    ┌──────────┐             │
│ │Chest pain●│ │Acute    ●│   │ACS susp.●│    │(terminal)│             │
│ │Dyspnoea  │  │Chronic   │   │ACS r/o   │    │           │            │
│ │Palpitatns│  │Recent…   │   │Pericarditis│  │           │            │
│ │Syncope   │  │           │   │           │   │           │           │
│ │Murmur    │  │           │   │           │   │           │           │
│ │+ Add root│  │+ Add child│  │+ Add child│   │+ Add child│            │
│ └──────────┘  └──────────┘   └──────────┘    └──────────┘             │
├───────────────────────────────────────────────────────────────────────┤
│ Selected node: "ACS suspected — ongoing concern"                      │
│                                                                       │
│ Option label:  [ACS suspected — ongoing concern               ]       │
│ Prompt (asked of children, optional):                                 │
│                [____________________________________________]         │
│                                                                       │
│ ○ Branch (asks a question, has children)                              │
│ ● Verdict leaf:                                                       │
│   ● Link to indication:                                               │
│     [Acute MI — assess complications                ▼] [Pick…]        │
│   ○ Custom verdict (only if no indication fits):                      │
│     Verdict ▼  Urgency ▼                                              │
│   Rationale (tree-specific, optional):                                │
│   [Urgent echo to assess regional wall motion, LV function,           │
│    and mechanical complications.                              ]       │
│                                                                       │
│ [Save changes]  [Delete node…]  [↑ Move up]  [↓ Move down]            │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

### Controls (suggested names)

**Header / navigation**
- `wc_header` — standard page header (back arrow, login indicator).
- `lblPageTitle` — "Decision tree editor".

**Columns (4 visible, can scroll horizontally if more depth)**
- `lstCol0`, `lstCol1`, `lstCol2`, `lstCol3` — `WebListBox`es side by side.
  Each row's `RowTagAt(i)` = node ID; `AddRow(node.option_label)`.
  Bottom row of each is a `+ Add child` action (or place as a separate button
  per column).
- `btnAddRoot`, `btnAddCol1`, `btnAddCol2`, … — per-column "add child" buttons,
  shown only when the column has a selected parent.

**Detail panel (single, bottom)**
- `txtOptionLabel` — `WebTextField`. The text shown on the button when
  traversing this option.
- `txtPrompt` — `WebTextField` (multiline). Empty for leaves.
- `radNodeKind` — radio group: `Branch` vs `Verdict leaf` (drives which fields
  are enabled below).
- `radLeafKind` — radio group inside the leaf section: `Linked` vs `Custom`.
- `txtIndicationPicker` — `WebSearchField` with autocomplete bound to
  `indications` (uses the existing fuzzy search). Selecting a row stores the
  `indication_id`.
- `btnPickIndication` — opens a modal indication picker (a stripped-down
  `wp_indications` clone) for the browse-rather-than-search case.
- `popVerdict`, `popUrgency` — for custom verdicts; greyed when linked.
- `txtRationale` — `WebTextArea`.
- `btnSaveNode` — saves the current detail panel back to `decision_nodes`.
- `btnDeleteNode` — confirms then deletes (cascades to children).
- `btnMoveUp`, `btnMoveDown` — swap `sort_order` with adjacent sibling.

---

## Behaviour

### Loading
- `Shown`: populate `lstCol0` from `DecisionNode.GetRoots`. All other columns
  start empty. Detail panel empty.

### Selecting a column
- `lstColN.SelectionChanged`:
  - Read the selected node ID.
  - Populate `lstCol(N+1)` with its children.
  - Clear all columns beyond `N+1`.
  - Populate detail panel with the selected node's fields.
  - Light up the selected dot in column N.

### Add / edit / save
- `+ Add child` button per column → creates a *new node* in memory; detail
  panel becomes blank with the new node's parent set. `Save` persists it.
- `btnSaveNode`:
  - Validation (see below).
  - Pass-through to `DecisionNode.Save(db)` (which decides INSERT vs UPDATE
    based on whether `id = 0`).
  - Wrap in `AuditTracker.LogCreate` or `LogUpdate`.
  - Refresh the column it lives in to reflect the new label / sort.

### Delete
- `btnDeleteNode` → `WebMessageDialog` confirm. Show child count if any
  ("This will also delete N child nodes.").
- On confirm: cascade delete (`ON DELETE CASCADE` already in schema), audit
  the delete, refresh affected columns.

### Reorder
- `btnMoveUp` / `btnMoveDown` swap `sort_order` with the adjacent sibling
  in the same column. Audit each. Refresh column.

### Indication picker
- `txtIndicationPicker.TextChanged` (debounced): query
  `SELECT id, title FROM indications WHERE title LIKE ? OR keywords LIKE ?`
  and populate a small dropdown. Selecting → store the chosen `indication_id`.
- `btnPickIndication` → opens a modal browse dialog. (Optional v1; the
  autocomplete usually suffices.)

---

## Validation rules

Enforced before `Save` succeeds:

1. **`option_label` required.** Every node has a button text.
2. **Branch must have either children or be flagged "branch placeholder"** —
   warn on save if branch has no children; don't block.
3. **Leaf cannot have children.** Switching a branch with children to a leaf
   requires explicit confirmation ("This will leave N orphaned children. Delete
   them too?"). Blocking save until decided.
4. **Linked leaf needs `indication_id`.** Custom leaf needs `verdict`.
5. **Cycle prevention.** No node can be its own ancestor. Currently enforced
   structurally (parent_id only goes up); becomes relevant if/when a DAG model
   is introduced.
6. **Reorder bounds.** `btnMoveUp` disabled at top, `btnMoveDown` disabled at
   bottom.

---

## Audit trail

Every CRUD operation goes through `AuditTracker`:

- `AuditTracker.LogCreate("decision_nodes", id, fieldDict, username)` on insert.
- `AuditTracker.LogUpdate("decision_nodes", id, oldFieldDict, newFieldDict, username)` on update.
- `AuditTracker.LogDelete("decision_nodes", id, fieldDict, username)` on delete.

This gives the admin a clear history in `wp_audit` of who changed what.

---

## What needs adding to `Classes/DecisionNode.xojo_code`

The read-side API exists (`GetRoots`, `GetChildren`, `GetByID`, `IsTerminal`).
For the editor, add:

- `Save(db As MySQLCommunityServer) As Boolean` — INSERT if `id = 0`, UPDATE
  otherwise. Returns success.
- `SaveWithAudit(db, username) As Boolean` — wraps `Save` with `AuditTracker`.
- `Delete(db) As Boolean` and `DeleteWithAudit(db, username) As Boolean` —
  same pattern.
- `GetFieldValues() As Dictionary` — for audit before/after diffing.
- `MoveUp(db) As Boolean`, `MoveDown(db) As Boolean` — adjust `sort_order`.
- `ChildCount(db, id As Integer) As Integer` — used by delete confirmation and
  the "branch has no children" warning.

Mirrors the existing pattern in `Classes/Indication.xojo_code`.

---

## Page entry / wiring

1. Register `wp_cds_editor` in `ECHO_indications.xojo_project` alongside other
   admin pages.
2. Add a segment to `segAdminButtons` on `wc_WebPageHeader`: `"Decision tree"`
   at the end. Update the `Pressed(segmentIndex)` switch to navigate to
   `wp_cds_editor`.

---

## Open questions (deferred)

- **Drag-and-drop reordering.** Up/Down buttons are sufficient for v1. Drag is
  nicer but requires JS plumbing.
- **Shared sub-trees (DAG).** Add only when content authoring shows real
  duplication. Migration is mechanical when needed.
- **Multiple parallel trees per root** (`tree_id` column). Add when a second
  ruleset is on the horizon.
- **Bulk import/export.** Could be a TSV in/out for offline editing. Probably
  unnecessary if the editor itself is good enough.

---

## Implementation status

Nothing built yet. Suggested build order:

1. **Add `Save` / `Delete` / `SaveWithAudit` / `DeleteWithAudit` /
   `GetFieldValues` / `MoveUp` / `MoveDown` to `DecisionNode`.** Small,
   testable in isolation (a couple of SQL inserts via the IDE's run-once code).
2. **Build `wp_cds_editor` shell**: 4 column listboxes + detail panel
   skeleton in the IDE.
3. **Wire selection cascade**: column N selection populates column N+1 + the
   detail panel.
4. **Wire add / save / delete / reorder** with audit calls.
5. **Wire the indication picker** — autocomplete first, modal browse later if
   useful.
6. **Add the segmented-button entry on `wc_WebPageHeader`.**

Rough scope: 400–500 lines of new code + 1 new WebPage + 1 new picker dialog
if you go that route. Comparable to the changelog editor in complexity.

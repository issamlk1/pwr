# task-lifecycle.md
Defines the shape of a task and its three artifacts. Read by all agents.
Default location: .pwr/tasks/<task-id>/ — actual path and git-ignore setting are defined per-project in stack.md (§6 PWR Task Storage).

---
## plan.md (written by @planner)

task_id: <date-slug-or-uuid>
status: planned          # planned | in_progress | in_review | approved | rejected | blocked
retry_count: 0
allowed_files:
  - <file path>

### Objective
<what this task achieves>

### Checklist
- [ ] <step>

### Files to Modify
- `<path>` — <what and why>

### Reuse / Existing Utilities
- <STANDARDS.md #2 reference>

### Acceptance Criteria
- <specific, testable — reviewer checks against this>

### Concerns Raised
- <planner pushback, if any>

---
## log.md (written by @worker)

### Actions Taken
- <file> — <what changed>

### Commands Run

### Checklist Confirmation
- [ ] every plan.md item addressed or flagged skipped w/ reason
- [ ] no files touched outside allowed_files
- [ ] tests run, output above

### Blockers (if any)
- <reason status = blocked, sent back to planner>

---
## review.md (written by @reviewer)

### Verdict
APPROVED | REJECTED

### Checks Performed
- [ ] diff matches allowed_files
- [ ] tests independently re-run — result: <pass/fail>
- [ ] STANDARDS.md compliance — violations: <none, or rule # + detail>

### Fix Instructions (if REJECTED)
- <specific, itemized>
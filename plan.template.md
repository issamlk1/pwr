# plan.template.md
Defines the required shape of every plan.md the planner produces. Path for actual task plans is project-configurable (default: .pwr/tasks/<task-id>/plan.md), set in stack.md if overridden.

---
task_id: <date-slug-or-uuid>
status: planned          # planned | in_progress | in_review | approved | rejected | blocked
retry_count: 0
allowed_files:
  - <file path>
  - <file path>
---

## Objective
<one or two sentences: what this task achieves>

## Checklist
- [ ] <step 1>
- [ ] <step 2>

## Files to Modify
- `<path>` — <what changes and why>

## Reuse / Existing Utilities
- <existing function/file to reuse — STANDARDS.md #2>

## Acceptance Criteria
- <specific, testable — this is what reviewer checks against>

## Concerns Raised (if any)
- <planner's pushback, per planner.md, before writing this plan>
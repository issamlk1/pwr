# STANDARDS.md
Shared law for @worker and @reviewer. Worker writes to this spec; reviewer checks against it line-by-line on every REJECTED verdict.

## 1. Code Cleanliness
- No dead code. No unused imports, variables, or functions.
- No commented-out code left in a diff.
- No debug prints/console.logs left in a diff.
- Every function added must be called somewhere in the diff or explicitly listed in `plan.md` as a public API addition.

## 2. Reuse Before Rewrite
- Before writing new logic, worker must search the existing codebase (`$lib/utils` or project equivalent from `stack.md`) for an existing implementation.
- If a near-duplicate is found, extend/reuse it — do not fork a parallel version.
- Reviewer rejects any diff that reimplements existing logic instead of importing it.

## 3. DRY Enforcement
- Logic used in 2+ places must live in the shared utils location defined in `stack.md`, not be copy-pasted.
- Reviewer flags any duplicated block ≥5 lines appearing in more than one file.

## 4. Function & File Size Limits
- Functions: soft cap 40 lines. Over that → must be split or justified in `plan.md`.
- Files: soft cap 300 lines. Over that → flag for the human, don't auto-split.

## 5. Naming Conventions
- Descriptive, no abbreviations except well-known ones (`id`, `url`, `db`).
- Booleans prefixed `is/has/can`. Functions are verbs (`getUser`, not `userGet`).
- Match casing convention already used in the file being edited — do not introduce a new convention mid-file.

## 6. Comment Policy
- Comments explain *why*, not *what*. If the code needs a comment to explain *what* it does, rewrite the code to be clearer instead.
- No commented-out code, ever (see #1).

## 7. Error Handling
- No silent failures — no empty `catch` blocks, no swallowed errors.
- Errors must be logged or explicitly re-raised with context.

## 8. Testing Requirements
- Every new function with logic (not pure pass-through) needs at least one test.
- Worker cannot mark a task done without tests passing — reviewer verifies via test runner, not by reading code.

## 9. Commit/Diff Hygiene
- One task = one logical change. No unrelated files touched (enforced by `plan.md`'s `allowed_files`, cross-checked here).
- No formatting-only changes bundled with logic changes unless the plan explicitly scopes a cleanup task.


## 10. No Speculative Fallback Chains
- Never write defensive `||`/`??` chains guessing at a data shape (`data.records || data.array || data.data || []`).
- If the actual shape of a variable/API response is unknown, the worker must find the real source (type def, schema, actual API response, existing usage elsewhere in the codebase, or ask the user) and use that — not guess with fallbacks.
- One fallback is acceptable only when it's a deliberate, documented default (e.g. `count ?? 0` where the field is legitimately optional). Anything with more than one `||`/`??` alternative is a red flag — reviewer rejects it and demands the worker confirm the real shape.
- If the shape genuinely cannot be determined from the codebase, worker must stop and ask (via `log.md`/blocked status) rather than paper over it with guesses.

## 11. No Unnecessary Single-Use Helpers
- Do not extract a function/helper unless it is called more than once, OR it makes a genuinely complex block meaningfully clearer on its own.
- Every function that exists must have an obvious reason to exist — readable from its name and call site, without needing to dig through the file to figure out why it's there.
- Inline logic that is only used once and is simple enough to read in place. Don't abstract prematurely "just in case."
- Reviewer rejects any function added to the diff that has exactly one call site and doesn't clearly justify its own existence (e.g. non-obvious logic worth isolating, or matches an existing pattern in the codebase).
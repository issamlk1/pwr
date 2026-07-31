# stack.example.md
Copy this to `stack.md` and fill in for your project. `stack.md` is git-ignored — it's local/per-project, never committed.
If `stack.md` is missing, agents must stop and ask the human to create it from this template — never assume or guess a stack.

## 1. Stack & Directory Context
- **Backend:** <framework/language>
- **Database:** <db engine>
- **Frontend:** <framework>
- **UI/Design system:** <component library, if any>
- **Auth:** <auth provider/method>
- **Package Manager:** <npm / bun / pnpm / poetry / cargo / etc.>
- **Key Directory Conventions:** <e.g. schemas live in /scheme, API routes in /api, etc.>

## 2. Environment & CLI Execution Rules
- **Execution mode:** <native / containerized (Docker, devcontainer, etc.)>
- **FORBIDDEN commands:** <e.g. none, or list commands agents must never run directly>
- **REQUIRED command wrappers** (if containerized/sandboxed), exact templates:
```bash
<example: docker compose run --rm <service> <command>>
```

## 3. Shared Logic Location
- Reusable/shared logic lives in: `<path>`
- Cross-ref: STANDARDS.md #2 (Reuse Before Rewrite) and #3 (DRY Enforcement) apply here.

## 4. Testing & Linting
- **Test command:** `<command>`
- **Lint/format command:** `<command>`
- Worker must run these before marking a task done; reviewer re-runs them independently.

## 5. Deployment / Environment Notes
- **Env var convention:** <e.g. .env.local for dev, never commit secrets>
- **Deploy target:** <e.g. Vercel, self-hosted, N/A>

## 6. PWR Task Storage
- **Task directory:** `<default: .pwr/tasks/>` — override if you want tasks stored elsewhere or committed instead of git-ignored.
- **Git-ignored:** `<yes/no>` — default yes; set no if you want task history version-controlled for this project.
# PWR — Planner, Worker, Reviewer

A lightweight, file-based protocol for running AI coding agents on solo and small-team projects. No corporate orchestration layer, no complex runtime — just three disciplined roles, a shared rulebook, and files on disk that keep everyone (human included) honest.

If you've ever had an agent silently rewrite half your codebase, fabricate a command output, or approve its own broken work — this is an attempt to stop that.

## Why

Most agent frameworks assume a team, a budget, and infrastructure most solo devs and small teams don't have. PWR assumes the opposite: one person, real stakes, and an agent that needs guardrails more than it needs features.

The core idea is simple: **no single agent plans, builds, and approves its own work.** Every task passes through three separate roles with different tools, different personalities, and no ability to shortcut each other.

## How it works

```
Task submitted
      ↓
  @planner   → reads the codebase, writes plan.md (read-only, no code)
      ↓
  @worker    → implements exactly what's in plan.md (writes code, runs commands)
      ↓
  @reviewer  → audits the diff against plan.md and STANDARDS.md (read-only, no fixes)
      ↓
  APPROVED → done        REJECTED → back to @worker (max 3 retries, then human)
```

Every task gets its own folder (`.pwr/tasks/<task-id>/`, git-ignored by default) containing `plan.md`, `log.md`, and `review.md` — a full paper trail of what was asked, what was done, and what was checked.

## The files

| File | Purpose | Shared? |
|---|---|---|
| `AGENTS.md` | The constitution — roles, boundaries, retry limits, human approval gates | All 3 agents |
| `STANDARDS.md` | Shared code-quality law (no dead code, no fallback-chain guessing, no single-use helpers, etc.) | Worker + Reviewer |
| `stack.example.md` | Template for your project's stack, commands, and conventions | Copy to `stack.md` per project (git-ignored) |
| `agents/planner.md` | Planner's personality — pushes back on bad requests instead of yes-manning | Planner only |
| `agents/worker.md` | Worker's personality — minimal diffs, total instruction coverage, never fabricates output | Worker only |
| `agents/reviewer.md` | Reviewer's personality — skeptical by default, verifies independently, never rubber-stamps | Reviewer only |
| `task-lifecycle.md` | The required shape of `plan.md`, `log.md`, and `review.md` | All 3 agents |

Each agent loads: `AGENTS.md` → `STANDARDS.md` → `stack.md` → its own personality file → `task-lifecycle.md`. No agent reads another agent's personality file.

## Getting started

1. Clone this repo into your project (or copy the files in).
2. Copy `stack.example.md` → `stack.md` and fill it in for your project. Keep it git-ignored — it's local, per-project config.
3. Wire the role files into your agent runtime of choice (Claude Code, a custom orchestrator, etc.) so each role loads the right context stack.
4. Give the planner a task and let the loop run.

## Design principles

- **No agent grades its own homework.** Planner can't code, worker can't approve, reviewer can't fix.
- **Nothing is trusted without verification.** Reviewer re-runs tests itself rather than believing the worker's log.
- **Humans stay in control of anything destructive** — deletions, secrets, dependency changes, and CI config all require explicit sign-off.
- **Blocked tasks stay blocked until a human says otherwise.** Agents never self-unblock.
- **Small and boring on purpose.** This is meant to be readable and forkable by one person, not administered by a platform team.

## Status

Early / actively evolving. The rule files grow as new failure modes get discovered in practice — that's expected and welcome.

## Contributing

Found a new way an agent misbehaves? Open an issue or PR against `STANDARDS.md` or the relevant `<role>.md` — most improvements to this project are just better-worded rules, not code.

## License

MIT (or your license of choice — update this before publishing).
# OpenCode aliases (already natively run directly in terminal)
alias ai="opencode run"
alias ds="opencode run -m deepseek/deepseek-v4-pro"
alias flash="opencode run -m google/gemini-3.6-flash"

# Codex / OpenAI CLI (uses 'exec' or prompt flag to run directly in terminal)
alias codex="codex exec"

# Aider (uses --message/--no-auto-commits to run a single prompt in terminal without entering REPL)
alias aider="aider --no-auto-commits --message"
# Usage: pwr planner ai
# Usage: pwr worker codex
# Usage: pwr reviewer aider
function pwr() {
  local role=$1
  local tool=${2:-ai}
  local msg="You are @$role defined in AGENTS.md."
  echo "=== Launching @$role using $tool ==="
  eval "$tool -f AGENTS.md \"\$msg\""
}
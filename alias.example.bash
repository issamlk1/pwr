# Usage: pwr planner aider/codex/claude..
# Usage: pwr worker aider/codex/claude..
# Usage: pwr reviewer aider/codex/claude..
function pwr() {
  local role=$1
  local tool=${2:-opencode}
  local msg="You are @$role defined in AGENTS.md."

  echo "=== Launching @$role using $tool ==="

  if [ "$tool" = "opencode" ]; then
    opencode run -f AGENTS.md "$msg"
  else
    $tool --read AGENTS.md --message "$msg"
  fi
}
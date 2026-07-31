# Usage: pwr planner aider/codex/claude..
# Usage: pwr worker aider/codex/claude..
# Usage: pwr reviewer aider/codex/claude..
function pwr() {
  local role=$1
  local tool=${2:-aider} 
  echo "=== Launching @$role using $tool ==="
  $tool --read AGENTS.md --message "You are @$role defined in AGENTS.md."
}
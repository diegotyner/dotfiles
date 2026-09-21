#!/bin/bash
# This script needs to be linked in ~/.claude/settings.json
# Add: "statusLine": { "type": "command", "command": "~/.claude/statusline.sh" }

input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
EFFORT=$(echo "$input" | jq -r '.effort.level // empty')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
FIVE_H=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
WEEK=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

CYAN='\033[36m'; GREEN='\033[32m'; YELLOW='\033[33m'; RED='\033[31m'; RESET='\033[0m'

# round a float string to a whole-number percent
round() { printf "%.0f" "$1"; }

# pick a color for a given percentage
color_for() {
  p="$1"
  if [ "$p" -ge 90 ]; then echo "$RED"
  elif [ "$p" -ge 70 ]; then echo "$YELLOW"
  else echo "$GREEN"; fi
}

# build a 10-char bar for a given percentage
make_bar() {
  p="$1"
  FILLED=$((p / 10)); EMPTY=$((10 - FILLED))
  printf -v FILL "%${FILLED}s"; printf -v PAD "%${EMPTY}s"
  echo "${FILL// /█}${PAD// /░}"
}

PCT_INT=$(round "$PCT")
PCT_COLOR=$(color_for "$PCT_INT")
PCT_BAR=$(make_bar "$PCT_INT")

EFFORT_STR=""
[ -n "$EFFORT" ] && EFFORT_STR=" ($EFFORT)"

# rate limits: only build a segment if the field is present
RL_STR=""
if [ -n "$FIVE_H" ]; then
  FIVE_H_INT=$(round "$FIVE_H")
  FIVE_H_COLOR=$(color_for "$FIVE_H_INT")
  RL_STR="${RL_STR} | ${FIVE_H_COLOR}5h ${FIVE_H_INT}%${RESET}"
fi
if [ -n "$WEEK" ]; then
  WEEK_INT=$(round "$WEEK")
  WEEK_COLOR=$(color_for "$WEEK_INT")
  RL_STR="${RL_STR} | ${WEEK_COLOR}7d ${WEEK_INT}%${RESET}"
fi

BRANCH=""
git rev-parse --git-dir > /dev/null 2>&1 && BRANCH=" | 🌿 $(git branch --show-current 2>/dev/null)"

echo -e "${CYAN}[$MODEL]$EFFORT_STR${RESET} | 📁 ${DIR##*/}$BRANCH"
echo -e "${PCT_COLOR}${PCT_BAR}${RESET} ${PCT_INT}%${RL_STR}"

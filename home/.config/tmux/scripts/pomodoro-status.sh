#!/usr/bin/env bash

set -u

pomodoro_script="${TMUX_PLUGIN_MANAGER_PATH:-$HOME/.local/share/tmux/plugins}/tmux-pomodoro-plus/scripts/pomodoro.sh"
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/tmux_pomodoro_plus"
last_status_file="$cache_dir/last_break_status"
lock_dir="$cache_dir/break_notification.lock"
status_file="/tmp/pomodoro/current_status.txt"

# The plugin removes this file when the timer is inactive, so avoid starting
# the plugin and touching the cache on ordinary status refreshes.
if [ ! -f "/tmp/pomodoro/start_time.txt" ]; then
	[ -f "$last_status_file" ] && rm "$last_status_file"
	exit 0
fi

mkdir -p "$cache_dir"

# Avoid duplicate announcements when tmux evaluates the status for multiple clients.
if ! mkdir "$lock_dir" 2>/dev/null; then
	 exec bash "$pomodoro_script"
fi
trap 'rmdir "$lock_dir"' EXIT

status_output=$(bash "$pomodoro_script")
printf '%s' "$status_output"

if [ -r "$status_file" ]; then
	current_status=$(<"$status_file")
else
	current_status="idle"
fi

previous_status=""
if [ -r "$last_status_file" ]; then
	previous_status=$(<"$last_status_file")
fi

case "$current_status" in
	waiting_for_break|break|long_break)
	case "$previous_status" in
		waiting_for_break|break|long_break) ;;
		*)
			if command -v say >/dev/null 2>&1; then
				say "Time to take a break." >/dev/null 2>&1 &
			fi
			;;
		esac
		;;
esac

printf '%s\n' "$current_status" >"$last_status_file"

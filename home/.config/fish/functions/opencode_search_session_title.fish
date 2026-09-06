function opencode_search_session_title --description 'Open OpenCode session by title text search'
if test (count $argv) -lt 1
        echo "Usage: opencode_search_session_title <search text>" >&2
        return 1
    end

    set -l search_text (string join ' ' -- $argv)
    set -l escaped_search $search_text
    set escaped_search (string replace -a '\\' '\\\\' -- $escaped_search)
    set escaped_search (string replace -a '%' '\\%' -- $escaped_search)
    set escaped_search (string replace -a '_' '\\_' -- $escaped_search)
    set escaped_search (string replace -a "'" "''" -- $escaped_search)
    set -l sql "
SELECT
    id,
    datetime(time_updated / 1000, 'unixepoch', 'localtime') || ' | ' || title || ' | ' || replace(directory, '$HOME', '~') AS label
FROM session
WHERE time_archived IS NULL
    AND parent_id IS NULL
    AND lower(title) LIKE '%' || lower('$escaped_search') || '%' ESCAPE '\\'
ORDER BY time_updated DESC;
"

    _opencode_open_match_query "$search_text" "No session found for '$search_text'" "$sql"
end


function _opencode_open_match_query --argument-names prompt not_found_message sql
    set -l db_path "$HOME/.local/share/opencode/opencode.db"
    if functions -q _opencode_session_db
        set -l resolved_db_path (_opencode_session_db)
        if test -n "$resolved_db_path"
            set db_path $resolved_db_path
        end
    end

    if not test -f $db_path
        echo "OpenCode database not found at $db_path" >&2
        return 1
    end

    set -l tab (printf '\t')
    set -l matches (sqlite3 -separator $tab $db_path $sql)
    if test $status -ne 0
        echo "Failed to query OpenCode sessions" >&2
        return 1
    end

    if test (count $matches) -eq 0
        echo $not_found_message >&2
        return 1
    end

    if test (count $matches) -eq 1
        set -l session_id (string split -m 1 -- $tab $matches[1])[1]
        command opencode --session $session_id
        return $status
    end

    set -l selection (
        printf '%s\n' $matches |
        fzf --delimiter=$tab --with-nth=2 --prompt "$prompt > "
    )

    if test -z "$selection"
        return 0
    end

    set -l session_id (string split -m 1 -- $tab $selection)[1]
    command opencode --session $session_id
end

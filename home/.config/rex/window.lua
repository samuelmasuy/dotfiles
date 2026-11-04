rex.action({
  name = "split_from_git_root",
  title = "Split Pane at Git Root",
  args = { direction = "string" },
  run = function(ctx, args)
    if ctx.server then
      error("Git-root splits are only supported on the local server", 0)
    end
    if not ctx.block_id then
      error("No focused terminal pane", 0)
    end

    local process, err = rex.block.call("com.superlogical.terminal", "process", {
      block_id = ctx.block_id,
    })
    if not process then
      error(err, 0)
    end
    local cwd = process.foreground and process.foreground.cwd
    if not cwd then
      error("Could not determine the focused terminal's working directory", 0)
    end

    local git = rex.exec({ "git", "rev-parse", "--show-toplevel" }, {
      cwd = cwd,
      stderr = false,
    })
    if git and git.ok then
      cwd = git.stdout:gsub("\n+$", "")
    end

    local split, split_err = rex.session.new_split({
      anchor_id = ctx.block_id,
      direction = args.direction,
      side = "after",
      focus = true,
      layout = rex.layout.block({
        flavor = "com.superlogical.terminal.shell",
        options = { cwd = cwd, shell = "/opt/homebrew/bin/fish" },
      }),
    })
    if not split then
      error(split_err, 0)
    end
    return split
  end,
})

rex.action({
  name = "swap_tab",
  title = "Swap Tab with Neighbor",
  args = { direction = "string" },
  run = function(ctx, args)
    if not ctx.block_id then
      error("No focused pane", 0)
    end
    local block, block_err = rex.session.describe_block({ block_id = ctx.block_id })
    if not block then
      error(block_err, 0)
    end
    local view, view_err = rex.session.view({})
    if not view then
      error(view_err, 0)
    end
    local windows = view.windows or {}
    local index
    for i, window in ipairs(windows) do
      if window.window_id == block.block.window_id then
        index = i
        break
      end
    end
    if not index then
      error("The focused pane is not in a tab", 0)
    end
    if #windows < 2 then
      return
    end

    local function move(window_id, before_window_id)
      local result, err = rex.session.move_window({
        window_id = window_id,
        before_window_id = before_window_id,
      })
      if not result then
        error(err, 0)
      end
    end

    if args.direction == "backward" and index > 1 then
      move(windows[index].window_id, windows[index - 1].window_id)
    elseif args.direction == "forward" and index < #windows then
      move(windows[index + 1].window_id, windows[index].window_id)
    elseif (args.direction == "backward" and index == 1) or (args.direction == "forward" and index == #windows) then
      move(windows[#windows].window_id, windows[1].window_id)
      move(windows[1].window_id, nil)
    else
      error("Direction must be backward or forward", 0)
    end
  end,
})

local function is_vim(ctx)
  local proc = rex.block.call("com.superlogical.terminal", "process", { block_id = ctx.block_id })
  local fg = proc and proc.foreground
  if not fg then
    return false
  end
  -- `name` is not always the executable's name, so check `argv0` too
  for _, s in ipairs({ fg.name or "", (fg.argv0 or ""):match("[^/]*$") }) do
    if s:match("^n?vim") then
      return true
    end
  end
  return false
end

for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
  rex.bind("ctrl+" .. key, function(ctx)
    if is_vim(ctx) then
      return false
    end
    rex.session.focus_direction({ direction = direction })
    return true
  end)
end

rex.action({
  name = "smart_splits_resize",
  title = "Smart Splits: Resize Pane",
  run = function(ctx, args)
    if is_vim(ctx) then
      rex.client.queue("pane.send_key", { key = args.key })
    else
      rex.client.queue("pane.resize", { direction = args.direction, amount = 3 })
    end
  end,
})

local function md_viewer_pane(block)
  if block == nil then
    return false
  end
  local terminal = "com.superlogical.terminal"
  local process = rex.block.call(terminal, "process", { block_id = block })
  if process ~= nil then
    return process.foreground ~= nil and process.foreground.name == "md-viewer"
  end
  local listed = rex.session.list_blocks({})
  for _, entry in ipairs((listed or {}).blocks or {}) do
    if entry.block_id == block then
      return entry.label == "md-viewer"
    end
  end
  return false
end

rex.action({
  name = "md_viewer_find",
  title = "Find (md-viewer aware)",
  description = "Opens md-viewer's find in an md-viewer pane and Rex's Find everywhere else.",
  run = function(ctx, args)
    if md_viewer_pane(ctx.block_id) then
      local _, err =
        rex.block.call("com.superlogical.terminal", "write", { block_id = ctx.block_id, data = "\27[102;9u" })
      if err == nil then
        return { target = "md-viewer" }
      end
    end
    rex.client.queue("client.find.open")
    return { target = "rex" }
  end,
})

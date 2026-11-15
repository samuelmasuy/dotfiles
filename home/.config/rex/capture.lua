-- Browse a snapshot without sending commands to the running terminal program.
rex.action({
  name = "browse_capture",
  title = "Browse Pane Capture in Neovim",
  description = "Select and copy terminal output in a floating Neovim viewer; q closes it.",
  run = function(ctx)
    local terminal = "com.superlogical.terminal"
    local placement, err = rex.session.describe_block({ block_id = ctx.block_id })
    if not placement then
      error(err, 0)
    end
    if not placement.block.window_id then
      error("The captured pane must belong to a window", 0)
    end

    -- Read in chunks so a long scrollback cannot exceed an API reply's limit.
    local capture
    capture, err = rex.block.call(terminal, "format", {
      format = "text",
      trim = true,
      unwrap = true,
      max_bytes = 524288,
    })
    if not capture then
      error(err, 0)
    end

    local temp
    temp, err = rex.exec({ "/usr/bin/mktemp", "-t", "rex-capture" })
    if not temp then
      error(err, 0)
    end
    if not temp.ok then
      error(temp.stderr, 0)
    end
    local path = temp.stdout:gsub("[\r\n]+$", "")
    local file
    local ok, result = pcall(function()
      file = assert(io.open(path, "wb"))
      assert(file:write(capture.content))
      local offset = #capture.content
      if capture.id then
        while true do
          local chunk, chunk_err = rex.block.call(terminal, "blob_read", {
            id = capture.id,
            offset = offset,
            max_bytes = 524288,
          })
          if not chunk then
            error(chunk_err, 0)
          end
          assert(file:write(chunk.data))
          offset = offset + #chunk.data
          if chunk.eof then
            break
          end
          if #chunk.data == 0 then
            error("Capture returned an empty chunk", 0)
          end
        end
      end
      assert(file:close())

      local nvim
      nvim, err = rex.exec({ "/bin/zsh", "-lc", "mise which nvim" })
      if not nvim then
        error(err, 0)
      end
      if not nvim.ok or nvim.stdout == "" then
        error(nvim.stderr ~= "" and nvim.stderr or "nvim was not found via mise", 0)
      end
      local nvim_path = nvim.stdout:gsub("[\r\n]+$", "")

      -- The viewer removes its private temporary file as soon as it loads.
      -- Use a clean Neovim instance so capture text is not treated as code.
      local viewer_setup = [[lua
                vim.fn.delete(vim.api.nvim_buf_get_name(0))
                vim.api.nvim_buf_set_name(0, 'Rex capture')
                vim.bo.buftype = 'nofile'
                vim.bo.modifiable = false
                vim.opt.clipboard = 'unnamedplus'
                vim.keymap.set('n', 'q', '<cmd>qa!<CR>')
                vim.api.nvim_win_set_cursor(0, {vim.api.nvim_buf_line_count(0), 0})
            ]]
      local layer, layer_err = rex.session.new_layer({
        window_id = placement.block.window_id,
        bounds = { 0.025, 0.025, 0.95, 0.95 },
        focus = true,
        layout = rex.layout.block({
          flavor = "com.superlogical.terminal.shell",
          options = {
            shell = "none",
            command = {
              nvim_path,
              "--clean",
              "-n",
              "-R",
              "--cmd",
              "set nomodeline",
              "-c",
              viewer_setup,
              "--",
              path,
            },
            exit = { on_completion = true },
          },
        }),
      })
      if not layer then
        error(layer_err, 0)
      end
      return layer
    end)
    if not ok then
      pcall(function()
        file:close()
      end)
      os.remove(path)
      error(result, 0)
    end
    return result
  end,
})

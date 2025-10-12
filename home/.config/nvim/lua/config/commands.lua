vim.api.nvim_create_user_command("MasonUpgrade", function()
  local registry = require("mason-registry")
  registry.refresh()
  registry.update()
  local packages = registry.get_all_packages()
  for _, pkg in ipairs(packages) do
    if pkg:is_installed() then
      pkg:install()
    end
  end
  vim.cmd("doautocmd User MasonUpgradeComplete")
end, { force = true })

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyCheck",
  -- pattern = "LazyVimStarted",
  desc = "Update lazy.nvim plugins",
  callback = function(_)
    local start_time = os.clock()
    require("lazy").sync({ wait = false, show = false })
    local end_time = os.clock()
    -- total time in ms (end_time - start_time) where there are 4 decimal places
    local total_time = string.format("%.4f", (end_time - start_time) * 1000)
    print("Lazy plugins synced in " .. total_time .. "ms")
  end,
})

-- Mason tools update completed autocommand
vim.api.nvim_create_autocmd("User", {
  pattern = "MasonToolsUpdateCompleted",
  callback = function(e)
    vim.schedule(function()
      print(vim.inspect(e.data)) -- print the table that lists the programs that were installed
    end)
  end,
})

-- Colorscheme picker user command (Snacks)
vim.api.nvim_create_user_command("Color", function()
  require("snacks").picker.colorschemes({})
end, { desc = "Open colorscheme picker" })

-- Git brwowse command (Snacks)
-- Usage: :Gbrowse
vim.api.nvim_create_user_command("Gbrowse", function()
  Snacks.gitbrowse()
end, { range = true, desc = "Open Git browse for current file/selection" })

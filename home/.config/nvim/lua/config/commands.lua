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
  callback = function(event)
    local start_time = os.clock()
    require("lazy").sync({ wait = false, show = false })
    local end_time = os.clock()
    print("Lazy plugins synced in " .. (end_time - start_time) * 1000 .. "ms")
  end,
})

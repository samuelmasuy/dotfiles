require("keys")

local ok, workforge = pcall(require, "workforge")
if ok and workforge then
  workforge({
    agent = "opencode",
  })
end

local ok_rar, rar = pcall(require, "rex_agent_restore")
if ok_rar and type(rar) == "table" then
  rar.setup({ bin = "/opt/homebrew/bin/rex-agent-restore" })
end

require("keys")
require("extensions.tab-numbers")

local ok, workforge = pcall(require, "workforge")
if ok and workforge then
  workforge({
    agent = "opencode",
  })
end

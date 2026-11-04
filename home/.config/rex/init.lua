require("keys")

dofile((os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config") .. "/rex/workforge.lua")({
  agent = "opencode", -- executable name or path, not a command with arguments
})

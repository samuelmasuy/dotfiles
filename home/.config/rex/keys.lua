-- Tmux style bindings
rex.bind("ctrl+a>ctrl+a", "pane.send_key", { key = "ctrl+a" })
rex.bind("ctrl+a>c", "client.tab.new")
rex.bind("ctrl+a>,", "client.tab.rename")
rex.bind("ctrl+a>x>y", "pane.close")
rex.bind("ctrl+a>n", "client.tab.next")
rex.bind("ctrl+a>p", "client.tab.previous")
rex.bind("ctrl+a>shift+=", "pane.zoom")
rex.bind("ctrl+a>r", "client.config.reload")

-- Window management
require("window")
rex.bind("ctrl+a>shift+\\", "split_from_git_root", { direction = "horizontal" })
rex.bind("ctrl+a>shift+-", "split_from_git_root", { direction = "vertical" })
for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
  rex.bind("alt+" .. key, "smart_splits_resize", { key = "alt+" .. key, direction = direction })
end
rex.bind("ctrl+a>h", "swap_tab", { direction = "backward" })
rex.bind("ctrl+a>l", "swap_tab", { direction = "forward" })

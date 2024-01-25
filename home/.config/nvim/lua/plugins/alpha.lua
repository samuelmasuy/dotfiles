return {
  {
    "goolord/alpha-nvim",
    event = "BufEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("sam.startup.screen")
    end,
  },
}

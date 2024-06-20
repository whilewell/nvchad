vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "
vim.opt.list = true
vim.g.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,cp936,latin1"

-- bootstrap lazy and all plugins
print(vim.fn.stdpath('data'))
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "<url id="" type="url" status="parsing" title="" wc="0">https://kkgithub.com/folke/lazy.nvim.git&#34;,</url> 
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
  {
    "dhananjaylatkar/cscope_maps.nvim",
    dependencies = {
      "folke/which-key.nvim", -- optional [for whichkey hints]
      "nvim-telescope/telescope.nvim", -- optional [for picker="telescope"]
      "ibhagwan/fzf-lua", -- optional [for picker="fzf-lua"]
      "nvim-tree/nvim-web-devicons", -- optional [for devicons in telescope or fzf]
    },
    opts = {
    -- USE EMPTY FOR DEFAULT OPTIONS
    -- DEFAULTS ARE LISTED BELOW
    },
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d>, <sha>',
    },
  },
  {
    "fraso-dev/nvim-listchars", config = true
  },
  {
    'dwrdx/mywords.nvim',
  },
  {
    "mbbill/fencview",
  }
}
}, lazy_config)

require("cscope_maps").setup()

require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
vim.keymap.set("n", "<leader>at", "<cmd>AerialToggle!<CR>")

require("telescope").load_extension("aerial")
require("nvim-tree").setup({
   update_focused_file = {
     enable = true,
     update_root = true,
   },
})

require("colorizer").setup()

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)
require("ibl").setup { indent = { highlight = highlight } }

vim.keymap.set("n", "<leader>mm", "<cmd>lua require'mywords'.hl_toggle()<CR>")
vim.keymap.set("n", "<leader>mc", "<cmd>lua require'mywords'.uhl_all()<CR>")
vim.keymap.set("n", "<leader>ec", "<cmd>e ++enc=cp936<CR>")

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

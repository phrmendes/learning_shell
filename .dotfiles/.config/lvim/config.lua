-----------------------------------------------------------------------------------
--  _  _  _ __  _  __  ___ _   _ _ __ __    __ ___ _____ _____ _ __  _  __  __   --
-- | || || |  \| |/  \| _ | \ / | |  V  | /' _| __|_   _|_   _| |  \| |/ _/' _/  --
-- | || \/ | | ' | /\ | v `\ V /| | \_/ | `._`| _|  | |   | | | | | ' | [/`._`.  --
-- |___\__/|_|\__|_||_|_|_\ \_/ |_|_| |_| |___|___| |_|   |_| |_|_|\__|\__|___/  --
-----------------------------------------------------------------------------------

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
vim.o.guifont = "SauceCodePro Nerd Font Mono"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  }
}

-- use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["S"] = { "<cmd>lua require('spectre').open()<CR>", "Spectre" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" }
}

-- after changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.treesitter.highlight.enabled = true

-- parsers
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "json",
  "lua",
  "python",
  "yaml",
  "go",
  "hcl"
}

-- lsp settings
lvim.lsp.automatic_servers_installation = true
lvim.format_on_save = true

-- Additional Plugins
lvim.plugins = {
  -- motion plugin
  {
    "ggandor/lightspeed.nvim",
    event = "BufRead"
  },
  -- jump to specific line
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup({
        show_numbers = true,
        show_cursorline = true
      })
    end
  },
  -- quickfix window
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufRead", "BufNew" },
    config = function()
      require("bqf").setup({
        auto_enable = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
        },
        func_map = {
          vsplit = "",
          ptogglemode = "z,",
          stoggleup = "",
        },
        filter = {
          fzf = {
            action_for = { ["ctrl-s"] = "split" },
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
          },
        }
      })
    end
  },
  -- search and replace
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end
  },
  -- navigate and highlight matching words
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },
  -- git diff view
  {
    "sindrets/diffview.nvim",
    event = "BufRead"
  },
  -- git blame in buffer lines
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      vim.g.gitblame_enabled = 1
    end
  },
  -- show current function at the top of the screen when function does not fit in screen
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        throttle = true,
        max_lines = 0,
        patterns = {
          default = {
            "class",
            "function",
            "method"
          }
        }
      })
    end
  },
  -- previewing goto definition calls
  {
    "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup({
        width = 120; -- width of the floating window
        height = 25; -- height of the floating window
        default_mappings = false; -- bind default mappings
        debug = false; -- print debug information
        opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil; -- a function taking two arguments, a buffer and a window to be ran as a hook.
        vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>");
        vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>");
        vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
      })
    end
  },
  -- hint when you type
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").on_attach()
    end
  },
  -- a tree like view for symbols
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end
  },
  -- diagnostics, references, telescope results, quickfix and location lists
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle"
  },
  -- interactive scratchpad
  {
    "metakirby5/codi.vim",
    cmd = "Codi"
  },
  -- highlight and search for todo comments
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end
  },
  -- markdown
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end
  },
  -- zen mode
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup()
    end
  },
  -- literate
  { "zyedidia/literate.vim" },
  -- ranger
  {
    "kevinhwang91/rnvimr",
    cmd = "RnvimrToggle",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
    end
  },
  -- smooth scrolling
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require("neoscroll").setup({
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true,
        stop_eof = true,
        use_local_scrolloff = false,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        easing_function = nil,
        pre_hook = nil,
        post_hook = nil
      })
    end
  },
  -- personal database
  { "vimwiki/vimwiki" }
}

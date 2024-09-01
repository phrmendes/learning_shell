{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options.neovim.enable = lib.mkEnableOption "enable neovim";

  config = lib.mkIf config.neovim.enable {
    programs.neovim = let
      fromGitHub = pname: src:
        pkgs.vimUtils.buildVimPlugin {
          inherit src pname;
          version = src.rev;
        };
      luasnip-latex-snippets = fromGitHub "luasnip-latex-snippets" inputs.luasnip-latex-snippets;
      curl-nvim = fromGitHub "curl.nvim" inputs.curl-nvim;
      zotcite = fromGitHub "zotcite" inputs.zotcite;
      cmp-zotcite = fromGitHub "cmp-zotcite" inputs.cmp-zotcite;
    in {
      enable = true;
      package = pkgs.neovim-unwrapped;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = false;
      plugins =
        (with pkgs.vimPlugins; [
          SchemaStore-nvim
          ansible-vim
          better-escape-nvim
          cmp-buffer
          cmp-cmdline
          cmp-dap
          cmp-emoji
          cmp-latex-symbols
          cmp-nvim-lsp
          cmp-nvim-lsp-signature-help
          cmp-pandoc-nvim
          cmp-path
          cmp_luasnip
          conform-nvim
          copilot-cmp
          copilot-lua
          dial-nvim
          dressing-nvim
          friendly-snippets
          fzfWrapper
          image-nvim
          lazydev-nvim
          lazygit-nvim
          lspkind-nvim
          ltex_extra-nvim
          luasnip
          markdown-nvim
          markdown-preview-nvim
          mini-nvim
          nabla-nvim
          neogen
          nvim-bqf
          nvim-cmp
          nvim-colorizer-lua
          nvim-dap
          nvim-dap-python
          nvim-dap-ui
          nvim-dap-virtual-text
          nvim-lint
          nvim-lspconfig
          nvim-pqf
          nvim-treesitter-context
          nvim-treesitter-textobjects
          nvim-treesitter.withAllGrammars
          nvim-ts-autotag
          nvim-ts-context-commentstring
          obsidian-nvim
          refactoring-nvim
          smart-splits-nvim
          toggleterm-nvim
          undotree
          vim-abolish
          vim-dadbod
          vim-dadbod-completion
          vim-dadbod-ui
          vim-eunuch
          vim-helm
          vim-helm
          vim-jinja
          vim-rsi
          vim-sleuth
          vim-slime
          yanky-nvim
          zen-mode-nvim
        ])
        ++ [
          cmp-zotcite
          curl-nvim
          luasnip-latex-snippets
          zotcite
        ];
      extraLuaPackages = luaPkgs:
        with luaPkgs; [
          jsregexp
          magick
          nui-nvim
          plenary-nvim
          sqlite
        ];
      extraPython3Packages = pythonPkgs:
        with pythonPkgs; [
          debugpy
          poppler-qt5
          pynvim
          pyqt5
          pyyaml
        ];
      extraPackages = with pkgs;
        [
          alejandra
          ansible-language-server
          ansible-lint
          autotools-language-server
          basedpyright
          bash-language-server
          deadnix
          dockerfile-language-server-nodejs
          dot-language-server
          elixir-ls
          emmet-language-server
          hadolint
          helm-ls
          ltex-ls
          lua-language-server
          neovim-remote
          nginx-language-server
          nixd
          ruff
          shellcheck
          shellharden
          sqlfluff
          sqls
          stylua
          taplo
          terraform-ls
          texlab
          tflint
          ueberzugpp
          vscode-langservers-extracted
          yaml-language-server
        ]
        ++ (with nodePackages_latest; [
          prettier
          vscode-json-languageserver
        ]);
    };

    xdg.configFile = {
      "nvim" = {
        source = ../dotfiles/nvim;
        recursive = true;
      };
      "nvim/lua/base16.lua".text = with config.lib.stylix.colors.withHashtag;
      # lua
        ''
          return {
              palette = {
                  base00 = "${base00}",
                  base01 = "${base01}",
                  base02 = "${base02}",
                  base03 = "${base03}",
                  base04 = "${base04}",
                  base05 = "${base05}",
                  base06 = "${base06}",
                  base07 = "${base07}",
                  base08 = "${base08}",
                  base09 = "${base09}",
                  base0A = "${base0A}",
                  base0B = "${base0B}",
                  base0C = "${base0C}",
                  base0D = "${base0D}",
                  base0E = "${base0E}",
                  base0F = "${base0F}",
              },
          }
        '';
    };
  };
}

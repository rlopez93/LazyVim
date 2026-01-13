-- lua/plugins/plugins.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--background-index-priority=background",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--header-insertion-decorators",
            "--completion-style=bundled",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            "--parse-forwarding-functions",
            "--malloc-trim",
            "--use-dirty-headers",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
      },
      setup = {
        clangd = function(_, opts)
          local ext_opts = LazyVim.opts("clangd_extensions.nvim") or {}

          local merged = vim.tbl_deep_extend("force", ext_opts, { server = opts })

          require("clangd_extensions").setup(merged)
          return false
        end,
      },
    },
  },

  {
    "folke/sidekick.nvim",
    init = function()
      vim.env.EDITOR = "nvr -cc tabnew --remote-wait"
      vim.env.VISUAL = vim.env.EDITOR
    end,
    opts = {
      -- Disable Copilot NES; keep only CLI integration.
      nes = { enabled = false },
      copilot = { status = { enabled = false } },

      cli = {
        watch = true,
        picker = "snacks",
        win = {
          layout = "float",
          float = { width = 0.9, height = 0.9 },
        },
        mux = {
          enabled = true,
          backend = "tmux",
        },
        tools = {
          codex = {
            cmd = { "codex" },
          },
        },
      },
    },
    keys = {
      {
        "<leader>a",
        "",
        desc = "+ai",
        mode = { "n", "v" },
      },
      -- {
      --   "<c-.>",
      --   function()
      --     require("sidekick.cli").toggle({ name = "codex" })
      --   end,
      --   desc = "Sidekick Toggle Codex",
      --   mode = { "n", "t", "i", "x" },
      -- },
      -- {
      --   "<leader>aT",
      --   function()
      --     require("sidekick.cli").select({ name = "codex" })
      --   end,
      --   desc = "Select Codex",
      -- },
      {
        "<leader>aT",
        function()
          require("sidekick.cli").toggle({ name = "codex" })
        end,
        desc = "Toggle Codex",
      },
      {
        "<leader>ac",
        function()
          require("sidekick.cli").close({ name = "codex" })
        end,
        desc = "Close Codex",
      },
      {
        "<leader>aP",
        function()
          require("sidekick.cli").prompt()
        end,
        desc = "Prompt",
        mode = { "n", "x" },
      },
      {
        "<leader>aF",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Send File",
      },
      {
        "<leader>av",
        function()
          require("sidekick.cli").send({ msg = "{selection}" })
        end,
        desc = "Send Selection",
        mode = { "x" },
      },
      {
        "<leader>as",
        function()
          require("sidekick.cli").select()
        end,
        desc = "CLI Select",
      },
      {
        "<leader>as",
        function()
          require("sidekick.cli").show()
        end,
        desc = "CLI Show",
      },
      {
        "<leader>ah",
        function()
          require("sidekick.cli").hide()
        end,
        desc = "CLI Hide",
      },
      {
        "<leader>af",
        function()
          require("sidekick.cli").focus()
        end,
        desc = "CLI Focus",
      },
      {
        "<leader>am",
        function()
          local cli = require("sidekick.cli")
          vim.ui.input({ prompt = "Sidekick: " }, function(msg)
            if msg and msg ~= "" then
              cli.send({ msg = msg })
            end
          end)
        end,
        desc = "CLI Send Message",
      },
    },
  },
}

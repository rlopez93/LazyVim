-- Disable completion + spell for .txt files in LazyVim
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.txt",
  callback = function()
    -- Disable spell checking
    vim.opt_local.spell = false

    -- Disable LazyVim completion per-buffer
    vim.b.cmp_enabled = false -- nvim-cmp
    vim.b.blink_cmp_enabled = false -- blink.cmp
    vim.b.ai_cmp_enabled = false -- AI completion integration
  end,
})

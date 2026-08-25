set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc


:lua << EOF
  local opts = { noremap=true, silent=true }
  vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

  -- Buffer-local mappings, applied whenever a language server attaches.
  -- Replaces the old per-server on_attach, which the lspconfig framework
  -- used to call for us.
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local bufnr = args.buf
      local map = function(lhs, rhs)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', lhs, rhs, opts)
      end

      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

      -- See `:help vim.lsp.*` for documentation on any of the below functions
      map('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
      map('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
      map('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
      map('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
      map('<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
      map('<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
      map('<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
      map('<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
      map('<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
      map('<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
      map('gr', '<cmd>lua vim.lsp.buf.references()<CR>')
      map('<Leader>f', '<cmd>lua vim.lsp.buf.format()<CR>')
    end,
  })

  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
  local servers = { 'ts_ls', 'csharp_ls', 'pylsp', 'gopls', 'clangd' }

  require("mason").setup()

  -- mason-lspconfig enables each installed server via vim.lsp.enable().
  require("mason-lspconfig").setup {
    ensure_installed = servers,
  }

  -- Point clangd at the compile_commands.json that cmake-tools generates.
  -- pcall'd on both sides: cmake-tools throws unless its own setup() has run,
  -- and a missing build directory must not stop clangd from starting.
  vim.lsp.config('clangd', {
    before_init = function(_, config)
      local status, cmake = pcall(require, "cmake-tools")
      if status then
        pcall(cmake.clangd_on_new_config, config)
      end
    end,
  })

  -- Installed via ghcup rather than mason, so enable it explicitly.
  vim.lsp.enable('hls')
EOF


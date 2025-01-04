return {
    {
        "pojokcodeid/auto-lsp.nvim",
        event = { "VeryLazy", "BufReadPre", "BufNewFile", "BufRead" },
        dependencies = {
            { "williamboman/mason-lspconfig.nvim" },
            {
                "neovim/nvim-lspconfig",
                cmd = {
                    "LspInfo",
                    "LspInstall",
                    "LspUninstall",
                },
            },
            {
                "williamboman/mason.nvim",
                cmd = {
                    "Mason",
                    "MasonInstall",
                    "MasonUninstall",
                    "MasonUninstallAll",
                    "MasonLog",
                },
            },
        },
        opts = function(_, opts)
            opts.skip_config = opts.skip_config or {}
            opts.ensure_installed = opts.ensure_installed or {}
            opts.automatic_installation = true

            -- Garante que o servidor Lua esteja instalado
            vim.list_extend(opts.ensure_installed, { "lua_ls" })

            -- Configurações adicionais
            opts.format_on_save = false -- Desativa formatação ao salvar
            opts.virtual_text = false -- Desativa textos virtuais
            opts.timeout_ms = 5000 -- Define tempo limite para ações LSP
            return opts
        end,
        config = function(_, opts)
            require("auto-lsp").setup(opts)
        end,
        -- Atalhos de teclado com descrições traduzidas
        keys = {
            { "<leader>l",  "",                                                 desc = "Menu LSP",                      mode = "n" },
            { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",           desc = "Ação de Código",               mode = "n" },
            { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>",           desc = "Diagnósticos do Documento",    mode = "n" },
            { "<leader>lw", "<cmd>Telescope diagnostics<cr>",                   desc = "Diagnósticos do Projeto",      mode = "n" },
            { "<leader>li", "<cmd>LspInfo<cr>",                                 desc = "Informações do LSP",           mode = "n" },
            { "<leader>lI", "<cmd>Mason<cr>",                                   desc = "Gerenciador Mason",            mode = "n" },
            { "<leader>lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",      desc = "Próximo Diagnóstico",          mode = "n" },
            { "<leader>lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",      desc = "Diagnóstico Anterior",         mode = "n" },
            { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>",              desc = "Executar Code Lens",           mode = "n" },
            { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>",         desc = "Lista Rápida",                 mode = "n" },
            { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",                desc = "Renomear",                     mode = "n" },
            { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>",          desc = "Símbolos do Documento",        mode = "n" },
            { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Símbolos do Projeto",          mode = "n" },
        },
    },
}

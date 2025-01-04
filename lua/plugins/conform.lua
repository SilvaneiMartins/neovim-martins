return {
    "pojokcodeid/auto-conform.nvim",
    dependencies = {
        "williamboman/mason.nvim", -- Gerenciador de instalação de dependências
        "stevearc/conform.nvim",  -- Plugin para formatação
    },
    event = "VeryLazy", -- Carregar o plugin de forma preguiçosa
    opts = function(_, opts)
        -- Inicializa as opções se não definidas
        opts.formatters = opts.formatters or {}
        opts.formatters_by_ft = opts.formatters_by_ft or {}
        opts.ensure_installed = opts.ensure_installed or {}
        opts.lang_maps = opts.lang_maps or {}
        opts.name_maps = opts.name_maps or {}
        opts.add_new = opts.add_new or {}
        opts.ignore = opts.ignore or {}

        -- Exemplo de configuração adicional (personalizar conforme necessário)
        opts.ensure_installed = vim.tbl_extend("keep", opts.ensure_installed, {
            "prettier", -- Formatação para JavaScript/TypeScript e outros
            "stylua",   -- Formatação para Lua
        })
        opts.formatters_by_ft = vim.tbl_extend("keep", opts.formatters_by_ft, {
            lua = { "stylua" },
            javascript = { "prettier" },
            typescript = { "prettier" },
        })
    end,
    config = function(_, opts)
        local auto_conform = require("auto-conform")
        local conform = require("conform")

        -- Configuração do auto-conform
        auto_conform.setup(opts)

        -- Configuração do conform
        conform.setup {
            format_on_save = {
                lsp_fallback = true, -- Usar LSP como fallback caso o formatador não esteja disponível
                timeout_ms = 5000,   -- Tempo limite para formatação
            },
        }

        -- Mapeamento de atalhos para formatação
        vim.keymap.set({ "n", "v" }, "<leader>lf", function()
            conform.format {
                lsp_fallback = true,
                async = false,
                timeout_ms = 5000,
            }
        end, { desc = "Formatar arquivo ou seleção (modo visual)" })

        -- Atalho opcional para formatar com LSP
        vim.keymap.set("n", "<leader>fl", function()
            vim.lsp.buf.format {
                async = true,
                timeout_ms = 5000,
            }
        end, { desc = "Formatar usando LSP diretamente" })
    end,
}

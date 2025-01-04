return {
    {
        "pojokcodeid/auto-lualine.nvim",
        event = { "InsertEnter", "BufRead", "BufNewFile" },
        dependencies = { "nvim-lualine/lualine.nvim" },
        config = function()
            local lualine = require("lualine")

            -- Configuração aprimorada da barra de status
            lualine.setup {
                options = {
                    theme = "eva_dark", -- Tema personalizado (use outro tema se preferir)
                    component_separators = { left = "", right = "" }, -- Separadores de componentes
                    section_separators = { left = "", right = "" },   -- Separadores de seções
                    globalstatus = true, -- Usa uma barra de status global
                    icons_enabled = true, -- Habilita ícones na barra de status
                },
                sections = {
                    -- Configuração das seções principais
                    lualine_a = { "mode" }, -- Mostra o modo atual (normal, inserção, visual, etc.)
                    lualine_b = {
                        { "branch" },       -- Mostra o branch atual do Git
                        { "diff", colored = true, symbols = { added = "+", modified = "~", removed = "-" } } -- Mostra mudanças no Git
                    },
                    lualine_c = {
                        { "filename", path = 1 }, -- Nome do arquivo com caminho relativo
                        { "diagnostics", sources = { "nvim_diagnostic" }, sections = { "error", "warn", "info", "hint" } } -- Mostra diagnósticos do LSP
                    },
                    lualine_x = {
                        { "encoding" }, -- Mostra a codificação do arquivo
                        { "fileformat" }, -- Mostra o formato do arquivo (Unix, Windows, etc.)
                        { "filetype" }, -- Mostra o tipo do arquivo
                    },
                    lualine_y = { "progress" }, -- Mostra a porcentagem de progresso no arquivo
                    lualine_z = { "location" }, -- Mostra linha e coluna atuais
                },
                inactive_sections = {
                    -- Configuração para quando a janela está inativa
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {}, -- Configuração para linha de abas (se desejar ativar no futuro)
                extensions = { "quickfix", "fugitive", "nvim-tree" }, -- Extensões adicionais
            }
        end,
    },
}

return {
    {
        -- Plugin para melhorar a interface de mensagens no Neovim
        "folke/noice.nvim",
        lazy = true, -- Carrega apenas quando necessário
        enabled = true, -- Habilita o plugin
        dependencies = {
            { "MunifTanjim/nui.nvim" }, -- Dependência necessária
        },
        event = "VeryLazy", -- Carrega o plugin em eventos "preguiçosos"
        opts = {
            -- Configurações para desabilitar mensagens desnecessárias
            messages = {
                enabled = false, -- Desativa exibição de mensagens padrão
            },
            notify = {
                enabled = false, -- Desativa notificações
            },
            lsp = {
                progress = {
                    enabled = false, -- Desativa barra de progresso do LSP
                },
                hover = {
                    enabled = false, -- Desativa hover do LSP
                },
                signature = {
                    enabled = false, -- Desativa assinatura do LSP
                },
            },
        },
        keys = {
            -- Atalhos para interagir com o Noice
            {
                "<S-Enter>",
                function()
                    require("noice").redirect(vim.fn.getcmdline())
                end,
                mode = "c", -- Atalho no modo de comando
                desc = "Redirecionar Linha de Comando",
            },
            {
                "<leader>snl",
                function()
                    require("noice").cmd "last"
                end,
                desc = "Última Mensagem Noice",
            },
            {
                "<leader>snh",
                function()
                    require("noice").cmd "history"
                end,
                desc = "Histórico do Noice",
            },
            {
                "<leader>sna",
                function()
                    require("noice").cmd "all"
                end,
                desc = "Todas as Mensagens do Noice",
            },
            {
                "<c-f>",
                function()
                    if not require("noice.lsp").scroll(4) then
                        return "<c-f>" -- Se não puder rolar, retorna comportamento padrão
                    end
                end,
                silent = true,
                expr = true,
                desc = "Rolar para frente",
                mode = { "i", "n", "s" }, -- Disponível nos modos de inserção, normal e seleção
            },
            {
                "<c-b>",
                function()
                    if not require("noice.lsp").scroll(-4) then
                        return "<c-b>" -- Se não puder rolar, retorna comportamento padrão
                    end
                end,
                silent = true,
                expr = true,
                desc = "Rolar para trás",
                mode = { "i", "n", "s" },
            },
        },
    },
    {
        -- Plugin para completar comandos no cmdline
        "hrsh7th/cmp-cmdline",
        event = "VeryLazy", -- Carrega de forma preguiçosa
        config = function()
            local cmp = require "cmp"

            -- Mapeamentos para interagir com o cmp no cmdline
            local mapping = {
                ["<CR>"] = cmp.mapping.confirm { select = true }, -- Confirmação com Enter
                ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }), -- Seleciona anterior
                ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
                ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }), -- Seleciona próximo
                ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
            }

            -- Configuração para completar comandos iniciados com `/`
            cmp.setup.cmdline("/", {
                preselect = "none", -- Não pré-seleciona itens
                completion = {
                    completeopt = "menu,preview,menuone,noselect", -- Opções de menu
                },
                mapping = mapping, -- Utiliza os mapeamentos definidos
                sources = {
                    { name = "buffer" }, -- Fonte: buffer atual
                },
                experimental = {
                    ghost_text = true, -- Exibe texto fantasma (sugestões inline)
                    native_menu = false, -- Desativa o menu nativo
                },
            })

            -- Configuração para completar comandos iniciados com `:`
            cmp.setup.cmdline(":", {
                preselect = "none",
                completion = {
                    completeopt = "menu,preview,menuone,noselect",
                },
                mapping = mapping,
                sources = cmp.config.sources({
                    { name = "path" }, -- Fonte: caminhos
                }, {
                    { name = "cmdline" }, -- Fonte: comandos disponíveis
                }),
                experimental = {
                    ghost_text = true,
                    native_menu = false,
                },
            })
        end,
    },
}

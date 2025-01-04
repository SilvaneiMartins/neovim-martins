return {
    {
        -- Plugin de snippets
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        opts = {
            history = true, -- Permite navegar pelo histórico de snippets utilizados
            delete_check_events = "TextChanged", -- Verifica alterações ao apagar snippets
        },
        keys = {
            -- Mapeamentos para navegar pelos trechos (snippets)
            { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
    },
    {
        -- Plugin de auto-complete
        "hrsh7th/nvim-cmp",
        version = false, -- Não usar versões fixas, devido a atualizações frequentes
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",     -- Suporte para LSP
            "hrsh7th/cmp-buffer",       -- Auto-complete com base no buffer atual
            "hrsh7th/cmp-path",         -- Sugestões de caminhos
            "saadparwaiz1/cmp_luasnip", -- Integração com LuaSnip
            "hrsh7th/cmp-nvim-lua",     -- Auto-complete para Lua nativo
        },
        opts = function()
            local cmp = require "cmp"
            local luasnip = require "luasnip"

            -- Verifica se o caractere anterior é um espaço ou início da linha
            local check_backspace = function()
                local col = vim.fn.col "." - 1
                return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
            end

            return {
                completion = {
                    completeopt = "menu,menuone,noinsert", -- Configuração para experiência de auto-complete
                },
                snippet = {
                    -- Expande o snippet
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll para cima nos docs
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),  -- Scroll para baixo nos docs
                    ["<C-Space>"] = cmp.mapping.complete(), -- Força o auto-complete
                    ["<C-e>"] = cmp.mapping.abort(),        -- Cancela o auto-complete
                    ["<CR>"] = cmp.mapping.confirm { select = true }, -- Aceita a sugestão atual
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item() -- Seleciona o próximo item
                        elseif luasnip.expandable() then
                            luasnip.expand() -- Expande o snippet
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump() -- Expande ou navega
                        elseif check_backspace() then
                            fallback() -- Se backspace, retorna ao comportamento padrão
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item() -- Seleciona o item anterior
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1) -- Salta para o snippet anterior
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                sources = cmp.config.sources {
                    { name = "nvim_lsp" }, -- Fonte do LSP
                    { name = "luasnip" }, -- Fonte de snippets
                    { name = "buffer" },  -- Sugestões do buffer
                    { name = "path" },    -- Sugestões de caminho
                    { name = "nvim_lua" } -- Lua nativo
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        -- Adiciona ícones personalizados para cada tipo
                        vim_item.kind = string.format("%s", require("icons")["kind"][vim_item.kind])
                        vim_item.menu = ({
                            nvim_lsp = "(LSP)",
                            luasnip = "(Snippet)",
                            buffer = "(Buffer)",
                            path = "(Caminho)",
                            codeium = "(Codeium)",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(), -- Janelas com borda
                    documentation = cmp.config.window.bordered(),
                },
                experimental = {
                    ghost_text = false, -- Não mostrar sugestões em "fantasma"
                    native_menu = false, -- Desativa o menu nativo
                },
            }
        end,
    },
    {
        -- Conjunto de snippets pré-configurados
        "rafamadriz/friendly-snippets",
        event = "InsertEnter",
        lazy = true,
        config = function()
            -- Carrega snippets do VSCode
            require("luasnip.loaders.from_vscode").lazy_load()
            require "snippets"
        end,
    },
}

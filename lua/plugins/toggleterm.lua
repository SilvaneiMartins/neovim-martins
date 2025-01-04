return {
    "akinsho/toggleterm.nvim",
    lazy = true, -- Carregar somente quando necessário
    cmd = {
        "ToggleTerm",
        "TermExec",
        "ToggleTermToggleAll",
        "ToggleTermSendCurrentLine",
        "ToggleTermSendVisualLines",
        "ToggleTermSendVisualSelection",
    },
    branch = "main",              -- Usar a branch principal do repositório
    enabled = true,               -- Ativar o plugin
    opts = {
        size = 20,                -- Tamanho padrão do terminal
        open_mapping = [[<c-\>]], -- Atalho para abrir o terminal
        hide_numbers = true,      -- Esconde números da linha no terminal
        shade_filetypes = {},     -- Não sombrear tipos de arquivo específicos
        shade_terminals = true,   -- Ativar sombreamento no terminal
        shading_factor = 2,       -- Nível de sombreamento (1 a 3)
        start_in_insert = true,   -- Iniciar no modo de inserção
        insert_mappings = true,   -- Permitir mapeamentos no modo de inserção
        persist_size = true,      -- Manter o tamanho do terminal ao reabrir
        direction = "float",      -- Direção padrão do terminal (flutuante)
        close_on_exit = true,     -- Fechar o terminal ao sair
        shell = vim.o.shell,      -- Usar o shell padrão do Neovim
        float_opts = {
            border = "curved",    -- Bordas arredondadas para o terminal flutuante
            winblend = 0,         -- Transparência da janela
            highlights = {
                border = "Normal",
                background = "Normal",
            },
        },
    },
    config = function(_, opts)
        require("toggleterm").setup(opts)

        -- Configuração de atalhos específicos para o terminal
        function _G.set_terminal_keymaps()
            local opts = { noremap = true, silent = true }
            vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)       -- Sair para o modo normal
            vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)          -- Alternativa para sair para o modo normal
            vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts) -- Navegar para a esquerda
            vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts) -- Navegar para baixo
            vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts) -- Navegar para cima
            vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts) -- Navegar para a direita
        end

        -- Aplica os mapeamentos sempre que o terminal for aberto
        vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"
    end,
    keys = {
        -- Atalhos para manipular o terminal
        { "<leader>t",  "",                                                     desc = "Menu de Terminais",             mode = "n" },
        { "<leader>tx", "<cmd>ToggleTermToggleAll!<cr>",                        desc = "Fechar Todos os Terminais",     mode = "n" },
        { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",                  desc = "Abrir Terminal Flutuante",      mode = "n" },
        { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>",     desc = "Abrir Terminal Horizontal",     mode = "n" },
        { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>",       desc = "Abrir Terminal Vertical",       mode = "n" },
        { "<leader>ts", "<cmd>ToggleTerm direction=tab<cr>",                    desc = "Abrir Terminal em Nova Aba",    mode = "n" },
        { "<leader>tn", "<cmd>ToggleTerm direction=float<cr> | ToggleTerm<cr>", desc = "Abrir Novo Terminal Flutuante", mode = "n" },
        { "<leader>tt", "<cmd>TermExec cmd='top'<cr>",                          desc = "Executar 'top' no Terminal",    mode = "n" },
    },
}

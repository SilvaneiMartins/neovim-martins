require "nvchad.mappings"

-- adicione o seu aqui
-- definir o nome da função
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
-- MODOS
-- modo normal = "n"
-- modo de inserção = "i"
-- modo visual = "v"
-- modo de bloqueio visual = "x"
-- termo modo = "t"
-- modo de comando = "c"

for _, mode in ipairs { "i", "v", "n", "x" } do
    -- linha duplicada
    keymap(mode, "<S-Down>", "<cmd>t.<cr>", opts)
    keymap(mode, "<S-Up>", "<cmd>t -1<cr>", opts)
    -- salvar arquivo
    keymap(mode, "<C-s>", "<cmd>silent! w<cr>", opts)
end
-- bloco visual de linha duplicada
keymap("x", "<S-Down>", ":'<,'>t'><cr>", opts)
-- mover o texto para cima e para baixo
keymap("x", "<A-Down>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-Up>", ":move '<-2<CR>gv-gv", opts)
keymap("n", "<M-Down>", "<cmd>m+<cr>", opts)
keymap("i", "<M-Down>", "<cmd>m+<cr>", opts)
keymap("n", "<M-Up>", "<cmd>m-2<cr>", opts)
keymap("i", "<M-Up>", "<cmd>m-2<cr>", opts)
-- criar comentário CTRL +/todos os modos
keymap("v", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
keymap("v", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
keymap("i", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
keymap("i", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
keymap("i", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)
keymap("i", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)
keymap("n", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)
keymap("n", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)

-- fechar janelas
keymap("n", "q", "<cmd>q<cr>", opts)

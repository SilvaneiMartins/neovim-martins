require "nvchad.options"

-- adicione o seu aqui!

-- local o = vim.o
-- o.cursorlineopt ='both' -- para habilitar o cursorline!
local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
    pattern = "*",
    command = "tabdo wincmd =",
})

autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        vim.opt.statusline = "%#normal# "
    end,
})

-- Terminal de embarque
vim.api.nvim_create_augroup("neovim_terminal", { clear = true }) -- Membuat grupo auto comando para o terminal
autocmd("TermOpen", {
    group = "neovim_terminal",
    command = "startinsert | set nonumber norelativenumber | nnoremap <buffer> <C-c> i<C-c>", -- Entra no modo de inserção automaticamente e desativa os números de linha no buffer do terminal
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "lazy",
    callback = function()
        vim.opt_local.number = false
    end,
})

local opt = vim.opt
opt.cmdheight = 0

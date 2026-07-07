local containers = require("custom.config.keymap-containers")

vim.pack.add({ "https://github.com/Olical/conjure" })

-- Clojure
vim.pack.add({
	"https://github.com/tpope/vim-dispatch",
	"https://github.com/radenling/vim-dispatch-neovim",
	"https://github.com/clojure-vim/vim-jack-in",
})



-- Disable the documentation mapping
vim.g["conjure#mapping#doc_word"] = "gk"

vim.keymap.set('n', containers.root.key .. 'gk', '<cmd>ConjureDocWord<cr>', { desc = '[g]et [k]nowledge / Doc' })

vim.keymap.set("n", containers.code.key .. "c","<cmd>ConjureEval<cr>", {desc="[c]onjure eval"})
vim.keymap.set("n", containers.code.key .. "c", "<cmd>ConjureEvalCurrentForm<cr>", {desc="[c]lojure eval current form"})
vim.keymap.set("n", containers.code.key .. "b", "<cmd>ConjureEvalBuf<cr>", {desc="[b]uffer eval"})
vim.keymap.set("n", containers.root.key .. "<C-Enter>", "<cmd>ConjureEvalBuf<cr>", {desc="Evaluate buffer"})
vim.keymap.set("v", containers.root.key .. "<C-Enter>", "<cmd>ConjureEvalCurrentForm<cr>", {desc="Evaluate buffer"})
vim.keymap.set("n", containers.code.key .. "l", "<cmd>ConjureLogToggle<cr>", {desc="[l]og toggle"})
-- For clojure i recommend to put this line:
-- {:user {:plugins [[cider/cider-nrepl "0.42.1"]]}}
-- into:
-- ~/.lein/profiles.clj 

return {}

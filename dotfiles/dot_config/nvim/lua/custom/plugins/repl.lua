local containers = require("custom.config.keymap-containers")

vim.pack.add({ "https://github.com/Olical/conjure" })

-- Clojure
vim.pack.add({
	"https://github.com/tpope/vim-dispatch",
	"https://github.com/radenling/vim-dispatch-neovim",
	"https://github.com/clojure-vim/vim-jack-in",
})

vim.keymap.set("n", containers.config.key .. "c","<cmd>Clj<cr>", {desc="[c]lojure"})
vim.keymap.set("n", containers.code.key .. "c","<cmd>ConjureEval<cr>", {desc="[c]lojure"})
-- For clojure i recommend to put this line:
-- {:user {:plugins [[cider/cider-nrepl "0.42.1"]]}}
-- into:
-- ~/.lein/profiles.clj 


local containers = require("custom.config.keymap-containers")

-- Var setting must be done before we load conjure.
-- Disable the documentation mapping
vim.g["conjure#mapping#doc_word"] = "gk"

-- Default is "ConjureEvalInline"
vim.g["conjure#eval#inline#highlight"] = "Comment"

-- If we just use the ghost text.
-- vim.g["conjure#log#hud#enabled"] = false
vim.g["conjure#mapping#prefix"] = containers.evaluate.key


vim.pack.add({ "https://github.com/Olical/conjure" })

-- Clojure
vim.pack.add({
	"https://github.com/tpope/vim-dispatch",
	"https://github.com/radenling/vim-dispatch-neovim",
	"https://github.com/clojure-vim/vim-jack-in",
})



vim.keymap.set('n', containers.root.key .. 'gk', '<cmd>ConjureDocWord<cr>', { desc = '[g]et [k]nowledge / Doc' })
vim.keymap.set("n", containers.root.key .. "<C-Enter>", "<cmd>ConjureEvalBuf<cr>", {desc="Evaluate buffer"})
vim.keymap.set("v", containers.root.key .. "<C-Enter>", "<cmd>ConjureEvalVisual<cr>", {desc="Evaluate buffer"})

-- For clojure i recommend to put this line:
-- {:user {:plugins [[cider/cider-nrepl "0.42.1"]]}}
-- into:
-- ~/.lein/profiles.clj

return {}

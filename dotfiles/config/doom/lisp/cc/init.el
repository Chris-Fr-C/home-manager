;; Resolves 'modules/' relative to wherever this init.el file actually lives.
(message "Loading custom config")
(load! "cc-keymaps.el")
(load! "cc-lsp.el")
(load! "cc-ui.el")
(load! "cc-python.el")
(provide 'cc)

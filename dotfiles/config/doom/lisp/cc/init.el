;; Resolves 'modules/' relative to wherever this init.el file actually lives.
(message "Loading custom config")
(load! "cc-keymaps.el")
(load! "cc-ui.el")
(provide 'cc)

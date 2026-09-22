;;; cc-lang-python.el --- Python editing with pylsp -*- lexical-binding: t; -*-

;;; Commentary:
;; Built-in python-mode plus lsp-deferred; the server is pylsp, whose
;; client ships inside lsp-mode itself (no extra package).  The server
;; binary must be on PATH: present here via mason and via
;; `uv tool install 'python-lsp-server[all]'`.  On a fresh machine run
;; that uv command (or `pip install "python-lsp-server[all]"`), then
;; restart Emacs.  Identical in terminal and GUI.

;;; Code:

;; Python editing with LSP hover, completion, and diagnostics.
(use-package python
  :ensure nil ; built-in, no ELPA install needed
  :hook (python-mode . lsp-deferred))

(provide 'cc-lang-python)
;;; cc-lang-python.el ends here

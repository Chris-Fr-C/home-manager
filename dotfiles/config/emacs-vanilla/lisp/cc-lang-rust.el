;;; cc-lang-rust.el --- Rust editing with rust-analyzer -*- lexical-binding: t; -*-

;;; Commentary:
;; rust-mode plus lsp-deferred; the server is rust-analyzer, whose
;; client ships inside lsp-mode itself (no extra package).  The server
;; binary must be on PATH: present here via mason and via
;; `rustup component add rust-analyzer`.  On a fresh machine run that
;; rustup command, then restart Emacs.  Identical in terminal and GUI.

;;; Code:

;; Rust editing with LSP hover, completion, and diagnostics.
(use-package rust-mode
  :ensure t
  :hook (rust-mode . lsp-deferred))

(provide 'cc-lang-rust)
;;; cc-lang-rust.el ends here

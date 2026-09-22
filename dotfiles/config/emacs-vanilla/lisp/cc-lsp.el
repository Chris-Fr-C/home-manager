;;; cc-lsp.el --- Language Server Protocol client via lsp-mode -*- lexical-binding: t; -*-

;;; Commentary:
;; Base LSP client for all future cc-lang-*.el modules: this file only
;; installs and configures lsp-mode itself, without auto-starting any
;; server.  Each language module opts its modes into `lsp-deferred`.
;; Prerequisites are external per-language servers on PATH (e.g. pyright,
;; rust-analyzer, clangd); lsp-mode reports a missing server in the
;; minibuffer when a hook fires.  Works identically in terminal and GUI
;; (all server communication runs over subprocess pipes).  lsp-ui
;; below adds sideline diagnostics and peek views on top.

;;; Code:

;; Full-featured LSP client (explicit user choice over the built-in
;; eglot, for its broader server UI and which-key integration).
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :init
  ;; Must be set before lsp-mode loads: the prefix it binds its
  ;; command map under in managed buffers.  Kept at the upstream
  ;; default so external guides still apply; the leader entry points
  ;; below (leader c ...) are the config's own shortcuts.
  (setq lsp-keymap-prefix "C-c l")
  :custom
  ;; Large pipe reads keep completions smooth on big responses; this is
  ;; the value recommended upstream by lsp-mode.
  (read-process-output-max (* 1024 1024))
  ;; Surface subcommands through the which-key setup in cc-keybindings.el.
  (lsp-enable-which-key-integration t)
  ;; Stay quiet unless debugging a server (toggle per session instead).
  (lsp-log-io nil)
  (lsp-idle-delay 0.5)
  ;; doom-modeline already shows the path; a headerline breadcrumb would
  ;; duplicate it and clutter small terminal windows.
  (lsp-headerline-breadcrumb-enable nil)
  :bind (:map cc-code-map
              ("a" . lsp-execute-code-action)
              ("r" . lsp-rename)
              ("d" . lsp-find-definition)
              ("D" . flymake-show-buffer-diagnostics)
              ("l" . lsp-command-map)))

;; Companion UI for lsp-mode: sideline diagnostics and code actions at
;; point, plus peek definition/reference views.  Starts automatically
;; wherever lsp-mode starts; peek and sideline commands stay available
;; under the leader c l prefix and M-x.
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-delay 0.5)
  :config
  ;; Hover docs need childframes, so they only render in GUI.  Sideline
  ;; and peek are overlay-based and work in terminals too, hence only
  ;; docs are switched off outside graphics (same pattern as
  ;; doom-modeline icons in cc-ui.el).
  (unless (display-graphic-p)
    (setq lsp-ui-doc-enable nil)))

(provide 'cc-lsp)
;;; cc-lsp.el ends here

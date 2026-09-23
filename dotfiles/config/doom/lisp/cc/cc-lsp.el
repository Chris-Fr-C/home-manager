;;; cc-lsp.el --- LSP (lsp-mode), auto-start, DAP debugging -*- lexical-binding: t; -*-

;;; Commentary:
;; lsp-mode setup (Doom `:tools lsp', no flags) plus dap-mode debugging.
;; Owns the `SPC c' (code) and `SPC d' (debug) leader groups; K-hover
;; lives in cc-keymaps.el (`cc-show-doc-at-point').
;;
;; Why a separate file: LSP server lifecycle and DAP sessions are one
;; concern (per AGENTS.md, one concern per file), distinct from the bare
;; window/buffer keys in cc-keymaps.el.

;;; Code:

;; Upstream LSP prefix.  Must be set BEFORE lsp-mode loads (this file
;; loads from config.el at startup, long before the first server
;; starts), otherwise lsp-mode bakes in its default instead.
(setq lsp-keymap-prefix "C-c l")

;; Auto-start LSP when opening files: every programming buffer gets
;; `lsp-deferred' (starts once, lazily; offers `M-x lsp-install-server'
;; when the server is missing).  Doom `+lsp' lang modules (cc, rust)
;; hook independently -- harmless duplication, lsp starts only once.
;; (Python is also covered here AND hooks `lsp-deferred' in cc-python.el
;; so venv activation runs first; same harmless duplication.)
(add-hook 'prog-mode-hook #'lsp-deferred)
;; Less chatty for unsupported modes
;; (setq lsp-warn-no-matched-clients nil)

;; Company <-> lsp-mode connection.  `lsp-completion-mode' is the piece
;; that joins them: it puts `lsp-completion-at-point' first in capf and
;; ensures buffer-local `company-capf' (which company-box then renders).
;; Doom only enables it for corfu, so with company it must be hooked
;; here -- without this, company would complete without LSP candidates.
(add-hook 'lsp-mode-hook #'lsp-completion-mode)

;; ============================================================================
;; Code (`SPC c', lsp-mode)
;; ============================================================================
;; - `c d' displaces Doom's `+lookup/definition'; definition stays on
;;   `gd' (Doom evil default).
;; - `c D' displaces Doom's `+lookup/references'; references stay on
;;   `gD'.  Uses flycheck (our `:checkers syntax' backend), not flymake:
;;   the flymake diagnostics buffer would always be empty here.

(map! :leader
      (:prefix ("c" . "code")
       :desc "Code actions at point" "a" #'lsp-execute-code-action
       :desc "Rename symbol"         "r" #'lsp-rename
       :desc "Go to definition"      "d" #'lsp-find-definition
       :desc "Buffer diagnostics"    "D" #'flycheck-list-errors
       :desc "Full LSP prefix"       "l" #'+default/lsp-command-map))

;; ============================================================================
;; Debug (`SPC d', dap-mode)
;; ============================================================================
;; Needs `(package! dap-mode)' + `doom sync' (Doom ships no dap-mode;
;; its :tools debugger module uses `dape', a different client our
;; bindings don't touch).  All commands are lazy: pressing one loads
;; dap-mode, which then enables `dap-mode' + `dap-ui-mode' below.
;; `dap-tooltip-mode' stays OFF on purpose: it is mouse-centric and
;; noisy in `emacs -nw'.  `, d' (localleader) is unrelated: toggles for
;; the Elisp debugger, see cc-keymaps.el.

(after! dap-mode
  (dap-mode 1)
  (dap-ui-mode 1)) ; auto-shows sessions/locals/breakpoints on start

(map! :leader
      (:prefix ("d" . "debug")
       :desc "Start debugging"         "d" #'dap-debug
       :desc "Repeat last session"     "l" #'dap-debug-last
       :desc "Recent sessions"         "r" #'dap-debug-recent
       :desc "Toggle breakpoint"       "b" #'dap-breakpoint-toggle
       :desc "Conditional breakpoint"  "B" #'dap-breakpoint-condition
       :desc "Continue"                "c" #'dap-continue
       :desc "Next step"               "n" #'dap-next
       :desc "Step in"                 "i" #'dap-step-in
       :desc "Step out"                "o" #'dap-step-out
       :desc "Restart frame"           "R" #'dap-restart-frame
       :desc "Eval thing at point"     "e" #'dap-eval-thing-at-point
       :desc "Sessions buffer"         "s" #'dap-ui-sessions
       :desc "Disconnect session"      "q" #'dap-disconnect))

(provide 'cc-lsp)
;;; cc-lsp.el ends here

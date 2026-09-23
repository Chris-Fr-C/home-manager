;;; cc-python.el --- Python: lsp-mode + virtualenv selection -*- lexical-binding: t; -*-

;;; Commentary:
;; Python support without Doom's `:lang python' module: start lsp-mode
;; in `python-mode' buffers (needs a server such as pylsp, pyright or
;; ruff-lsp on PATH; `M-x lsp-install-server' can fetch one) and manage
;; the virtualenv with `pyvenv' (needs `(package! pyvenv)' +
;; `doom sync').  DAP debugging via debugpy is wired at the bottom
;; (needs `pip install debugpy' in the venv; sessions run from `SPC d').
;;
;; Why `pyvenv': activating a venv adjusts `exec-path',
;; `python-shell-virtualenv-root' and `$VIRTUAL_ENV' buffer-wide, so the
;; interactive shell, a freshly started language server AND debugpy all
;; resolve the venv's interpreter and packages.  Order matters: select
;; the venv BEFORE the server starts, or restart it after (lsp-mode
;; captures PATH at startup, hence `, m r').
;;
;; Terminal-first: everything here is plain commands and keymaps, no
;; GUI-only pieces.

;;; Code:

;; Start LSP in python buffers.  Doom's `:lang python' is disabled, so no
;; other module does this.  `lsp-deferred' is autoloaded; when no server
;; is installed it tells you which executable is missing instead of
;; erroring.
(add-hook 'python-mode-hook #'lsp-deferred)

;; Show the active venv in the modeline once pyvenv is installed.  The
;; `fboundp' guards keep this file harmless before `doom sync' pulls it.
(after! pyvenv
  (pyvenv-mode 1))

;; Auto-activate `.venv' / `venv' at the project root when entering a
;; python buffer.  Runs before `lsp-deferred' (added later, so nearer the
;; front of `python-mode-hook') so the server starts inside the venv.
;; Never errors: missing pyvenv, missing dir, or an invalid venv are all
;; silently skipped -- pick one manually with `, m v' instead.
(defun cc-python-maybe-activate-project-venv ()
  "Activate `.venv' or `venv' from the project root, if present."
  (when (fboundp 'pyvenv-activate)
    (let* ((proj (project-current nil))
           (root (if proj (project-root proj) default-directory))
           (venv (let ((found nil))
                   (dolist (name '(".venv" "venv") found)
                     (let ((dir (expand-file-name name root)))
                       (when (and (not found) (file-directory-p dir))
                         (setq found dir)))))))
      (when venv
        (ignore-errors (pyvenv-activate venv))))))

(add-hook 'python-mode-hook #'cc-python-maybe-activate-project-venv)

;; Venv selection lives under the reserved `, m' (Mode) container from
;; cc-keymaps.el, scoped to python buffers so other modes keep the
;; placeholder.  `lsp-workspace-restart' relaunches the server so it
;; picks up the newly selected environment.
(map! :map python-mode-map :localleader
      (:prefix ("m" . "Mode")
       :desc "Select virtualenv (workon)" "v" #'pyvenv-workon
       :desc "Activate venv by path"      "a" #'pyvenv-activate
       :desc "Deactivate venv"            "d" #'pyvenv-deactivate
       :desc "Restart LSP on this env"    "r" #'lsp-workspace-restart))

;; DAP for python via debugpy.  Guarded: needs `(package! dap-mode)' +
;; `doom sync' AND `pip install debugpy' inside the venv.  Sessions are
;; launched from the global `SPC d' group (cc-lsp.el); this only
;; registers the python template + interpreter (the venv's `python',
;; resolved through the pyvenv-adjusted `exec-path').
(after! dap-mode
  (require 'dap-python)
  (setq dap-python-executable "python"))

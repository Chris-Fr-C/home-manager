;;; cc-keybindings.el --- Leader, local leader, and top-level keymaps -*- lexical-binding: t; -*-

;;; Commentary:
;; SPC is the leader (M-SPC stays as a terminal-safe fallback that also
;; works in Emacs state, where SPC must self-insert); comma is the
;; local leader in evil normal and visual states.  Every custom binding
;; lives under one of them.  Each group below is a plain prefix map so
;; which-key shows every container with a name.  Package modules
;; (cc-org, cc-lsp, cc-treemacs) bind their own commands under these
;; maps; only built-in commands are bound here.

;;; Code:

;; The single leader prefix for the whole config.  Bound globally to
;; M-SPC (terminal-safe; SPC alone would break self-insert in Emacs
;; state) and additionally to SPC in evil normal/visual/motion states
;; (see cc-editing.el for that vim-style binding).
(define-prefix-command 'cc-leader-map)
(global-set-key (kbd "M-SPC") cc-leader-map)

;; Local leader for buffer/mode actions.  Bound to comma in evil
;; normal and visual states below: a global binding on a printable char
;; would break typing, and this displaces evil's comma (reverse repeat
;; of f/t find-char, the counterpart of semicolon).
(define-prefix-command 'cc-local-leader-map)

;; Top-level leader containers, one prefix map per group.  Package
;; commands are bound under these maps in their own modules; only
;; built-in commands are bound here.
(define-prefix-command 'cc-find-map)
(define-prefix-command 'cc-buffer-map)
(define-prefix-command 'cc-git-map)
(define-prefix-command 'cc-code-map)
(define-prefix-command 'cc-org-map)
(define-prefix-command 'cc-window-map)
(define-prefix-command 'cc-project-map)
(define-prefix-command 'cc-help-map)

;; Local-leader containers.  Mode and test groups stay empty until
;; language modules claim them; eval/compile/debug use built-ins.
(define-prefix-command 'cc-local-mode-map)
(define-prefix-command 'cc-local-eval-map)
(define-prefix-command 'cc-local-test-map)
(define-prefix-command 'cc-local-compile-map)
(define-prefix-command 'cc-local-debug-map)

(define-key cc-leader-map (kbd "f") 'cc-find-map)
(define-key cc-leader-map (kbd "b") 'cc-buffer-map)
(define-key cc-leader-map (kbd "g") 'cc-git-map)
(define-key cc-leader-map (kbd "c") 'cc-code-map)
(define-key cc-leader-map (kbd "o") 'cc-org-map)
(define-key cc-leader-map (kbd "w") 'cc-window-map)
(define-key cc-leader-map (kbd "p") 'cc-project-map)
(define-key cc-leader-map (kbd "h") 'cc-help-map)

(define-key cc-local-leader-map (kbd "m") 'cc-local-mode-map)
(define-key cc-local-leader-map (kbd "e") 'cc-local-eval-map)
(define-key cc-local-leader-map (kbd "t") 'cc-local-test-map)
(define-key cc-local-leader-map (kbd "c") 'cc-local-compile-map)
(define-key cc-local-leader-map (kbd "d") 'cc-local-debug-map)

;; Live prefix documentation in terminal and GUI alike.
(use-package which-key
  :ensure nil ; built-in since Emacs 30, no ELPA install needed
  :demand t
  :custom
  (which-key-idle-delay 0.4)
  (which-key-show-early-on-C-h t)
  :config
  (which-key-mode 1))

;; Group labels shown by which-key for every container prefix above.
;; which-key is demanded above, so it is loaded by the time these run.
(which-key-add-keymap-based-replacements cc-leader-map
  "f" "Find & Search"
  "b" "Buffer"
  "g" "Git"
  "c" "Code / LSP"
  "o" "Org"
  "w" "Window"
  "p" "Project"
  "h" "Help")
(which-key-add-keymap-based-replacements cc-local-leader-map
  "m" "Mode"
  "e" "Eval"
  "t" "Test"
  "c" "Compile"
  "d" "Debug")

;; Window navigation with Control + hjkl (vim directions, global so it
;; works in every evil state, including insert).  Uses evil's own
;; window commands (prefix-arg aware, same motion family as C-w h/j/k/l)
;; rather than windmove.  Evil is already set up in cc-editing.el, so
;; these are plain bindings like the leader above, not a new
;; use-package block.
;; Two known trade-offs, also noted in keybindings.md:
;; 1. C-h shadows the default help prefix; help remains on <F1>.
;; 2. Terminals send C-h and Backspace as the same code without Kitty
;;    keyboard protocol, so in `emacs -nw` Backspace also focuses
;;    window-left.  GUI and Kitty-protocol terminals are unaffected.
(global-set-key (kbd "C-h") #'evil-window-left)
(global-set-key (kbd "C-j") #'evil-window-down)
(global-set-key (kbd "C-k") #'evil-window-up)
(global-set-key (kbd "C-l") #'evil-window-right)

;; Visual window picker: numbers each window and jumps to the chosen
;; one.  M-o is terminal-safe (ESC-prefixed) and GUI-safe; it shadows
;; the rarely used facemenu prefix (still on M-x facemenu-menu).
(use-package ace-window
  :ensure t
  :bind
  (("M-o" . ace-window)))

;; H/L buffer switching in evil normal state only: a global binding
;; would break typing capital H/L.  This displaces vim's H/L
;; (screen top/bottom line); those stay reachable via M-x
;; evil-window-top and evil-window-bottom-line.  Deferred until evil
;; loads because this file runs before cc-editing.el (see init.el).
(defun cc-show-doc-at-point ()
  "Show documentation for the symbol at point, like vim K.
Uses the lsp-mode hover when active, `describe-symbol' in Emacs
Lisp, and signals a plain error otherwise."
  (interactive)
  (cond ((bound-and-true-p lsp-mode)
         (call-interactively #'lsp-describe-thing-at-point))
        ((derived-mode-p 'emacs-lisp-mode)
         ;; Passed explicitly so this never prompts when point is on a
         ;; symbol (prompts only when there is none).
         (describe-symbol (symbol-at-point)))
        (t (user-error "No documentation backend here (start lsp-mode)"))))

(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "H") #'previous-buffer)
  (define-key evil-normal-state-map (kbd "L") #'next-buffer)
  (define-key evil-normal-state-map (kbd "K") #'cc-show-doc-at-point)
  (define-key evil-normal-state-map (kbd ",") 'cc-local-leader-map)
  (define-key evil-visual-state-map (kbd ",") 'cc-local-leader-map))

;; Find & Search group (built-ins; project ripgrep arrives with a
;; future grep/rg tool, symbols with an LSP index).  f f is the fuzzy
;; project finder; f p prompts for any path.
(define-key cc-find-map (kbd "f") #'project-find-file)
(define-key cc-find-map (kbd "p") #'find-file)
(define-key cc-find-map (kbd "s") #'project-search)
(define-key cc-find-map (kbd "l") #'occur)

;; Track recently opened files for leader f r.
(use-package recentf
  :ensure nil ; built-in, no ELPA install needed
  :demand t
  :custom
  (recentf-max-saved-items 100)
  :bind (:map cc-find-map
              ("r" . recentf-open-files))
  :config
  (recentf-mode 1))

;; Buffer group.
(define-key cc-buffer-map (kbd "s") #'switch-to-buffer)
(define-key cc-buffer-map (kbd "k") #'kill-current-buffer)
(define-key cc-buffer-map (kbd "r") #'revert-buffer)
(define-key cc-buffer-map (kbd "l") #'ibuffer)

;; Git group (vc built-ins; s stays free for magit-status once magit
;; is installed).
(define-key cc-git-map (kbd "d") #'vc-diff)
(define-key cc-git-map (kbd "b") #'vc-annotate)

;; Split helper: run SPLIT-FN, then focus the new window toward
;; DIRECTION (a `window-in-direction' side).  Built-ins only, so this
;; works regardless of evil load order.
(defun cc-window--split-and-focus (split-fn direction)
  "Split with SPLIT-FN, then select the new window toward DIRECTION.
SPLIT-FN is a no-arg function splitting the selected window;
DIRECTION is one of left, right, up, down."
  (funcall split-fn)
  (select-window (window-in-direction direction)))

(defun cc-window-split-left ()
  "Split the window with the new window on the left, and focus it."
  (interactive)
  (cc-window--split-and-focus (lambda () (split-window nil nil 'left)) 'left))

(defun cc-window-split-below ()
  "Split the window with the new window below, and focus it."
  (interactive)
  (cc-window--split-and-focus #'split-window-below 'down))

(defun cc-window-split-above ()
  "Split the window with the new window above, and focus it."
  (interactive)
  (cc-window--split-and-focus (lambda () (split-window nil nil 'above)) 'up))

(defun cc-window-split-right ()
  "Split the window with the new window on the right, and focus it."
  (interactive)
  (cc-window--split-and-focus #'split-window-right 'right))

;; Window group: hjkl splits plus close/only.
(define-key cc-window-map (kbd "h") #'cc-window-split-left)
(define-key cc-window-map (kbd "j") #'cc-window-split-below)
(define-key cc-window-map (kbd "k") #'cc-window-split-above)
(define-key cc-window-map (kbd "l") #'cc-window-split-right)
(define-key cc-window-map (kbd "d") #'delete-window)
(define-key cc-window-map (kbd "o") #'delete-other-windows)

;; Project group (built-in project.el).
(define-key cc-project-map (kbd "p") #'project-switch-project)
(define-key cc-project-map (kbd "f") #'project-find-file)
(define-key cc-project-map (kbd "s") #'project-search)
(define-key cc-project-map (kbd "d") #'project-dired)
(define-key cc-project-map (kbd "k") #'project-kill-buffers)

;; Help group.  h h restores view-echo-area-messages, unreachable at
;; its default C-h e since C-h focuses window-left above.
(define-key cc-help-map (kbd "k") #'describe-key)
(define-key cc-help-map (kbd "f") #'describe-function)
(define-key cc-help-map (kbd "v") #'describe-variable)
(define-key cc-help-map (kbd "m") #'describe-mode)
(define-key cc-help-map (kbd "h") #'view-echo-area-messages)

;; Eval group (built-ins).
(define-key cc-local-eval-map (kbd "b") #'eval-buffer)
(define-key cc-local-eval-map (kbd "r") #'eval-region)
(define-key cc-local-eval-map (kbd "f") #'eval-defun)
(define-key cc-local-eval-map (kbd "l") #'eval-last-sexp)

;; Compile group (built-ins).
(define-key cc-local-compile-map (kbd "c") #'compile)
(define-key cc-local-compile-map (kbd "r") #'recompile)

;; Debug group (built-ins).
(define-key cc-local-debug-map (kbd "e") #'toggle-debug-on-error)
(define-key cc-local-debug-map (kbd "v") #'toggle-debug-on-variable)

(provide 'cc-keybindings)
;;; cc-keybindings.el ends here

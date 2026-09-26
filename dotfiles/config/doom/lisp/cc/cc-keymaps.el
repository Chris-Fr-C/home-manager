;;; cc-keymaps.el --- Lea;;; cc-keymaps.el --- Leader keys, VIM bindings, LSP/docs lookup -*- lexical-binding: t; -*-

;;; Commentary:
;; Central keybinding layout for this Doom Emacs configuration.
;;
;; Conventions:
;; - Leader: `SPC` ( Doom default, explicitly configured )
;; - Alt-Leader: `M-SPC` ( Insert / Emacs states )
;; - Localleader: `,` ( Terminal-safe plain ASCII )
;; - Alt-Localleader: `M-,`
;;
;; See `keybindings.md` in the repository root for full mapping documentation.

;;; Code:

;; ============================================================================
;; 1. Core Leader & Localleader Initialization
;; ============================================================================

(setq doom-leader-key "SPC"
      doom-leader-alt-key "M-SPC"
      doom-localleader-key ","
      doom-localleader-alt-key "M-,")

(after! which-key
  (setq which-key-idle-delay 0.2
        which-key-idle-secondary-delay 0.05)
  (which-key-add-key-based-replacements
    "SPC b"   "buffer"
    "SPC c"   "code"
    "SPC d"   "debug"
    "SPC e"   "tree"
    "SPC f"   "find"
    "SPC g"   "git"
    "SPC h"   "help"
    "SPC o"   "org"
    "SPC p"   "project"
    "SPC q"   "quit"
    "SPC t"   "toggle"
    "SPC w"   "window"
    "SPC C"   "config"
    "SPC C v" "vim/doom"
    ", c"     "build"
    ", d"     "debug"
    ", e"     "eval"
    ", m"     "mode"
    ", t"     "test"))


;;; Unbinding some stuff I dont like like zap
(global-unset-key (kbd "M-z"))

;; ============================================================================
;; 2. Custom Commands (`cc-` Namespaced)
;; ============================================================================

(defun cc-show-doc-at-point ()
  "Show documentation for symbol at point (NVIM-style hover).
First invocation shows doc peek/buffer. Second invocation focuses
the doc frame or help window for scrolling."
  (interactive)
  (let ((again (eq last-command 'cc-show-doc-at-point)))
    (cond
     ((bound-and-true-p lsp-mode)
      (cond
       ((and again (display-graphic-p)
             (fboundp 'lsp-ui-doc--frame-visible-p)
             (lsp-ui-doc--frame-visible-p)
             (fboundp 'lsp-ui-doc-focus-frame))
        (lsp-ui-doc-focus-frame))
       ((and (display-graphic-p) (fboundp 'lsp-ui-doc-glance))
        (call-interactively #'lsp-ui-doc-glance))
       ((and again (get-buffer-window "*lsp-help*" t))
        (select-window (get-buffer-window "*lsp-help*" t)))
       ((fboundp 'lsp-describe-thing-at-point)
        (call-interactively #'lsp-describe-thing-at-point))
       (t (user-error "LSP active but no hover command available"))))
     ((derived-mode-p 'emacs-lisp-mode)
      (if (and again (get-buffer-window "*Help*" t))
          (select-window (get-buffer-window "*Help*" t))
        (let ((sym (symbol-at-point)))
          (unless sym (user-error "No symbol at point"))
          (describe-symbol sym))))
     (t (user-error "No LSP here; run M-x lsp in this buffer first")))))

;; Directional splits (focus retention logic)
(defun cc-window-split-left ()
  "Split horizontally, keep focus on the left window."
  (interactive) (split-window-right))

(defun cc-window-split-right ()
  "Split horizontally and focus the new window on the right."
  (interactive) (select-window (split-window-right)))

(defun cc-window-split-below ()
  "Split vertically and focus the new window below."
  (interactive) (select-window (split-window-below)))

(defun cc-window-split-above ()
  "Split vertically, keep focus on the top window."
  (interactive) (split-window-below))

;; Org Utilities
(defun cc/org-id-get-create-all ()
  "Ensure all headings in current buffer possess an Org ID."
  (interactive)
  (require 'org-id)
  (save-excursion
    (goto-char (point-max))
    (when (or (org-at-heading-p) (outline-previous-heading))
      (org-id-get-create)
      (while (outline-previous-heading)
        (org-id-get-create)))))

;; Blackhole Register Deletions
(defun cc/delete-blackhole ()
  "Delete selection/motion into blackhole register."
  (interactive)
  (setq evil-this-register ?_)
  (call-interactively #'evil-delete))

(defun cc/delete-blackhole-eol ()
  "Delete to end of line into blackhole register."
  (interactive)
  (setq evil-this-register ?_)
  (call-interactively #'evil-delete-line))

;; ============================================================================
;; 3. Global & Motion Keybindings
;; ============================================================================

(map!
 ;; Window & Buffer Navigation
 :n "C-h" #'evil-window-left
 :n "C-j" #'evil-window-down
 :n "C-k" #'evil-window-up
 :n "C-l" #'evil-window-right
 :n "H"   #'previous-buffer
 :n "L"   #'next-buffer
 :n "K"   #'cc-show-doc-at-point
 :g "M-o" #'ace-window

 ;; Editing & VIM Enhancements
 :n "C-u" #'evil-scroll-up
 :v "C-u" #'evil-scroll-up
 :n "C-o" #'evil-jump-backward
 :m "C-o" #'evil-jump-backward
 :n "q"   nil ; Free 'q' macro recording
 :n "C-M-r" #'evil-record-macro

 ;; Blackhole Deletes
 :n "d" #'cc/delete-blackhole
 :v "d" #'cc/delete-blackhole
 :n "D" #'cc/delete-blackhole-eol
 :v "D" #'cc/delete-blackhole-eol

 ;; Rapid Actions / Quitting / Saving
 "C-s" (cmd! (save-buffer) (message "Saved"))
 :n "C-q" #'evil-quit
 :n "M-q" (cmd! (kill-emacs))

 ;; Avy & Selection Enhancements
 :n "f" #'evil-avy-goto-char-timer
 :v "f" #'evil-avy-goto-char-timer
 :o "f" #'evil-avy-goto-char-timer
 :n "F" #'er/expand-region

 ;; Workspace Tabs
 :n "<tab>"     #'+workspace/switch-right
 :n "<backtab>" #'+workspace/switch-left

 ;; Mini-Move / Line Dragging
 :n "M-h" #'evil-shift-left-line
 :n "M-l" #'evil-shift-right-line
 :v "M-h" #'+evil/visual-dedent
 :v "M-l" #'+evil/visual-indent
 :n "M-j" #'drag-stuff-down
 :n "M-k" #'drag-stuff-up
 :v "M-j" #'drag-stuff-down
 :v "M-k" #'drag-stuff-up

 ;; Consult & Embark Shortcuts
 "M-g g" #'consult-goto-line
 "M-g i" #'consult-imenu
 "M-s l" #'consult-line
 "M-y"   #'consult-yank-pop
 "C-."   #'embark-act)

;; ============================================================================
;; 4. Leader Map (`SPC`)
;; ============================================================================

(map! :leader
      ;; Tree Navigation
      :desc "Toggle tree at project root" "e" #'+treemacs/toggle

      ;; Direct Splits
      :desc "Up/Down split"   "-" #'split-window-below
      :desc "Left/Right split" "|" #'split-window-right

      ;; Buffer Group
      (:prefix ("b" . "buffer")
       :desc "Switch buffer"       "s" #'switch-to-buffer
       :desc "Kill current buffer" "k" #'kill-current-buffer
       :desc "Revert from disk"    "r" #'revert-buffer
       :desc "List buffers"        "l" #'ibuffer)

      ;; Find & Search (Project.el)
      (:prefix ("f" . "find")
       :desc "Fuzzy-find file in project" "f" #'project-find-file
       :desc "Recent files"               "r" #'recentf-open-files
       :desc "Find file by path"          "p" #'find-file
       :desc "Grep project"               "s" #'project-search
       :desc "Lines matching regexp"      "l" #'occur)

      ;; Git Group
      (:prefix ("g" . "git")
       :desc "Diff working tree" "d" #'vc-diff
       :desc "Blame annotations" "b" #'vc-annotate)

      ;; Org Group
      (:prefix ("o" . "org")
       :desc "Weekly agenda"       "a" #'org-agenda
       :desc "Capture note/task"   "c" #'org-capture
       :desc "Ensure Org IDs"      "h" #'cc/org-id-get-create-all
       :desc "Refile heading"      "r" #'org-refile
       :desc "Archive heading"     "A" #'org-archive-subtree
       :desc "Set tags"            "t" #'org-set-tags-command)

      ;; Window Management
      (:prefix ("w" . "window")
       :desc "Split, new window left"  "h" #'cc-window-split-left
       :desc "Split, new window below" "j" #'cc-window-split-below
       :desc "Split, new window above" "k" #'cc-window-split-above
       :desc "Split, new window right" "l" #'cc-window-split-right
       :desc "Close this window"       "d" #'delete-window
       :desc "Keep only this window"   "o" #'delete-other-windows)

      ;; Project Management
      (:prefix ("p" . "project")
       :desc "Switch project"       "p" #'project-switch-project
       :desc "Find file in project" "f" #'project-find-file
       :desc "Grep project"         "s" #'project-search
       :desc "Dired at root"        "d" #'project-dired
       :desc "Kill buffers"         "k" #'project-kill-buffers)

      ;; Help Group
      (:prefix ("h" . "help")
       :desc "Describe a key"      "k" #'describe-key
       :desc "Describe a function" "f" #'describe-function
       :desc "Describe a variable" "v" #'describe-variable
       :desc "Describe this mode"  "m" #'describe-mode
       :desc "Show messages"       "h" #'view-echo-area-messages
       :desc "Reload config"       "r" #'doom/reload)

      ;; Toggle Group
      (:prefix ("t" . "toggle")
       :desc "Ghostel terminal"    "t" #'ghostel
       :desc "Ghostel split left"  "h" (cmd! (ghostel))
       :desc "Ghostel split down"  "j" (cmd! (select-window (split-window-below)) (ghostel))
       :desc "Ghostel split up"    "k" (cmd! (split-window-below) (ghostel))
       :desc "Ghostel split right" "l" (cmd! (select-window (split-window-right)) (ghostel)))

      ;; Config Group
      (:prefix ("C" . "config")
               (:prefix ("v" . "vim/doom")
                :desc "Update packages" "u" #'doom/doom-upgrade
                :desc "Reload config"   "r" #'doom/reload))

      ;;qq;
      (:prefix ("c" . "code")
       :desc "LSP Code Action" "a" #'lsp-code-actions-at-point)
      ;; Quit Group
      (:prefix ("q" . "quit")
       :desc "all (no save)" "a" (cmd! (kill-emacs))
       :desc "buffer/window" "b" #'evil-quit
       :desc "quit vim"      "q" (cmd! (kill-emacs))
       :desc "others"        "o" #'delete-other-windows))

;; ============================================================================
;; 5. Localleader Map (`,`)
;; ============================================================================

(map! :localleader
      (:prefix ("e" . "eval")
       :desc "Evaluate buffer" "b" #'eval-buffer
       :desc "Evaluate region" "r" #'eval-region
       :desc "Evaluate defun"  "f" #'eval-defun
       :desc "Evaluate sexp"   "l" #'eval-last-sexp)
      (:prefix ("c" . "build")
       :desc "Run build command" "c" #'compile
       :desc "Re-run last build" "r" #'recompile)
      (:prefix ("d" . "debug")
       :desc "Toggle debug on error"  "e" #'toggle-debug-on-error
       :desc "Watch variable change"  "v" #'debug-on-variable-change)
      (:prefix ("m" . "Mode")
       :desc "Reserved for language modules" "m" #'ignore)
      (:prefix ("t" . "Test")
       :desc "Reserved for test runners"     "t" #'ignore))

;; ============================================================================
;; 6. Package-Specific Overrides & Hooks
;; ============================================================================

;; Org Mode Overrides
(after! org
  (map! :map org-mode-map
        :n "C-j" nil
        :n "C-k" nil)
  (map! :map org-mode-map :localleader
        :n "J" #'org-next-visible-heading
        :v "J" #'org-next-visible-heading
        :n "K" #'org-previous-visible-heading
        :v "K" #'org-previous-visible-heading))

(after! evil-org
  (map! :map evil-org-mode-map
        :n "C-j" nil
        :n "C-k" nil))

;; Org-Roam Entrypoints
(after! org-roam
  (map! :leader
        (:prefix ("o" . "org")
         :desc "Find or create roam node" "f" #'org-roam-node-find
         :desc "Insert roam link"         "i" #'org-roam-node-insert
         :desc "Toggle backlinks buffer"  "l" #'org-roam-buffer-toggle)))


;; Treemacs Keybindings & Node Behaviors
(after! treemacs
  ;; Bypass system trash for Treemacs deletes so Emacs doesn't run set-file-times on trash folders
  ;; Force Treemacs to bypass internal metadata timestamp checks
  (setq delete-by-moving-to-trash nil)
  (map! :map treemacs-mode-map
        "C-h"         #'evil-window-left
        "C-j"         #'evil-window-down
        "C-k"         #'evil-window-up
        "C-l"         #'evil-window-right
        "a"           #'treemacs-create-file
        "d"           (cmd! (let ((current-prefix-arg 4))
                              (call-interactively #'treemacs-delete-file)))
        "x"           #'treemacs-move-file
        "p"           #'treemacs-copy-file
        "r"           #'treemacs-rename-file
        "c"           #'treemacs-copy-file
        "."           #'treemacs-root-up
        "<backspace>" #'treemacs-root-up)

  (treemacs-define-RET-action 'file-node-closed #'treemacs-visit-node-ace)
  (treemacs-define-RET-action 'file-node-open   #'treemacs-visit-node-ace))

;; Evil Escape Sequences
(after! evil-escape
  (setq evil-escape-key-sequence "jk"
        evil-escape-delay 0.15))

(after! ghostel
  (map! :map ghostel-mode-map
        :i "j k" #'evil-normal-state))

(provide 'cc-keymaps)
;;; cc-keymaps.el ends here

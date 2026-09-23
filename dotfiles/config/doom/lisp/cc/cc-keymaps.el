;;; cc-keymaps.el --- Leader keys, vim bindings, LSP/docs lookup -*- lexical-binding: t; -*-

;;; Commentary:
;; Central keybinding layout for this Doom config.
;; Why one file: the maintainer comes from nvim, so every binding must be
;; traceable from a single place; `keybindings.md` (repo root) mirrors this
;; file table-for-table.
;;
;; Leader choices (terminal-first): SPC is the leader (Doom default, set
;; explicitly here so the choice is visible, not implicit).  Comma is the
;; localleader: it is plain ASCII, so it reaches Emacs identically in
;; `emacs -nw', over SSH, and in GUI frames -- unlike keys that need
;; Kitty's keyboard protocol to survive a terminal.
;;
;; Adaptations vs. the vanilla `cc-*' spec this layout is drawn from:
;; - Doom has no `cc-leader-map'; `doom-leader-map' (bound to SPC by
;;   `doom-leader-key' below) IS the leader.  Everything under `:leader'
;;   in this file is the `SPC' rows of keybindings.md.
;; - LSP (`SPC c') and DAP (`SPC d') live in cc-lsp.el, since server
;;   lifecycle and debug sessions are their own concern.
;; - `toggle-debug-on-variable' does not exist (Emacs 30 only ships
;;   `toggle-debug-on-error' and `toggle-debug-on-quit'), so `, d v'
;;   runs `debug-on-variable-change' (prompt for a variable, arm the
;;   debugger when it changes) instead.
;; - `SPC o f/i/l' need org-roam, which is not enabled (`:lang org'
;;   without `+roam'), so those three are defined inside
;;   `(after! org-roam ...)' and stay unbound until org-roam is
;;   installed (`package! org-roam' + `doom sync').
;; - `SPC g s' is intentionally left unbound and reserved for
;;   `magit-status' (see the Git section).

;;; Code:

;; ============================================================================
;; Leader / localleader setup
;; (doom-leader-key / doom-localleader-key must be set before evil builds
;; the leader keymaps, so this block stays at the top of the file.)
;; ============================================================================

(setq doom-leader-key "SPC"            ; vim-style leader, reachable everywhere
      doom-leader-alt-key "M-SPC"      ; leader for insert/emacs states
      doom-localleader-key ","         ; major-mode / dev prefix (was ";")
      doom-localleader-alt-key "M-,")  ; localleader for insert/emacs states

(after! which-key
  (setq which-key-idle-delay 0.2            ; default ~0.4-1s before first popup
        which-key-idle-secondary-delay 0.05) ; delay for subsequent prefixes
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

;; ============================================================================
;; Custom commands (all `cc-' namespaced per AGENTS.md)
;; ============================================================================

;; `K' target: nvim-style hover.  Never delegates the "nothing found"
;; case to `+lookup/documentation': its fallback is an online web search
;; (that "search on ..." window).  With lsp-mode active, docs show in a
;; popup childframe on GUI (`lsp-ui-doc-glance', same family as the
;; company-box frames) and in a help buffer in terminal, where
;; childframes don't exist.  Pressing K a second time (consecutively)
;; ENTERS the docs so you can scroll: the doc frame is focused on GUI
;; (`q' leaves it), the `*lsp-help*' window is selected in terminal.
;; Elisp uses `describe-symbol' (second K selects `*Help*'); anything
;; else is an explicit error telling how to get LSP running.
(defun cc-show-doc-at-point ()
  "Show documentation for the symbol at point.
First K shows it (popup frame on GUI, help buffer in terminal);
second consecutive K enters it for scrolling.  Elisp uses
`describe-symbol'.  Errors when no LSP is active (run `M-x lsp')."
  (interactive)
  (let ((again (eq last-command 'cc-show-doc-at-point)))
    (cond
     ((bound-and-true-p lsp-mode)
      (cond
       ;; Second K on GUI: focus the doc frame for scrolling.
       ((and again (display-graphic-p)
             (fboundp 'lsp-ui-doc--frame-visible-p)
             (lsp-ui-doc--frame-visible-p)
             (fboundp 'lsp-ui-doc-focus-frame))
        (lsp-ui-doc-focus-frame))
       ;; First K on GUI: peek (auto-hides).
       ((and (display-graphic-p) (fboundp 'lsp-ui-doc-glance))
        (call-interactively #'lsp-ui-doc-glance))
       ;; Second K in terminal: enter the help window to scroll it.
       ((and again (get-buffer-window "*lsp-help*" t))
        (select-window (get-buffer-window "*lsp-help*" t)))
       ;; First K in terminal (or fallback): describe into `*lsp-help*'.
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

;; Directional splits for `SPC w h/j/k/l'.  Emacs primitives only ever
;; create the new window below/right, so "left"/"above" mean: split, keep
;; focus where you are (the new window appears on the other side).
;; "right"/"below" mean: split and move focus into the new window.
(defun cc-window-split-left ()
  "Split horizontally, keep focus on the left (new window is on the right)."
  (interactive)
  (split-window-right))

(defun cc-window-split-right ()
  "Split horizontally and focus the new window on the right."
  (interactive)
  (select-window (split-window-right)))

(defun cc-window-split-below ()
  "Split vertically and focus the new window below."
  (interactive)
  (select-window (split-window-below)))

(defun cc-window-split-above ()
  "Split vertically, keep focus above (new window is below)."
  (interactive)
  (split-window-below))

;; Single definition (the old file defined this twice).  Kept off the
;; spec tables on `SPC o h', which the spec leaves free.
(defun cc/org-id-get-create-all ()
  "Ensure all headings in the current buffer have an Org ID."
  (interactive)
  (require 'org-id)
  (save-excursion
    (goto-char (point-max))
    (when (or (org-at-heading-p) (outline-previous-heading))
      (org-id-get-create)
      (while (outline-previous-heading)
        (org-id-get-create)))))

;; ============================================================================
;; Windows / Buffers (bare keys)
;; ============================================================================
;; - `C-h' shadows the default help prefix; help remains on `<F1>'.
;; - Terminal limitation: without Kitty keyboard protocol, terminals send
;;   `C-h' and Backspace as the same code, so in `emacs -nw' Backspace
;;   also focuses window-left.  GUI and Kitty-protocol terminals keep
;;   both keys distinct.
;; - `M-o' shadows the `facemenu' prefix (`M-o' is a mode-specific prefix
;;   for font/face commands); ace-window is deemed more useful daily.

(map! :n "C-h" #'evil-window-left
      :n "C-j" #'evil-window-down
      :n "C-k" #'evil-window-up
      :n "C-l" #'evil-window-right
      ;; H/L displace vim's screen-top/screen-bottom motions; those stay
      ;; reachable via `zt' / `zb' and `M-x'.
      :n "H" #'previous-buffer
      :n "L" #'next-buffer
      ;; K displaces nothing in Doom (it is `+lookup/documentation' by
      ;; default); this wrapper just makes the nvim-hover intent explicit.
      :n "K" #'cc-show-doc-at-point
      :g "M-o" #'ace-window) ; needs :ui window-select (installed)

;; Keep window navigation working inside org buffers too: org (via
;; evil-collection) and evil-org bind C-j/C-k to heading motion, which
;; would shadow the global window keys above.  Unlike the old config,
;; bare J/K are NOT rebound here -- J stays `evil-join' and K stays
;; `cc-show-doc-at-point'; heading motion moved to `, J' / `, K'.
(after! org
  (map! :map org-mode-map
        :n "C-j" nil
        :n "C-k" nil))
(after! evil-org
  (map! :map evil-org-mode-map
        :n "C-j" nil
        :n "C-k" nil))

;; ============================================================================
;; Find & Search (`SPC f') -- builtin project.el, no extra package needed
;; ============================================================================
;; Replaces the old `SPC f f' (projectile) / `SPC f w' (ripgrep wrapper):
;; `project-find-file' / `project-search' cover both via project.el.

(map! :leader
      (:prefix ("f" . "find")
       :desc "Fuzzy-find file in project" "f" #'project-find-file
       :desc "Recent files"               "r" #'recentf-open-files
       :desc "Find file by path"          "p" #'find-file
       :desc "Grep project"               "s" #'project-search
       :desc "Lines matching regexp"      "l" #'occur))

;; ============================================================================
;; Buffer (`SPC b')
;; ============================================================================
;; Replaces Doom's defaults AND the old custom group under this prefix
;; (old `b l/j' splits, `b n' new buffer, `b t' workspace tab): splits
;; live under `SPC w' now, new-buffer/tab under Doom's `SPC b N'.

(map! :leader
      (:prefix ("b" . "buffer")
       :desc "Switch buffer"        "s" #'switch-to-buffer
       :desc "Kill current buffer"  "k" #'kill-current-buffer
       :desc "Revert from disk"     "r" #'revert-buffer
       :desc "List buffers"         "l" #'ibuffer))

;; ============================================================================
;; Git (`SPC g')
;; ============================================================================
;; `SPC g s' deliberately unbound: reserved for `magit-status'.

(map! :leader
      (:prefix ("g" . "git")
       :desc "Diff working tree"  "d" #'vc-diff
       :desc "Blame annotations"  "b" #'vc-annotate))

;; ============================================================================
;; Code / LSP (`SPC c') and Debug (`SPC d') live in cc-lsp.el
;; ============================================================================
;; (Kept here as a pointer so the leader layout stays traceable: `SPC c'
;; is lsp-mode actions, `SPC d' is dap-mode sessions.)

;; ============================================================================
;; Org (`SPC o' + `,' headings)
;; ============================================================================
;; - TODOs live in the agenda (`SPC o a'); links via roam (`SPC o i')
;;   or `org-store-link' (`C-c l' in org buffers -- shadowed by the LSP
;;   prefix only where `lsp-mode' is active, i.e. not in org).
;; - `C-j' / `C-k' switch windows in org buffers too (unbound from
;;   outline motion above); plain `RET' still newlines as usual.
;; - `, J' / `, K' are bound in `org-mode-map' under the localleader so
;;   bare K keeps showing docs (see `cc-show-doc-at-point').

(map! :leader
      (:prefix ("o" . "org")
       :desc "Weekly agenda"          "a" #'org-agenda
       :desc "Capture note/task"      "c" #'org-capture
       :desc "Ensure Org IDs"         "h" #'cc/org-id-get-create-all
       :desc "Refile heading"         "r" #'org-refile
       :desc "Archive heading"        "A" #'org-archive-subtree
       :desc "Set tags"               "t" #'org-set-tags-command))

;; Roam entry points.  Guarded: org-roam is not installed (`:lang org'
;; without `+roam'), so these appear only after `(package! org-roam)'
;; + `doom sync'.  Nothing here errors while it is absent.
(after! org-roam
  (map! :leader
        (:prefix ("o" . "org")
         :desc "Find or create roam node" "f" #'org-roam-node-find
         :desc "Insert roam link"         "i" #'org-roam-node-insert
         :desc "Toggle backlinks buffer"  "l" #'org-roam-buffer-toggle)))

(map! :map org-mode-map :localleader
      :n "J" #'org-next-visible-heading
      :v "J" #'org-next-visible-heading
      :n "K" #'org-previous-visible-heading
      :v "K" #'org-previous-visible-heading)

;; ============================================================================
;; Treemacs (`SPC e')
;; ============================================================================
;; Only the entry point lives here: navigation and file operations are
;; treemacs built-ins (vim keys via treemacs-evil); the extra C-h/j/k/l
;; below just make window movement from inside the tree match the bare
;; global keys.  (`M-SPC e' in Emacs state comes free via the alt leader.)
;; NOTE: `+treemacs/toggle' (not plain `treemacs') is the entry point on
;; purpose: it adds and displays ONLY the current project, so the tree
;; always opens at the project directory of the current buffer.  Plain
;; `treemacs' just restores the last session, which is why `SPC e'
;; previously opened the wrong directory.

(map! :leader
      :desc "Toggle tree at project root" "e" #'+treemacs/toggle)

(after! treemacs
  (map! :map treemacs-mode-map
        "C-h" #'evil-window-left
        "C-j" #'evil-window-down
        "C-k" #'evil-window-up
        "C-l" #'evil-window-right
        ;; Neo-tree style file operations (treemacs built-ins).
        "a"           #'treemacs-create-file
        "d"           #'treemacs-delete-file
        "x"           #'treemacs-move-file
        "p"           #'treemacs-copy-file
        "r"           #'treemacs-rename-file
        "c"           #'treemacs-copy-file
        "."           #'treemacs-root-up
        "<backspace>" #'treemacs-root-up)
  ;; NvChad-style: picking a file jumps via ace-window when several
  ;; windows are open.
  (treemacs-define-RET-action 'file-node-closed #'treemacs-visit-node-ace)
  (treemacs-define-RET-action 'file-node-open   #'treemacs-visit-node-ace))

;; ============================================================================
;; Window (`SPC w')
;; ============================================================================
;; All six show under one which-key "Window" group.

(map! :leader
      (:prefix ("w" . "window")
       :desc "Split, new window left"  "h" #'cc-window-split-left
       :desc "Split, new window below" "j" #'cc-window-split-below
       :desc "Split, new window above" "k" #'cc-window-split-above
       :desc "Split, new window right" "l" #'cc-window-split-right
       :desc "Close this window"       "d" #'delete-window
       :desc "Keep only this window"   "o" #'delete-other-windows))

;; ============================================================================
;; Project (`SPC p', builtin project.el)
;; ============================================================================

(map! :leader
      (:prefix ("p" . "project")
       :desc "Switch project"       "p" #'project-switch-project
       :desc "Find file in project" "f" #'project-find-file
       :desc "Grep project"         "s" #'project-search
       :desc "Dired at root"        "d" #'project-dired
       :desc "Kill buffers"         "k" #'project-kill-buffers))

;; ============================================================================
;; Help (`SPC h')
;; ============================================================================
;; `SPC h h' exists because `C-h e' (the default for
;; `view-echo-area-messages') is displaced by the window keys above.

(map! :leader
      (:prefix ("h" . "help")
       :desc "Describe a key"      "k" #'describe-key
       :desc "Describe a function" "f" #'describe-function
       :desc "Describe a variable" "v" #'describe-variable
       :desc "Describe this mode"  "m" #'describe-mode
       :desc "Show messages"       "h" #'view-echo-area-messages
       :desc "Reload config"       "r" #'doom/reload))

;; ============================================================================
;; Local leader (`,') -- eval / build / debug
;; ============================================================================
;; Bound via Doom's `:localleader' (normal/visual/motion/emacs/insert;
;; insert/emacs use `M-,').  Spec contexts say normal/visual; the extra
;; states are Doom-standard localleader behavior, not an addition.
;; Conflict note: in org buffers Doom already owns `, e'
;; (`org-export-dispatch'), which shadows the `, e ...' eval prefix
;; there -- use `M-x eval-buffer' (or `SPC c e'-style eval) in org.
;; `, m' / `, t' are empty containers so which-key shows the group
;; names; language modules claim keys underneath later.

(map! :localleader
      (:prefix ("e" . "eval")
       :desc "Evaluate buffer" "b" #'eval-buffer
       :desc "Evaluate region" "r" #'eval-region
       :desc "Evaluate defun"  "f" #'eval-defun
       :desc "Evaluate sexp"   "l" #'eval-last-sexp)
      (:prefix ("c" . "build")
       :desc "Run build command"  "c" #'compile
       :desc "Re-run last build"  "r" #'recompile)
      (:prefix ("d" . "debug")
       :desc "Toggle debug on error"     "e" #'toggle-debug-on-error
       :desc "Watch variable (debugger)" "v" #'debug-on-variable-change)
      (:prefix ("m" . "Mode")
       :desc "Reserved for language modules" "m" #'ignore)
      (:prefix ("t" . "Test")
       :desc "Reserved for test runners" "t" #'ignore))

;; ============================================================================
;; Completion (consult / embark -- from Doom's vertico module)
;; ============================================================================
;; - `M-g g' keeps its default meaning (goto-line), now with preview.
;; - Terminal limitation: plain terminals may not send `C-.'; there use
;;   `M-x embark-act'.  GUI and Kitty-protocol terminals are unaffected.
;; - Minibuffer vim keys come from evil-collection; vertico, orderless
;;   and marginalia add no bindings of their own.
;; - In-buffer completion is global via company + company-box childframes
;;   (lsp-mode feeds it through `company-capf' in managed buffers);
;;   `C-n' / `C-p' navigate, `RET' confirms (Doom bindings on top of
;;   company defaults, vim-tuned by `evil-collection`).

(map! "M-g g" #'consult-goto-line
      "M-g i" #'consult-imenu
      "M-s l" #'consult-line
      "M-y"   #'consult-yank-pop
      "C-."   #'embark-act)

;; ============================================================================
;; Editing / Evil
;; ============================================================================
;; Doom's `doom-leader-map' already IS the vim-style leader (SPC in
;; normal/visual/motion, `M-SPC' in insert/emacs), so no separate
;; `cc-leader-map' is needed -- that name only exists in the vanilla spec.
;; - `C-u' displaces the default `universal-argument' prefix (still on
;;   `M-u' / `C-u' in insert/emacs states).
;; - Terminal limitation: terminals send `C-i' and `TAB' as the same code
;;   without Kitty keyboard protocol, so `evil-jump-forward' (`C-i') is
;;   only reachable in GUI or Kitty-protocol terminals.  `C-o' always works.

(map! :n :v "C-u" #'evil-scroll-up
      :n :m "C-o" #'evil-jump-backward
      ;; Bare `q' (macro record) is freed; record on `C-M-r', play with
      ;; `@' as usual.
      :n "q" nil
      :n "C-M-r" #'evil-record-macro)

;; ============================================================================
;; Extras kept from the previous config (no spec conflicts)
;; ============================================================================

;; -- Save ----------------------------------------------------------------
(map! "C-s" (cmd! (save-buffer)
                  (message "Saved")))

;; -- SPC C v u/r (config > vim/doom) --------------------------------------
(map! :leader
      (:prefix ("C" . "config")
       (:prefix ("v" . "vim/doom")
        :desc "Update packages" "u" #'doom/doom-upgrade
        :desc "Reload config"   "r" #'doom/reload)))

;; -- SPC q (quit) -----------------------------------------------------------
(map! :leader
      (:prefix ("q" . "quit")
       :desc "all (no save)" "a" (cmd! (kill-emacs))
       :desc "buffer/window" "b" #'evil-quit
       :desc "quit vim"      "q" (cmd! (kill-emacs))
       :desc "others"        "o" #'delete-other-windows))

;; -- SPC -/| (quick splits, no menu) ----------------------------------------
(map! :leader
      :desc "Up/Down split"    "-" #'split-window-below
      :desc "Left/Right split" "|" #'split-window-right)

;; -- Bare root-level ----------------------------------------------------------
(map! :n "C-q" #'evil-quit
      :n "M-q" (cmd! (kill-emacs)))

;; Avy jump (needs `avy'; declared in packages.el).  Shadows vim
;; find-char `f' in normal/visual/operator states by design.
(map! :n "f" #'evil-avy-goto-char-timer
      :v "f" #'evil-avy-goto-char-timer
      :o "f" #'evil-avy-goto-char-timer)

;; Treesitter-scope style jump (needs `expand-region' in packages.el).
(map! :n "F" #'er/expand-region)

;; Workspace tabs (needs :ui workspaces; Tab is rebound per-mode by org,
;; yasnippet and company-box popups -- see CONFLICTS below).
(map! :n "<tab>"     #'+workspace/switch-right
      :n "<backtab>" #'+workspace/switch-left)

;; -- Ghostel terminal (SPC t) ---------------------------------------------------
(map! :leader
      (:prefix ("t" . "toggle")
       :desc "Ghostel terminal"    "t" #'ghostel
       :desc "Ghostel split left"  "h" (cmd! (ghostel))
       :desc "Ghostel split down"  "j" (cmd! (select-window (split-window-below)) (ghostel))
       :desc "Ghostel split up"    "k" (cmd! (split-window-below) (ghostel))
       :desc "Ghostel split right" "l" (cmd! (select-window (split-window-right)) (ghostel))))

;; Better escape: `jk' quits to normal state.
(after! evil-escape
  (setq evil-escape-key-sequence "jk"
        evil-escape-delay 0.15))
(after! ghostel
  (map! :map ghostel-mode-map
        :i "j k" #'evil-normal-state))

;; -- mini.move-style Alt-h/j/k/l ---------------------------------------------
;; Normal shifts the current line; visual shifts the selection and
;; reselects it (mirrors mini.move).  Needs `drag-stuff' in packages.el
;; for the M-j / M-k lines.
(map! :n "M-h" #'evil-shift-left-line
      :n "M-l" #'evil-shift-right-line
      :v "M-h" #'+evil/visual-dedent
      :v "M-l" #'+evil/visual-indent
      :n "M-j" #'drag-stuff-down
      :n "M-k" #'drag-stuff-up
      :v "M-j" #'drag-stuff-down
      :v "M-k" #'drag-stuff-up)

;; -- Blackhole-register delete --------------------------------------------------
;; Binding a key to the *string* "\"_d" would replay through the keymap
;; and recurse forever; setting `evil-this-register' directly and calling
;; the real command avoids the replay entirely.
(defun cc/delete-blackhole ()
  "Like `d', but always deletes into the blackhole register."
  (interactive)
  (setq evil-this-register ?_)
  (call-interactively #'evil-delete))

(defun cc/delete-blackhole-eol ()
  "Like `D', but always deletes into the blackhole register."
  (interactive)
  (setq evil-this-register ?_)
  (call-interactively #'evil-delete-line))

(map! :n "d" #'cc/delete-blackhole
      :v "d" #'cc/delete-blackhole
      :n "D" #'cc/delete-blackhole-eol
      :v "D" #'cc/delete-blackhole-eol)

;; ============================================================================
;; CONFLICTS (why the overrides above are safe / known-sharp)
;; ============================================================================
;; - Each global `map!' writes into the same evil state keymap the old
;;   binding lived in, so replacements need no extra unbinding:
;;   C-s, C-q, M-q, f/F (n,v,o), H/L, bare q, M-h/M-l, M-j/M-k,
;;   SPC q q/a, SPC b *, SPC f f, SPC c D, SPC e, SPC o l.
;; - Org wins over global M-h/j/k/l: `evil-org-mode-map' is more specific
;;   than the state maps, so M-h/M-l stay heading promote/demote and
;;   M-j/M-k stay subtree-move inside org buffers.  Deliberate: org
;;   structure editing beats line moving there.
;; - Tab is rebound per-mode (org cycling, yasnippet, company-box
;;   popups);
;;   those win over workspace-switching whenever active.  If switching
;;   stops in one mode, inspect with `SPC h k <tab>'.
;; - `C-h' == Backspace in terminals without Kitty protocol (see top).
;; - `C-.' may not exist on plain terminals (see Completion).

(provide 'cc-keymaps)
;;; cc-keymaps.el ends here

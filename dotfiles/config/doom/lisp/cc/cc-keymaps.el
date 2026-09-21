;;; config.el -*- lexical-binding: t; -*-

;; ============================================================================
;; Containers / localleader setup
;; (doom-localleader-key must be set before evil builds the leader keymaps,
;; so this block stays at the top of the file)
;; ============================================================================

(setq doom-localleader-key ";"
      doom-localleader-alt-key "M-;")

(after! which-key
  (setq which-key-idle-delay 0.2           ; default ~0.4-1s before first popup
        which-key-idle-secondary-delay 0.05) ; delay for subsequent prefixes, once it's already open
  (which-key-add-key-based-replacements
    "SPC C"   "config"
    "SPC C v" "vim/doom"
    "SPC x"   "execute"
    "SPC v"   "visualize"))

;; ============================================================================
;; Keybindings
;; ============================================================================

;; -- Save (force) ------------------------------------------------------
(map! "C-s" (cmd! (save-buffer)
                  (message "Saved")))

;; -- SPC C v u/r  (config > vim/doom) -----------------------------------
(map! :leader
      (:prefix ("C" . "config")
               (:prefix ("v" . "vim/doom")
                :desc "Update packages" "u" #'doom/doom-upgrade  ; if this command
                :desc "Reload config"   "r" #'doom/reload)))     ; doesn't exist on
                                        ; your version, run
                                        ; `doom upgrade`
                                        ; from a shell instead

;; -- SPC q *  (quit) ------------------------------------------------------
(map! :leader
      (:prefix ("q" . "quit")
       :desc "all (no save)" "a" (cmd! (kill-emacs))
       :desc "buffer/window" "b" #'evil-quit
       :desc "quit vim"      "q" (cmd! (kill-emacs))
       :desc "others"        "o" #'delete-other-windows))

;; -- SPC -/|  (splits) ----------------------------------------------------
(map! :leader
      :desc "Up/Down split"    "-" #'split-window-below
      :desc "Left/Right split" "|" #'split-window-right)

;; -- Bare (root-level, no leader) ---------------------------------------
(map! :n "C-q" #'evil-quit
      :n "M-q" (cmd! (kill-emacs)))

;; Global search, forward/backward. Needs `avy` — most Doom installs pull
;; it in as a dependency already; if `evil-avy-goto-char-timer` is void,
;; add this to packages.el and run `doom sync`:
;;   (package! avy)
(map! :n "f" #'evil-avy-goto-char-timer
      :v "f" #'evil-avy-goto-char-timer
      :o "f" #'evil-avy-goto-char-timer)


;; File tree
(after! treemacs
  (map! :map treemacs-mode-map
        "C-h" #'evil-window-left
        "C-j" #'evil-window-down
        "C-k" #'evil-window-up
        "C-l" #'evil-window-right))

;; -- Treemacs window-picker on open (NvChad style) -----------------------
;; Hooks directly into Treemacs' native RET action pipeline to trigger ace-window
(after! treemacs
  (treemacs-define-RET-action 'file-node-closed #'treemacs-visit-node-ace)
  (treemacs-define-RET-action 'file-node-open   #'treemacs-visit-node-ace))
;; -- SPC e  (file tree / treemacs) ---------------------------------------
(map! :leader
      :desc "Toggle Treemacs" "e" #'+treemacs/toggle)

;; "Treesitter scope jump" has no built-in Emacs equivalent. Pick ONE:
;;   combobulate   -- structural/treesit navigation, closest analog, not
;;                     on MELPA, install manually from
;;                     https://github.com/mickeynp/combobulate
;;   expand-region -- simpler fallback, on MELPA:
;;                     (package! expand-region)
;; Neither is installed by default, so this is commented out until you
;; pick one and install it:
;; (map! :n "F" #'combobulate-navigate-up)      ; needs combobulate
(map! :n "F" #'er/expand-region)             ; needs (package! expand-region)

;; Buffer navigation on bare H/L
(map! :n "H" #'previous-buffer
      :n "L" #'next-buffer)

;; Tab navigation -> Doom's workspaces module (:ui workspaces). If that
;; module isn't in your init.el, comment this out and use
;; `tab-next`/`tab-previous` (native tab-bar-mode) instead:
;; (map! :n "<tab>" #'tab-next :n "<backtab>" #'tab-previous)
(map! :n "<tab>"     #'+workspace/switch-right
      :n "<backtab>" #'+workspace/switch-left)

;; -- SPC b *  (buffer) — adding to Doom's existing group ----------------
(map! :leader
      (:prefix ("b" . "buffer")
       :desc "Left/Right split" "l" #'split-window-right
       :desc "Up/Down split"    "j" #'split-window-below
       :desc "New buffer"       "n" #'evil-buffer-new
       :desc "New tab"          "t" #'+workspace/new))  ; needs :ui workspaces,
                                        ; see note above

;; -- Terminal --------------------------------------------------------------
;; -- SPC t * (toggle/terminal) — custom bindings for Ghostel ---------------
(map! :leader
      (:prefix ("t" . "toggle")
       :desc "Ghostel terminal"   "t" #'ghostel
       :desc "Ghostel split left"  "h" (cmd! (ghostel)) ; opens left if you split left first
       :desc "Ghostel split down"  "j" (cmd! (select-window (split-window-below)) (ghostel))
       :desc "Ghostel split up"    "k" (cmd! (split-window-below) (ghostel))
       :desc "Ghostel split right" "l" (cmd! (select-window (split-window-right)) (ghostel))))

;; Better escape
;; Configure evil-escape globally for 'jk' sequence
(after! evil-escape
  (setq evil-escape-key-sequence "jk")
  (setq evil-escape-delay 0.15))

;; Explicitly bind 'jk' inside ghostel keymap
(after! ghostel
  (map! :map ghostel-mode-map
        :i "j k" #'evil-normal-state))


;; -- mini.move-style Alt-h/j/k/l -----------------------------------------
;; Alt-h / Alt-l : decrease / increase indent (dedent/indent).
;; Normal state shifts the current line; visual state shifts the selection
;; and reselects it afterward (mirrors mini.move keeping you in visual
;; mode so you can repeat). No extra package needed -- these are all
;; built into evil / Doom already.
(map! :n "M-h" #'evil-shift-left-line
      :n "M-l" #'evil-shift-right-line
      :v "M-h" #'+evil/visual-dedent
      :v "M-l" #'+evil/visual-indent)

;; Alt-j / Alt-k : move the current line (normal) or selection (visual)
;; down / up. This is `drag-stuff`, which Doom used to auto-bind under
;; evil but no longer does ("drag-stuff: make non-evil only"), so on most
;; current Doom installs the package isn't pulled in for evil users.
;; Add this to packages.el and run `doom sync` first:
;;  (package! drag-stuff)
;; then uncomment:
(map! :n "M-j" #'drag-stuff-down
      :n "M-k" #'drag-stuff-up
      :v "M-j" #'drag-stuff-down
      :v "M-k" #'drag-stuff-up)

;; -- Disable macro recording on bare q, move it to C-M-r -----------------
(map! :n "q" nil
      :n "C-M-r" #'evil-record-macro)


;; And for the org mode overlap
(after! evil-org
  (map! :map evil-org-mode-map
        ;; Remove C-j / C-k from org's map so global window navigation works everywhere
        :n "C-j" nil
        :n "C-k" nil
        ;; Rebind org heading / item navigation to J and K
        :n "J" #'org-forward-heading-same-level
        :n "K" #'org-backward-heading-same-level))

;; Window navigation.
(map! :n "C-h" #'evil-window-left
      :n "C-j" #'evil-window-down
      :n "C-k" #'evil-window-up
      :n "C-l" #'evil-window-right)

;; Clear Org-mode overrides so global C-j/C-k pass through, and assign J/K
(after! org
  (map! :map org-mode-map
        :n "C-j" nil
        :n "C-k" nil))

(after! evil-org
  (map! :map evil-org-mode-map
        :n "C-j" nil
        :n "C-k" nil
        ;; Rebind org heading navigation to J and K
        :n "J" #'org-forward-heading-same-level
        :n "K" #'org-backward-heading-same-level))

;;; Copy pasting
;; -- Blackhole-register delete, explicit clipboard cut --------------------
;; NOTE: binding a key to a *string* in map!/general.el makes it a replayed
;; keyboard macro, not a literal vim command -- so binding "d" to the
;; string "\"_d" replays d/_/d through the keymap again, hits this same
;; binding, and recurses forever (net effect: d does nothing). Setting
;; `evil-this-register` directly and calling the real command avoids the
;; replay entirely.
(defun +cc/delete-blackhole ()
  "Like `d', but always deletes into the blackhole register."
  (interactive)
  (setq evil-this-register ?_)
  (call-interactively #'evil-delete))

(defun +cc/delete-blackhole-eol ()
  "Like `D', but always deletes into the blackhole register."
  (interactive)
  (setq evil-this-register ?_)
  (call-interactively #'evil-delete-line))

;; Copy paste stuff less annoying
(map! :n "d" #'+cc/delete-blackhole
      :v "d" #'+cc/delete-blackhole
      :n "D" #'+cc/delete-blackhole-eol
      :v "D" #'+cc/delete-blackhole-eol
      )

;; Fuzzy finding.
;; Add fuzzy file and text searching under SPC f without overriding other bindings
;; Safely rebind SPC f f and SPC f w without wiping other SPC f keys
(map! :leader
      :desc "Fuzzy find file in project" "f f" #'projectile-find-file
      :desc "Fuzzy find text in project" "f w" #'+default/search-project
      )



;; Orgmode syntax


;; ============================================================================
;; CONFLICTS
;; ============================================================================
;;
;; -- Already resolved, no action needed ------------------------------------
;; Each `map!` call above writes directly into evil's normal/visual state
;; keymaps, which is the SAME keymap the old binding lived in — so the new
;; binding simply replaces the old one. Nothing else to do for these:
;;   C-s          replaces `isearch-forward`
;;   C-q          replaces `quoted-insert`
;;   M-q          replaces `fill-paragraph`
;;   f / F (n,v,o) replace evil's char-search motions (find-char/till-char)
;;   H / L        replace `evil-window-top` / `evil-window-bottom`
;;   q (bare)     replaces `evil-record-macro` (moved to C-M-r, already
;;                done above via `:n "q" nil`)
;;   M-h / M-l    replace `mark-paragraph` / `downcase-word`
;;   M-j / M-k    replace `default-indent-new-line` / `kill-sentence`
;;   SPC q q/a    replace Doom's default confirm-before-quit bindings
;;   SPC b n      replaces Doom's default SPC b n binding
;; These commands are still reachable via M-x or in insert-state; they're
;; just no longer on these keys in evil's normal/visual state.
;;
;; -- Real conflict: org-mode wins over the global M-h/j/k/l above ---------
;; `evil-org-mode-map` is a minor-mode keymap that's MORE SPECIFIC than
;; evil's normal-state-map, so inside org buffers it takes priority over
;; everything above: M-h/M-l stay bound to heading promote/demote, and
;; M-j/M-k stay bound to move-subtree, no matter what we bind globally.
;;
;; If you want mini.move-style indent/move instead, uncomment this to
;; remove org-mode's bindings and install ours in their place (needs
;; `drag-stuff` for the M-j/M-k lines — see the note above):
;; (after! evil-org
;;   (map! :map evil-org-mode-map
;;         :n "M-h" nil
;;         :n "M-l" nil
;;         :n "M-j" nil
;;         :n "M-k" nil)
;;   (map! :map evil-org-mode-map
;;         :n "M-h" #'evil-shift-left-line
;;         :n "M-l" #'evil-shift-right-line
;;         :n "M-j" #'drag-stuff-down
;;         :n "M-k" #'drag-stuff-up))
;;
;; If you'd rather keep org's heading/subtree bindings as-is, leave this
;; commented out — no action needed.
;;
;; -- Real conflict: Tab is heavily reused per-mode -------------------------
;; <tab>/<backtab> are locally rebound inside many major/minor modes
;; (org-mode cycling, yasnippet field-jumps, company/corfu completion
;; popups) via their own more-specific keymaps, and those will win over
;; the global workspace-switch binding above whenever they're active.
;; There's no single safe "remove old, add new" fix here since it's a
;; different local keymap per mode — if workspace-switching stops working
;; in a specific mode, find that mode's Tab binding with `SPC h k <tab>`
;; and decide there whether to unbind it.
;; Map SPC f w to fuzzy find/grep text across project files




;;; Custom functions
;;; Custom functions
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

;; Hook into Doom's leader key layout
(map! :leader
      :desc "Ensure Org IDs for all headings"
      "o h" #'cc/org-id-get-create-all)




;;; Custom functions & nvim-orgmode bindings
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

;; Inject nvim-orgmode style keybindings into Doom's SPC o leader menu
(map! :leader

      ;; nvim-orgmode core action mappings under SPC o
      (:prefix ("o" . "open/org")
       :desc "Agenda"                     "a" #'org-agenda
       :desc "Capture"                    "c" #'org-capture
       :desc "Ensure Org IDs for all headings" "h" #'cc/org-id-get-create-all

       ;; Links (nvim-orgmode <leader>oi / <leader>oli)
       (:prefix ("l" . "links")
        :desc "Insert link"               "i" #'org-insert-link
        :desc "Store link"                "s" #'org-store-link
        :desc "Next link"                 "n" #'org-next-link
        :desc "Previous link"             "p" #'org-previous-link)

       ;; Refile / Archive / Tags
       :desc "Refile heading"             "r" #'org-refile
       :desc "Archive heading"            "A" #'org-archive-subtree
       :desc "Set tags"                   "t" #'org-set-tags-command))

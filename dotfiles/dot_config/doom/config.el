;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;

                                        ; TODO fix
                                        ; (setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
                                        ;       doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; Navigation shortcuts

(after! treemacs
  ;; Follow the current file in the tree as you switch buffers
  (treemacs-follow-mode 1)

  ;; Positioning & width settings
  (setq treemacs-position 'left
        treemacs-width 35))

(map! :leader
      :desc "Toggle Treemacs"
      :nv "e" #'treemacs) ; Using 'treemacs autoloads the package reliably
;;  nv is to make it work on gui.



;; Auto-add current directory as a Projectile project on startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (when-let ((dir default-directory))
              (projectile-add-known-project dir)
              (setq projectile-project-root dir))))



;; 1. Global Ctrl+hjkl window navigation
(map! :n "C-h" #'evil-window-left
      :n "C-j" #'evil-window-down
      :n "C-k" #'evil-window-up
      :n "C-l" #'evil-window-right)

;; 2. Force Treemacs to honor Ctrl+hjkl window navigation
(after! treemacs
  (define-key treemacs-mode-map (kbd "C-h") #'evil-window-left)
  (define-key treemacs-mode-map (kbd "C-j") #'evil-window-down)
  (define-key treemacs-mode-map (kbd "C-k") #'evil-window-up)
  (define-key treemacs-mode-map (kbd "C-l") #'evil-window-right))


(with-eval-after-load
    ;; Save buffer
    (map! "C-s" #'save-buffer)
  (map! "C-q" #'kill-current-buffer)
  )


;; Quit Doom Emacs (Alt-q / M-q) globally across normal/insert/visual states
(map! :gnv "M-q" #'kill-emacs)

;; Copy paste. Synchronizing the copy paste with system copy paste
;; so i can avoid having to put the + first like +y
(setq select-enable-clipboard t)

;; =============================================================================
;; LEADER / CONTAINER KEYMAP DESCRIPTIONS (Which-Key Setup)
;; =============================================================================
;; Replicates your keymaps-container table descriptions for Doom's SPC menu
(which-key-add-key-based-replacements
  "SPC b"  "[b]uffer"
  "SPC C"  "[C]onfig"
  "SPC Cv" "[v]im"
  "SPC q"  "[q]uit"
  "SPC f"  "[f]ind"
  "SPC g"  "[g]enerate / [g]it"
  "SPC c"  "[c]ode"
  "SPC ct" "[t]roubles diagnostic"
  "SPC o"  "[o]pen"
  "SPC ob" "[b]uild"
  "SPC x"  "E[x]ecute"
  "SPC d"  "[d]ebug"
  "SPC v"  "[v]isualize")


;; =============================================================================
;; ROOT / GLOBAL KEYMAPS
;; =============================================================================
;; Jump to previous (gh) and next (gl) code locations in Normal mode
;; Jump to previous (gh) and next (gl) code locations in Normal mode
(map! :n "gh" #'evil-jump-backward
      :n "gl" #'evil-jump-forward)

;; Save current buffer (<C-s>)
(map! "C-s" #'save-buffer)

;; Split shortcuts (containers.root <leader>- and <leader>|)
(map! :leader
      :desc "Horizontal split" "-" #'evil-window-split
      :desc "Vertical split"   "|" #'evil-window-vsplit)

;; Root Quit / Buffer closes (containers.root <C-q> and <A-q>)
(map! "C-q" #'kill-current-buffer)             ; Close current buffer
(map! :gnv "M-q" #'save-buffers-kill-terminal) ; Quit all/Doom (Alt-q / Meta-q)

;; Disable 'q' macro recording to prevent accidental triggers (containers.root q)
(map! :n "q" #'ignore)
;; Re-map macro recording to Ctrl+Alt+r (containers.root <C-A-r>)
(map! :n "C-M-r" #'evil-record-macro)


;; =============================================================================
;; FLASH / NAVIGATION EQUIVALENTS (f and F)
;; =============================================================================
;; Doom uses 'avy' as its built-in equivalent to 'flash.nvim'
(map! :nv "f" #'avy-goto-char-timer) ; Jump anywhere on screen (Forward/Backward)
(map! :nv "F" #'avy-goto-line)       ; Scope/Line level jump


;; =============================================================================
;; PREFIX / CONTAINER SPECIFIC KEYMAPS
;; =============================================================================

;; --- <leader>q [q]uit container ---
(map! :leader
      :prefix ("q" . "[q]uit")
      :desc "[a]ll"     "a" #'save-buffers-kill-terminal
      :desc "[b]uffer"  "b" #'kill-current-buffer
      :desc "[q]uit"    "q" #'save-buffers-kill-terminal
      :desc "[o]thers"  "o" #'delete-other-windows)

;; --- <leader>b [b]uffer container ---
(map! :leader
      :prefix ("b" . "[b]uffer")
      :desc "[v]ertical split"   "v" #'evil-window-vsplit
      :desc "[h]orizontal split" "h" #'evil-window-split)

;; --- <leader>Cv [v]im config update container ---
(map! :leader
      :prefix ("C" . "[C]onfig")
      :desc "[U]pdate packages" "vu" #'doom/reload-packages)

;; Show which-key popup almost instantly (0.05 seconds delay instead of default ~1s)
(setq which-key-idle-delay 0.05)

;; Optional: Show replacement/description changes immediately as you type sub-keys
(setq which-key-idle-secondary-delay 0.05)


(after! which-key
  ;; Set popup delay to 0.05s
  (setq which-key-idle-delay 0.05)
  ;; Maximum height/width of the popup box
  (setq which-key-max-description-length 32))


;; Map 'SPC f w' to live grep across the project (Telescope / fzf-lua live_grep equivalent)
(map! :leader
      :prefix ("f" . "[f]ind")
      :desc "Find word in project (Live Grep)" "w" #'+default/search-project)



(use-package! vertico-posframe
  :after vertico
  :config
  (vertico-posframe-mode 1)

  ;; Customize popup appearance
  (setq vertico-posframe-parameters
        '((left-fringe . 8)
          (right-fringe . 8)
          (internal-border-width . 2)))

  ;; Set position to center (like Telescope/fzf-lua)
  (setq vertico-posframe-poshandler #'posframe-poshandler-frame-center)

  ;; Set width and height ratios
  (setq vertico-posframe-height 20
        vertico-posframe-width 120))



;;; Modus themes.
;;;


(use-package modus-themes
  :ensure t
  :demand t
  :init
  ;; Starting with version 5.0.0 of the `modus-themes', other packages
  ;; can be built on top to provide their own "Modus" derivatives.
  ;; For example, this is what I do with my `ef-themes' and
  ;; `standard-themes' (starting with versions 2.0.0 and 3.0.0,
  ;; respectively).
  ;;
  ;; The `modus-themes-include-derivatives-mode' makes all Modus
  ;; commands that act on a theme consider all such derivatives, if
  ;; their respective packages are available and have been loaded.
  ;;
  ;; Note that those packages can even completely take over from the
  ;; Modus themes such that, for example, `modus-themes-rotate' only
  ;; goes through the Ef themes (to this end, the Ef themes provide
  ;; the `ef-themes-take-over-modus-themes-mode' and the Standard
  ;; themes have the `standard-themes-take-over-modus-themes-mode'
  ;; equivalent).
  ;;
  ;; If you only care about the Modus themes, then (i) you do not need
  ;; to enable the `modus-themes-include-derivatives-mode' and (ii) do
  ;; not install and activate those other theme packages.
  (modus-themes-include-derivatives-mode 1)
  :bind
  (("<f5>" . modus-themes-rotate)
   ("C-<f5>" . modus-themes-select)
   ("M-<f5>" . modus-themes-load-random))
  :config
  ;; Your customizations here.  All customizations must evaluated
  ;; BEFORE loading the theme.
  (setq modus-themes-to-toggle '(modus-operandi modus-vivendi)
        modus-themes-to-rotate modus-themes-items
        modus-themes-mixed-fonts t
        modus-themes-variable-pitch-ui t
        modus-themes-italic-constructs t
        modus-themes-bold-constructs t
        modus-themes-completions '((t . (bold)))
        modus-themes-prompts '(bold)
        modus-themes-headings
        '((agenda-structure . (variable-pitch light 2.2))
          (agenda-date . (variable-pitch regular 1.3))
          (t . (regular 1.15))))

  (setq modus-themes-common-palette-overrides nil)

  ;; Finally, load your theme of choice (or a random one with
  ;; `modus-themes-load-random', `modus-themes-load-random-dark',
  ;; `modus-themes-load-random-light').
  (modus-themes-load-theme 'modus-operandi))(use-package modus-themes
  :ensure t
  :demand t
  :init
  ;; Starting with version 5.0.0 of the `modus-themes', other packages
  ;; can be built on top to provide their own "Modus" derivatives.
  ;; For example, this is what I do with my `ef-themes' and
  ;; `standard-themes' (starting with versions 2.0.0 and 3.0.0,
  ;; respectively).
  ;;
  ;; The `modus-themes-include-derivatives-mode' makes all Modus
  ;; commands that act on a theme consider all such derivatives, if
  ;; their respective packages are available and have been loaded.
  ;;
  ;; Note that those packages can even completely take over from the
  ;; Modus themes such that, for example, `modus-themes-rotate' only
  ;; goes through the Ef themes (to this end, the Ef themes provide
  ;; the `ef-themes-take-over-modus-themes-mode' and the Standard
  ;; themes have the `standard-themes-take-over-modus-themes-mode'
  ;; equivalent).
  ;;
  ;; If you only care about the Modus themes, then (i) you do not need
  ;; to enable the `modus-themes-include-derivatives-mode' and (ii) do
  ;; not install and activate those other theme packages.
  (modus-themes-include-derivatives-mode 1)
  :bind
  (("<f5>" . modus-themes-rotate)
   ("C-<f5>" . modus-themes-select)
   ("M-<f5>" . modus-themes-load-random))
  :config
  ;; Your customizations here.  All customizations must evaluated
  ;; BEFORE loading the theme.
  (setq modus-themes-to-toggle '(modus-operandi modus-vivendi)
        modus-themes-to-rotate modus-themes-items
        modus-themes-mixed-fonts t
        modus-themes-variable-pitch-ui t
        modus-themes-italic-constructs t
        modus-themes-bold-constructs t
        modus-themes-completions '((t . (bold)))
        modus-themes-prompts '(bold)
        modus-themes-headings
        '((agenda-structure . (variable-pitch light 2.2))
          (agenda-date . (variable-pitch regular 1.3))
          (t . (regular 1.15))))

  (setq modus-themes-common-palette-overrides nil)

  ;; Finally, load your theme of choice (or a random one with
  ;; `modus-themes-load-random', `modus-themes-load-random-dark',
  ;; `modus-themes-load-random-light').
  (modus-themes-load-theme 'modus-vivendi))




;; Better escape equivalent
(after! evil-escape
  (setq evil-escape-key-sequence "jk"
        evil-escape-delay 0.15)

  ;; Allow evil-escape to run inside vterm
  (setq evil-escape-excluded-major-modes
        (delq 'vterm-mode evil-escape-excluded-major-modes)))

;; Ensure evil-escape's pre-command hook captures keypresses in vterm-mode
(after! vterm
  (add-hook 'vterm-mode-hook #'evil-escape-mode))




;;;  For popup like telescope
(use-package! vertico-posframe
  :after vertico
  :config
  (vertico-posframe-mode 1)

  ;; Center the popup vertically and horizontally
  (setq vertico-posframe-poshandler #'posframe-poshandler-frame-center)

  ;; Configure border and size to match Telescope feel
  (setq vertico-posframe-parameters
        '((left-fringe  . 8)
          (right-fringe . 8)
          (border-width . 2)))

  ;; Ensure terminal fallback displays in the top/center when posframe isn't native
  (setq vertico-posframe-fallback-mode t))



;;; Centering
;; 1. Centered Search / File / Buffer Popups (Telescope style)
(after! vertico
  (require 'vertico-posframe)
  (vertico-posframe-mode 1)
  (setq vertico-posframe-poshandler #'posframe-poshandler-frame-center
        vertico-posframe-height 20
        vertico-posframe-width 100
        vertico-posframe-border-width 2))

;; 2. Centered Which-Key Popups
(after! which-key
  (setq which-key-popup-type 'frame
        which-key-frame-max-height 20
        which-key-frame-max-width 100
        which-key-posframe-poshandler #'posframe-poshandler-frame-center))

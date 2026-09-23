# AGENTS.md — Emacs Configuration

This file guides any agent (or human) working on this Emacs configuration.
The maintainer is an nvim user, so nothing here is assumed to be "obvious
Emacs knowledge" — everything must be documented explicitly, including
things experienced Emacs users take for granted.

I use doom emacs as the main framework.

## Core principles

1. **Everything is documented.** No silent configuration. Every package,
   every keybinding, every non-trivial setting gets a comment or docstring
   explaining *what* it does and *why* it's there.
2. **Modular files.** No monolithic `init.el`. Configuration is split into
   focused files, one concern per file (see "File layout" below).
3. **Namespace: `cc`.** All custom functions, variables, faces, keymaps,
   and minor modes defined in this config use the `cc-` prefix
   (e.g. `cc-open-terminal`, `cc-leader-map`, `cc/toggle-something`).
   Never define a symbol without the `cc-` prefix unless it's overriding
   or advising an existing package symbol.
4. **`use-package` for everything.** All third-party (and built-in)
   package configuration goes through `use-package`. No bare `require`
   + manual `setq` blocks for anything that can be a `use-package` form.
5. **Terminal-first, UI-second.** The primary usage target is Emacs in a
   terminal (`emacs -nw` / TUI). GUI (`emacs --daemon` with a graphical
   frame, or plain windowed Emacs) is a secondary but supported target.
   Anything that behaves differently between terminal and GUI must be
   guarded with `(display-graphic-p)` and documented as such.

## File layout

```
~/.emacs.d/                      (or wherever this config lives)
├── AGENTS.md                    This file.
├── init.el                      Entry point only: bootstraps package
│                                 manager, sets load-path, requires
│                                 modules in order. No package config here.
├── early-init.el                GC threshold, UI chrome suppression,
│                                 anything that must run before init.el.
├── keybindings.md                Human-readable, auto-checked index of
│                                 EVERY keybinding in the config (see below).
└── lisp/
    ├── cc-core.el                Sane defaults, no external packages.
    ├── cc-packages.el            use-package bootstrap (straight.el /
    │                             package.el / elpaca — pick one, document
    │                             the choice here).
    ├── cc-ui.el                  Theme, modeline, fonts, GUI-only tweaks.
    ├── cc-terminal.el            Terminal-specific behavior (mouse, clipboard,
    │                             TERM handling, vterm/eat/term config).
    ├── cc-keybindings.el         Global leader key, which-key setup,
    │                             general.el bindings. See "Keybindings" below.
    ├── cc-completion.el          vertico/corfu/company, orderless, etc.
    ├── cc-editing.el             Editing behavior (evil-mode if used,
    │                             indentation, whitespace, etc.)
    ├── cc-project.el             project.el / projectile, magit, vc.
    ├── cc-lang-<language>.el     One file per language/major-mode setup
    │                             (e.g. cc-lang-python.el, cc-lang-rust.el).
    └── cc-org.el                 Org-mode config, if used.
```

Rules for this layout:

- Every file in `lisp/` starts with a header comment block (see template
  below) explaining its purpose.
- `init.el` never contains `use-package` forms directly — it only loads
  `lisp/*.el` files in a defined order.
- A new concern (a new language, a new tool integration) gets a new
  `cc-*.el` file, not an addition to an unrelated existing file.

### File header template

Every `lisp/cc-*.el` file starts with:

```elisp
;;; cc-<name>.el --- <one-line description> -*- lexical-binding: t; -*-

;;; Commentary:
;; <2-5 sentences: what this file configures, why it's separate,
;;  any prerequisites (external binaries, fonts, etc.)>

;;; Code:

(require 'cc-core) ; if needed

;; ... use-package forms ...

(provide 'cc-<name>)
;;; cc-<name>.el ends here
```

## `use-package` conventions

- One `use-package` block per package. Don't chain unrelated packages
  in a single block.
- Every `use-package` block has a `;; <purpose>` comment directly above
  it stating why this package is included.
- Preferred keyword order inside a block:
  `:ensure` → `:demand`/`:defer` → `:after` → `:init` → `:custom` →
  `:bind` → `:config`.
- Use `:custom` instead of raw `setq` inside `:config` wherever possible,
  so settings are visible without reading into the config body.
- Every `:bind` inside a `use-package` block must also be reflected in
  `keybindings.md` (see below) — `use-package` `:bind` is not
  self-documenting enough on its own.

Example:

```elisp
;; Fuzzy, terminal-friendly minibuffer completion
(use-package vertico
  :ensure t
  :demand t
  :custom
  (vertico-count 12)
  :config
  (vertico-mode 1))
```

## Keybindings: documentation requirement

Because the maintainer is coming from nvim (where discoverability of
mappings matters a lot), **every keybinding must be traceable from a
single place.**

1. All custom bindings live under a single prefix/leader map defined in
   `cc-keybindings.el`: `cc-leader-map`. Package-specific bindings that
   don't go through the leader (e.g. mode-local bindings) are still
   defined in that package's own `cc-*.el` file, but must still be logged.
2. `which-key` is required and configured in `cc-keybindings.el` so
   every prefix shows its available bindings live, in both terminal and
   GUI.
3. **`keybindings.md`** at the repo root is the single source of truth
   for humans/agents to find a binding without opening Emacs. It is a
   flat, searchable table. Every entry has this exact format:

   ```markdown
   | Key           | Command                  | Mode/Context      | Description                  |
   |---------------|---------------------------|--------------------|------------------------------|
   | `SPC f f`     | `find-file`               | Global (leader)    | Open a file                  |
   | `C-c t`       | `cc-open-terminal`        | Global             | Toggle terminal window       |
   | `M-/`         | `dabbrev-expand`          | Global             | Inline word completion       |
   | `g d`         | `xref-find-definitions`   | evil-normal, prog  | Go to definition             |
   ```

   - "Key" always uses Emacs key notation (`C-`, `M-`, `SPC` for leader
     sequences), never raw keycodes.
   - "Mode/Context" states where the binding is active (Global, a
     specific major mode, a specific evil state if evil-mode is used,
     terminal-only, GUI-only).
   - Any binding that differs between terminal and GUI (because some
     keys — e.g. `C-;`, `C-,`, certain `M-` combos — aren't reliably
     sendable through a terminal) gets a row for each, with the
     difference called out in the Description.
4. **Whenever a keybinding is added, changed, or removed in any
   `lisp/*.el` file, `keybindings.md` must be updated in the same
   change.** An agent making a keybinding edit without updating this
   table has not finished the task.
5. Group `keybindings.md` by section (Global / Leader / Terminal /
   Completion / Project / Git / Org / Language-specific) matching the
   `lisp/cc-*.el` file that owns those bindings, so a section maps
   1:1 to a source file.

## Terminal vs. GUI

- Default target: `emacs -nw` in a terminal emulator. Test everything
  here first.
- Anything GUI-only (fonts, `set-frame-font`, transparency, icons that
  need a graphical toolkit, `all-the-icons`/`nerd-icons` glyphs that
  don't render correctly in some terminals) goes in `cc-ui.el`, guarded
  by `(when (display-graphic-p) ...)`.
- Anything terminal-specific (clipboard integration via OSC 52,
  mouse reporting, `xterm-mouse-mode`, distinguishing `C-i`/`TAB` and
  `C-m`/`RET` which terminals can't tell apart without special escape
  sequences) goes in `cc-terminal.el`, guarded by
  `(unless (display-graphic-p) ...)`.
- Document any known terminal limitation directly as a comment where
  it's worked around (e.g. "terminal cannot distinguish `C-i` from
  `TAB`, so this binding is only reachable via GUI or a terminal that
  supports Kitty's keyboard protocol").

## Package manager

State explicitly which package manager this config uses
(`package.el`, `straight.el`, or `elpaca`) and document the bootstrap
in `cc-packages.el` with comments explaining each bootstrap step —
don't assume the reader knows how Emacs package bootstrapping works.

## Style / linting

- 2-space indentation (standard Emacs Lisp indent via `indent-region`).
- Run `checkdoc` on any file before considering it finished.
- Prefer `setopt`/`:custom` over raw `setq` for user-facing options.
- No trailing whitespace; files end with the closing `;;; cc-<name>.el
  ends here` comment.

## Checklist for any change

- [ ] New/changed package config goes through `use-package`.
- [ ] New file (if any) has the standard header and `cc-` namespace.
- [ ] New/changed keybinding added to `cc-keybindings.el` (or the
      relevant module) **and** to `keybindings.md`.
- [ ] Terminal behavior verified in `emacs -nw`; GUI-only code guarded
      with `(display-graphic-p)`.
- [ ] Comments explain *why*, not just *what*.

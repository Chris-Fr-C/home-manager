# Keybindings

Single source of truth for every custom binding. `SPC` means the leader
(`cc-leader-map`, bound to `SPC` in evil modal states and to `M-SPC`
globally). `,` means the local leader (`cc-local-leader-map`, bound to
`,` in evil normal and visual states). Evil's stock vim keys (`h j k l`,
`d`, `y`, etc.) are provided by `evil` itself and not listed
individually; only config-added bindings are listed here.

## Leader (cc-keybindings.el)

| Key       | Command            | Mode/Context    | Description                                              |
|-----------|--------------------|-----------------|----------------------------------------------------------|
| `M-SPC`   | `cc-leader-map`    | Global          | Leader prefix (terminal-safe SPC)                        |
| `,`       | `cc-local-leader-map` | evil-normal, evil-visual | Local leader prefix                           |

Containers below are prefix maps; which-key shows each with its group
name (`Find & Search`, `Buffer`, …).

## Windows / Buffers (cc-keybindings.el)

| Key   | Command            | Mode/Context | Description                                          |
|-------|--------------------|--------------|------------------------------------------------------|
| `C-h` | `evil-window-left` | Global       | Focus window left (see notes on help + Backspace)    |
| `C-j` | `evil-window-down` | Global       | Focus window below                                   |
| `C-k` | `evil-window-up`   | Global       | Focus window above                                   |
| `C-l` | `evil-window-right`| Global       | Focus window right                                   |
| `H`   | `previous-buffer` | evil-normal  | Previous buffer (displaces vim screen-top)           |
| `L`   | `next-buffer`     | evil-normal  | Next buffer (displaces vim screen-bottom)            |
| `K`   | `cc-show-doc-at-point` | evil-normal | Docs at point: lsp hover, elisp symbol, else error |
| `M-o` | `ace-window`      | Global       | Pick a window by number (shadows facemenu prefix)    |

Notes:

- `C-h` shadows the default help prefix; help remains on `<F1>`.
- Terminal limitation: without Kitty keyboard protocol, terminals send
  `C-h` and `Backspace` as the same code, so in `emacs -nw` Backspace
  also focuses window-left. GUI and Kitty-protocol terminals keep both
  keys distinct.

## Find & Search (cc-keybindings.el, `SPC f`)

| Key       | Command               | Mode/Context    | Description                               |
|-----------|-----------------------|-----------------|-------------------------------------------|
| `SPC f f` | `project-find-file`   | Global (leader) | Fuzzy-find file in project            |
| `SPC f r` | `recentf-open-files`  | Global (leader) | Recent files                              |
| `SPC f p` | `find-file`           | Global (leader) | Find file by path                         |
| `SPC f s` | `project-search`      | Global (leader) | Grep project (ripgrep when installed)     |
| `SPC f l` | `occur`               | Global (leader) | Show buffer lines matching regexp         |

## Buffer (cc-keybindings.el, `SPC b`)

| Key       | Command              | Mode/Context    | Description                               |
|-----------|----------------------|-----------------|-------------------------------------------|
| `SPC b s` | `switch-to-buffer`   | Global (leader) | Switch buffer                             |
| `SPC b k` | `kill-current-buffer`| Global (leader) | Kill current buffer (no confirm)          |
| `SPC b r` | `revert-buffer`      | Global (leader) | Revert buffer from disk                   |
| `SPC b l` | `ibuffer`            | Global (leader) | List buffers                              |

## Git (cc-keybindings.el, `SPC g`)

| Key       | Command       | Mode/Context    | Description                               |
|-----------|---------------|-----------------|-------------------------------------------|
| `SPC g d` | `vc-diff`     | Global (leader) | Diff working tree                         |
| `SPC g b` | `vc-annotate` | Global (leader) | Blame annotations                         |

Notes:

- `SPC g s` is reserved for `magit-status` once magit is installed.

## Code / LSP (cc-lsp.el, `SPC c`)

| Key       | Command                        | Mode/Context      | Description                                  |
|-----------|--------------------------------|-------------------|----------------------------------------------|
| `SPC c a` | `lsp-execute-code-action`      | Global (leader)   | Code actions at point (lsp buffers)          |
| `SPC c r` | `lsp-rename`                   | Global (leader)   | Rename symbol (lsp buffers)                  |
| `SPC c d` | `lsp-find-definition`          | Global (leader)   | Go to definition (lsp buffers)               |
| `SPC c D` | `flymake-show-buffer-diagnostics` | Global (leader) | Buffer diagnostics                         |
| `SPC c l` | `lsp-command-map`              | Global (leader)   | Full LSP prefix; which-key shows subcommands |
| `C-c l`   | `lsp-command-map`              | lsp-mode buffers  | Upstream LSP prefix (set as `lsp-keymap-prefix` before load) |

## Org (cc-org.el, `SPC o`)

| Key       | Command                  | Mode/Context    | Description                                  |
|-----------|--------------------------|-----------------|----------------------------------------------|
| `SPC o a` | `org-agenda`             | Global (leader) | Open weekly agenda                           |
| `SPC o c` | `org-capture`            | Global (leader) | Capture a new note/task                      |
| `SPC o f` | `org-roam-node-find`     | Global (leader) | Find or create a roam node                   |
| `SPC o i` | `org-roam-node-insert`   | Global (leader) | Insert a link to a roam node                 |
| `SPC o l` | `org-roam-buffer-toggle` | Global (leader) | Toggle roam backlinks buffer                 |
| `, J`     | `org-next-visible-heading` | org, evil-normal, evil-visual | Next visible heading               |
| `, K`     | `org-previous-visible-heading` | org, evil-normal, evil-visual | Previous visible heading       |

Notes:

- Org TODOs live in the agenda (`SPC o a`); links are inserted with
  `SPC o i` (roam) or `org-store-link` (`C-c l` in org buffers, shadowed
  by the LSP prefix only where `lsp-mode` is active).
- `C-j`/`C-k` switch windows in org buffers too: this overrides the
  outline heading motion (inherited via `evil-collection`) and org's own
  `C-j` newline (`org-return-and-maybe-indent`); plain `RET` still
  newlines as usual.

## Treemacs (cc-treemacs.el)

| Key     | Command    | Mode/Context    | Description                                          |
|---------|------------|-----------------|------------------------------------------------------|
| `SPC e` | `treemacs` | Global (leader) | Open/select the side tree (`M-SPC e` in Emacs state) |

Notes:

- Treemacs navigation and file operations (`cf`/`cd` create, `d`
  delete, `c` copy, `m` move, `R` rename, …) are treemacs built-ins
  with `treemacs-evil` vim keys; only the `SPC e` entry point is
  defined in `cc-treemacs.el`.

## Window (cc-keybindings.el, `SPC w`)

| Key       | Command               | Mode/Context    | Description                               |
|-----------|-----------------------|-----------------|-------------------------------------------|
| `SPC w h` | `cc-window-split-left` | Global (leader)| Split with new window on the left         |
| `SPC w j` | `cc-window-split-below`| Global (leader)| Split with new window below               |
| `SPC w k` | `cc-window-split-above`| Global (leader)| Split with new window above               |
| `SPC w l` | `cc-window-split-right`| Global (leader)| Split with new window on the right        |
| `SPC w d` | `delete-window`       | Global (leader) | Close this window                         |
| `SPC w o` | `delete-other-windows`| Global (leader) | Keep only this window                     |

All six are shown by which-key under the `Window` group.

## Project (cc-keybindings.el, `SPC p`)

| Key       | Command                 | Mode/Context    | Description                               |
|-----------|-------------------------|-----------------|-------------------------------------------|
| `SPC p p` | `project-switch-project`| Global (leader) | Switch project                            |
| `SPC p f` | `project-find-file`     | Global (leader) | Find file in project                      |
| `SPC p s` | `project-search`        | Global (leader) | Grep project                              |
| `SPC p d` | `project-dired`         | Global (leader) | Dired at project root                     |
| `SPC p k` | `project-kill-buffers`  | Global (leader) | Kill project buffers                      |

## Help (cc-keybindings.el, `SPC h`)

| Key       | Command             | Mode/Context    | Description                               |
|-----------|---------------------|-----------------|-------------------------------------------|
| `SPC h k` | `describe-key`      | Global (leader) | Describe a key                            |
| `SPC h f` | `describe-function` | Global (leader) | Describe a function                       |
| `SPC h v` | `describe-variable` | Global (leader) | Describe a variable                       |
| `SPC h m` | `describe-mode`     | Global (leader) | Describe current mode                     |
| `SPC h h` | `view-echo-area-messages` | Global (leader) | Show messages (default `C-h e`, displaced by window keys) |

## Local leader (cc-keybindings.el, `,`)

| Key       | Command                       | Mode/Context               | Description                         |
|-----------|-------------------------------|----------------------------|-------------------------------------|
| `, e b`   | `eval-buffer`                 | evil-normal, evil-visual   | Evaluate buffer                     |
| `, e r`   | `eval-region`                 | evil-normal, evil-visual   | Evaluate region                     |
| `, e f`   | `eval-defun`                  | evil-normal, evil-visual   | Evaluate top-level form             |
| `, e l`   | `eval-last-sexp`              | evil-normal, evil-visual   | Evaluate expression before point    |
| `, c c`   | `compile`                     | evil-normal, evil-visual   | Run build command                   |
| `, c r`   | `recompile`                   | evil-normal, evil-visual   | Re-run last build                   |
| `, d e`   | `toggle-debug-on-error`       | evil-normal, evil-visual   | Toggle debugger on error            |
| `, d v`   | `toggle-debug-on-variable`    | evil-normal, evil-visual   | Toggle debugger on variable change  |

Notes:

- `, m` (Mode) and `, t` (Test) are empty containers reserved for
  language modules (major-mode actions, test runners); which-key shows
  the group names.

## Completion (cc-completion.el)

| Key     | Command             | Mode/Context | Description                                          |
|---------|---------------------|--------------|------------------------------------------------------|
| `M-g g` | `consult-goto-line` | Global       | Go to line with preview (upgrades `goto-line`)       |
| `M-g i` | `consult-imenu`     | Global       | Jump to imenu symbol                                 |
| `M-s l` | `consult-line`      | Global       | Search buffer lines with preview                     |
| `M-y`   | `consult-yank-pop`  | Global       | Browse kill ring (upgrades `yank-pop`)               |
| `C-.`   | `embark-act`        | Global       | Act on thing at point / current candidate            |

Notes:

- Terminal limitation: plain terminals may not send `C-.`; there use
  `M-x embark-act`. GUI and Kitty-protocol terminals are unaffected.
- Minibuffer vim keys come from `evil-collection`; vertico, orderless,
  and marginalia add no bindings of their own.
- In-buffer completion is global via company (lsp-mode feeds it through
  `company-capf` in managed buffers); `C-n`/`C-p` navigate, `RET`
  confirms (company defaults, vim-tuned by `evil-collection`).

## Editing / Evil (cc-editing.el)
| Key       | Command        | Mode/Context                  | Description                        |
|-----------|----------------|-------------------------------|------------------------------------|
| `SPC`     | `cc-leader-map` | evil-normal, evil-visual, evil-motion | Vim-style leader prefix |
| `C-u`     | `evil-scroll-up` | evil-normal, evil-visual     | Scroll up (vim `C-u`, `evil-want-C-u-scroll`) |
| `C-o`     | `evil-jump-backward` | evil-normal, evil-motion | Jump back in jumplist (terminal-safe; `C-i`/`TAB` for jump-forward is GUI or Kitty-protocol only) |
| `C-M-r`   | `evil-record-macro` | evil-normal | Record a macro (vim's `q` is freed; play macros with `@` as usual) |

Notes:

- Terminal limitation: terminals send `C-i` and `TAB` as the same code
  without Kitty keyboard protocol, so `evil-jump-forward` (`C-i`) is only
  reachable in GUI or Kitty-protocol terminals. `C-o` always works.
- `evil-collection` remaps built-in modes (dired, help, occur, etc.) to
  vim keys automatically; consult `:describe-bindings` in each mode for
  the full generated set.

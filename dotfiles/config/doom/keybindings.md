# Keybindings

Single source of truth for every custom binding. Source: `lisp/cc/cc-keymaps.el`
(Doom `map!` syntax; `:leader` = `SPC`, `:localleader` = `,`).

Leader: `SPC` (`M-SPC` in insert/emacs states). Localleader: `,` (`M-,` in
insert/emacs states). Both are plain ASCII, so they work identically in
`emacs -nw`, over SSH, and in GUI frames.

Setup notes (this config runs `:tools lsp` = lsp-mode, `:completion
(company +childframe)` = company-box):
`SPC c` uses lsp-mode commands, `, d v` runs `debug-on-variable-change`
(`toggle-debug-on-variable` does not exist), and `SPC d` is dap-mode
(which is unrelated to Doom's `:tools debugger` dape client).
Module/package changes need `doom sync` + restart.

## Windows / Buffers

| Key   | Command              | Mode/Context | Description                                       |
|-------|----------------------|--------------|---------------------------------------------------|
| `C-h` | `evil-window-left`   | evil-normal  | Focus window left (see notes on help + Backspace) |
| `C-j` | `evil-window-down`   | evil-normal  | Focus window below (also in org buffers)          |
| `C-k` | `evil-window-up`     | evil-normal  | Focus window above (also in org buffers)          |
| `C-l` | `evil-window-right`  | evil-normal  | Focus window right                                |
| `H`   | `previous-buffer`    | evil-normal  | Previous buffer (displaces vim screen-top)        |
| `L`   | `next-buffer`        | evil-normal  | Next buffer (displaces vim screen-bottom)         |
| `K`   | `cc-show-doc-at-point` | evil-normal | Docs at point, press twice to enter + scroll (never a web search) |
| `M-o` | `ace-window`         | Global       | Pick a window by number (shadows facemenu prefix) |

Notes:

- `C-h` shadows the default help prefix; help remains on `<F1>`.
- `K` never opens a web search: Doom's default `+lookup/documentation`
  falls back to an online search when no LSP is active (that was the
  "search on ..." window). `cc-show-doc-at-point` bypasses it -- on GUI
  it calls `lsp-ui-doc-glance` (hover in a popup frame, same family as
  the company-box frames; auto-hides on the next key), in terminal it
  uses `lsp-describe-thing-at-point` (childframes don't exist in
  `emacs -nw`), in elisp `describe-symbol`, and otherwise errors telling
  you to run `M-x lsp`.
- Press `K` twice in a row to scroll: on GUI the second `K` focuses the
  doc popup frame (`q` leaves it, normal keys scroll); in terminal it
  selects the `*lsp-help*` window (`q` buries it). Same for elisp
  (`*Help*`). Any other key between the two presses starts over.
- Terminal limitation: without Kitty keyboard protocol, terminals send
  `C-h` and `Backspace` as the same code, so in `emacs -nw` Backspace
  also focuses window-left. GUI and Kitty-protocol terminals keep both
  keys distinct.

## Find & Search (`SPC f`)

| Key       | Command              | Mode/Context    | Description                           |
|-----------|----------------------|-----------------|---------------------------------------|
| `SPC f f` | `project-find-file`  | Global (leader) | Fuzzy-find file in project            |
| `SPC f r` | `recentf-open-files` | Global (leader) | Recent files                          |
| `SPC f p` | `find-file`          | Global (leader) | Find file by path                     |
| `SPC f s` | `project-search`     | Global (leader) | Grep project (ripgrep when installed) |
| `SPC f l` | `occur`              | Global (leader) | Show buffer lines matching regexp     |

## Buffer (`SPC b`)

| Key       | Command               | Mode/Context    | Description                      |
|-----------|-----------------------|-----------------|----------------------------------|
| `SPC b s` | `switch-to-buffer`    | Global (leader) | Switch buffer                    |
| `SPC b k` | `kill-current-buffer` | Global (leader) | Kill current buffer (no confirm) |
| `SPC b r` | `revert-buffer`       | Global (leader) | Revert buffer from disk          |
| `SPC b l` | `ibuffer`             | Global (leader) | List buffers                     |

## Git (`SPC g`)

| Key       | Command       | Mode/Context    | Description           |
|-----------|---------------|-----------------|-----------------------|
| `SPC g d` | `vc-diff`     | Global (leader) | Diff working tree     |
| `SPC g b` | `vc-annotate` | Global (leader) | Blame annotations     |

Notes:

- `SPC g s` is reserved for `magit-status` (left unbound on purpose).

## Code / LSP (`SPC c`, lsp-mode -- source: `cc-lsp.el`)

| Key       | Command                  | Mode/Context    | Description                                     |
|-----------|--------------------------|-----------------|-------------------------------------------------|
| `SPC c a` | `lsp-execute-code-action`| Global (leader) | Code actions at point (lsp buffers)             |
| `SPC c r` | `lsp-rename`             | Global (leader) | Rename symbol (lsp buffers)                     |
| `SPC c d` | `lsp-find-definition`    | Global (leader) | Go to definition (displaces Doom default; still on `gd`) |
| `SPC c D` | `flycheck-list-errors`   | Global (leader) | Buffer diagnostics (displaces `+lookup/references`; still on `gD`) |
| `SPC c l` | `+default/lsp-command-map` | Global (leader) | Full LSP prefix; which-key shows subcommands  |
| `C-c l`   | `lsp-command-map`        | lsp-mode buffers| Upstream LSP prefix (set as `lsp-keymap-prefix` before load) |

Notes:

- `SPC c D` uses flycheck (our `:checkers syntax' backend), not flymake:
  the flymake diagnostics buffer would always be empty here.
- LSP starts automatically when opening files: `cc-lsp.el` hooks
  `lsp-deferred` on `prog-mode-hook` (every programming buffer), with
  `lsp-warn-no-matched-clients` silenced for unsupported modes. A
  missing server offers installation via `M-x lsp-install-server`.
- Company is wired to LSP via `lsp-completion-mode` (Doom only does this
  for corfu): lsp candidates flow through `company-capf` into the
  company-box childframe.

## Debug / DAP (`SPC d` -- source: `cc-lsp.el`)

| Key       | Command                   | Mode/Context    | Description                         |
|-----------|---------------------------|-----------------|-------------------------------------|
| `SPC d d` | `dap-debug`               | Global (leader) | Start debugging (pick template)     |
| `SPC d l` | `dap-debug-last`          | Global (leader) | Repeat last session                 |
| `SPC d r` | `dap-debug-recent`        | Global (leader) | Recent sessions                     |
| `SPC d b` | `dap-breakpoint-toggle`   | Global (leader) | Toggle breakpoint                   |
| `SPC d B` | `dap-breakpoint-condition`| Global (leader) | Conditional breakpoint              |
| `SPC d c` | `dap-continue`            | Global (leader) | Continue                            |
| `SPC d n` | `dap-next`                | Global (leader) | Next step                           |
| `SPC d i` | `dap-step-in`             | Global (leader) | Step in                             |
| `SPC d o` | `dap-step-out`            | Global (leader) | Step out                            |
| `SPC d R` | `dap-restart-frame`       | Global (leader) | Restart frame                       |
| `SPC d e` | `dap-eval-thing-at-point` | Global (leader) | Eval thing at point                 |
| `SPC d s` | `dap-ui-sessions`         | Global (leader) | Sessions buffer                     |
| `SPC d q` | `dap-disconnect`          | Global (leader) | Disconnect session                  |

Notes:

- Prerequisites: `(package! dap-mode)` + `doom sync`. Commands are lazy:
  the first one loads dap-mode and enables `dap-ui-mode` (sessions /
  locals / breakpoints show automatically). Tooltips stay off (mouse
  noise in terminal).
- `, d` (localleader) is unrelated: Elisp debugger toggles.
- Python: `pip install debugpy` in the venv; template + interpreter are
  registered by `cc-python.el`.

## Org (`SPC o` + `,`)

| Key       | Command                      | Mode/Context              | Description                            |
|-----------|------------------------------|---------------------------|----------------------------------------|
| `SPC o a` | `org-agenda`                 | Global (leader)           | Open weekly agenda                     |
| `SPC o c` | `org-capture`                | Global (leader)           | Capture a new note/task                |
| `SPC o h` | `cc/org-id-get-create-all`   | Global (leader)           | Ensure Org IDs for all headings (extra)|
| `SPC o r` | `org-refile`                 | Global (leader)           | Refile heading (extra)                 |
| `SPC o A` | `org-archive-subtree`        | Global (leader)           | Archive heading (extra)                |
| `SPC o t` | `org-set-tags-command`       | Global (leader)           | Set tags (extra)                       |
| `SPC o f` | `org-roam-node-find`         | Global (leader)           | Find or create a roam node (needs org-roam) |
| `SPC o i` | `org-roam-node-insert`       | Global (leader)           | Insert a link to a roam node (needs org-roam) |
| `SPC o l` | `org-roam-buffer-toggle`     | Global (leader)           | Toggle roam backlinks buffer (needs org-roam) |
| `, J`     | `org-next-visible-heading`   | org, evil-normal, evil-visual | Next visible heading               |
| `, K`     | `org-previous-visible-heading` | org, evil-normal, evil-visual | Previous visible heading         |

Notes:

- `SPC o f/i/l` appear only after `(package! org-roam)` + `doom sync`;
  while org-roam is absent those keys are unbound (nothing errors).
- Org TODOs live in the agenda (`SPC o a`); links are inserted with
  `SPC o i` (roam) or `org-store-link` (`C-c l` in org buffers, shadowed
  by the LSP prefix only where `lsp-mode` is active -- i.e. not in org).
- `C-j`/`C-k` switch windows in org buffers too: this overrides the
  outline heading motion (inherited via `evil-collection`) and org's own
  `C-j` newline (`org-return-and-maybe-indent`); plain `RET` still
  newlines as usual.
- Bare `J` stays `evil-join` and bare `K` stays `cc-show-doc-at-point`
  in org buffers (heading motion lives on `, J` / `, K` only).

## Treemacs (`SPC e`)

| Key     | Command            | Mode/Context    | Description                                              |
|---------|--------------------|-----------------|----------------------------------------------------------|
| `SPC e` | `+treemacs/toggle` | Global (leader) | Toggle tree at project root (`M-SPC e` in Emacs state)   |

Notes:

- The entry point is Doom's `+treemacs/toggle` (not plain `treemacs`):
  it shows only the current project, so the tree opens at the project
  directory of the current buffer. Without a project it reopens the
  last session with a message.

- Treemacs navigation and file operations (`a` create, `d`
  delete, `x` move, `p`/`c` copy, `r` rename, `.` root-up, …) are
  treemacs built-ins bound in `treemacs-mode-map`; only the `SPC e`
  entry point is a custom binding. `C-h/j/k/l` inside the tree focus
  windows, matching the bare global keys.

## Window (`SPC w`)

| Key       | Command                | Mode/Context    | Description                        |
|-----------|------------------------|-----------------|------------------------------------|
| `SPC w h` | `cc-window-split-left` | Global (leader) | Split with new window on the left  |
| `SPC w j` | `cc-window-split-below`| Global (leader) | Split with new window below        |
| `SPC w k` | `cc-window-split-above`| Global (leader) | Split with new window above        |
| `SPC w l` | `cc-window-split-right`| Global (leader) | Split with new window on the right |
| `SPC w d` | `delete-window`        | Global (leader) | Close this window                  |
| `SPC w o` | `delete-other-windows` | Global (leader) | Keep only this window              |

All six are shown by which-key under the `Window` group.

## Project (`SPC p`)

| Key       | Command                  | Mode/Context    | Description          |
|-----------|--------------------------|-----------------|----------------------|
| `SPC p p` | `project-switch-project` | Global (leader) | Switch project       |
| `SPC p f` | `project-find-file`      | Global (leader) | Find file in project |
| `SPC p s` | `project-search`         | Global (leader) | Grep project         |
| `SPC p d` | `project-dired`          | Global (leader) | Dired at project root|
| `SPC p k` | `project-kill-buffers`   | Global (leader) | Kill project buffers |

## Help (`SPC h`)

| Key       | Command                 | Mode/Context    | Description                                    |
|-----------|-------------------------|-----------------|------------------------------------------------|
| `SPC h k` | `describe-key`          | Global (leader) | Describe a key                                 |
| `SPC h f` | `describe-function`     | Global (leader) | Describe a function                            |
| `SPC h v` | `describe-variable`     | Global (leader) | Describe a variable                            |
| `SPC h m` | `describe-mode`         | Global (leader) | Describe current mode                          |
| `SPC h h` | `view-echo-area-messages` | Global (leader) | Show messages (default `C-h e`, displaced by window keys) |
| `SPC h r` | `doom/reload`           | Global (leader) | Reload IDE config (same as `SPC C v r`)        |

## Local leader (`,`)

| Key       | Command                    | Mode/Context             | Description                        |
|-----------|----------------------------|--------------------------|------------------------------------|
| `, e b`   | `eval-buffer`              | evil-normal, evil-visual | Evaluate buffer                    |
| `, e r`   | `eval-region`              | evil-normal, evil-visual | Evaluate region                    |
| `, e f`   | `eval-defun`               | evil-normal, evil-visual | Evaluate top-level form            |
| `, e l`   | `eval-last-sexp`           | evil-normal, evil-visual | Evaluate expression before point   |
| `, c c`   | `compile`                  | evil-normal, evil-visual | Run build command                  |
| `, c r`   | `recompile`                | evil-normal, evil-visual | Re-run last build                  |
| `, d e`   | `toggle-debug-on-error`    | evil-normal, evil-visual | Toggle debugger on error           |
| `, d v`   | `debug-on-variable-change` | evil-normal, evil-visual | Watch variable (debugger; `toggle-debug-on-variable` does not exist) |
| `, m`     | (none)                     | evil-normal, evil-visual | Mode group, reserved for language modules |
| `, t`     | (none)                     | evil-normal, evil-visual | Test group, reserved for test runners |

Notes:

- Doom binds the localleader in normal/visual/motion/emacs/insert
  (insert/emacs use `M-,`); the table lists the spec contexts.
- Conflict: in org buffers Doom already owns `, e`
  (`org-export-dispatch`), which shadows the `, e ...` eval prefix
  there -- use `M-x eval-buffer` in org buffers.
- `, m` (Mode) and `, t` (Test) are empty containers reserved for
  language modules (major-mode actions, test runners); which-key shows
  the group names. `, m` is claimed in python buffers (see Python below).

## Python (`cc-python.el`, `, m` in python buffers)

| Key     | Command             | Mode/Context                          | Description                              |
|---------|---------------------|---------------------------------------|------------------------------------------|
| `, m v` | `pyvenv-workon`     | python, evil-normal, evil-visual      | Select virtualenv (from known envs)      |
| `, m a` | `pyvenv-activate`   | python, evil-normal, evil-visual      | Activate virtualenv by directory         |
| `, m d` | `pyvenv-deactivate` | python, evil-normal, evil-visual      | Deactivate virtualenv                    |
| `, m r` | `lsp-workspace-restart` | python, evil-normal, evil-visual      | Restart LSP so it picks up the new env   |

Notes:

- Prerequisites: `(package! pyvenv)` + `doom sync`, and a python language
  server (pylsp, pyright or ruff-lsp) on PATH (`M-x lsp-install-server`
  can fetch one). lsp-mode starts automatically in `python-mode`
  (Doom's `:lang python` is disabled; `cc-python.el` hooks
  `lsp-deferred` itself).
- Opening a python file auto-activates `.venv`/`venv` from the project
  root when present. Select the venv BEFORE the server starts, or run
  `, m r` after -- lsp-mode captures PATH at startup.
- The active venv shows in the modeline via `pyvenv-mode`.
- DAP: `pip install debugpy` in the venv, then debug from `SPC d`.

## Completion

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
- `C-;` (Doom's default `embark-act` key) keeps working alongside `C-.`.
- Minibuffer vim keys come from `evil-collection`; vertico, orderless,
  and marginalia add no bindings of their own.
- In-buffer completion is global via company + company-box childframes
  (lsp-mode feeds it through `company-capf` in managed buffers);
  `C-n` / `C-p` navigate, `RET` confirms, `TAB` completes the common
  part (Doom bindings on top of company defaults, vim-tuned by
  `evil-collection`). Docs for the selected candidate show in the
  company-box doc frame.

## Editing / Evil

| Key       | Command              | Mode/Context                          | Description                        |
|-----------|----------------------|---------------------------------------|------------------------------------|
| `SPC`     | `doom-leader-map`    | evil-normal, evil-visual, evil-motion | Vim-style leader prefix (Doom fulfils the vanilla `cc-leader-map` role; `M-SPC` in insert/emacs) |
| `C-u`     | `evil-scroll-up`     | evil-normal, evil-visual              | Scroll up (vim `C-u`)              |
| `C-o`     | `evil-jump-backward` | evil-normal, evil-motion              | Jump back in jumplist (terminal-safe; `C-i`/`TAB` for jump-forward is GUI or Kitty-protocol only) |
| `C-M-r`   | `evil-record-macro`  | evil-normal                           | Record a macro (vim's `q` is freed; play macros with `@` as usual) |

Notes:

- Terminal limitation: terminals send `C-i` and `TAB` as the same code
  without Kitty keyboard protocol, so `evil-jump-forward` (`C-i`) is only
  reachable in GUI or Kitty-protocol terminals. `C-o` always works.
- `evil-collection` remaps built-in modes (dired, help, occur, etc.) to
  vim keys automatically; consult `:describe-bindings` in each mode for
  the full per-mode map.

## Extras (kept, no spec conflicts)

| Key         | Command                    | Mode/Context      | Description                          |
|-------------|----------------------------|-------------------|--------------------------------------|
| `C-s`       | save-buffer                | Global            | Save (with confirmation message)     |
| `SPC C v u` | `doom/doom-upgrade`        | Global (leader)   | Update packages                      |
| `SPC C v r` | `doom/reload`              | Global (leader)   | Reload config                        |
| `SPC q q`   | kill-emacs                 | Global (leader)   | Quit (no save)                       |
| `SPC q a`   | kill-emacs                 | Global (leader)   | Quit all (no save)                   |
| `SPC q b`   | `evil-quit`                | Global (leader)   | Quit buffer/window                   |
| `SPC q o`   | `delete-other-windows`     | Global (leader)   | Keep only this window                |
| `SPC -`     | `split-window-below`       | Global (leader)   | Quick up/down split (no menu)        |
| `SPC \|`    | `split-window-right`       | Global (leader)   | Quick left/right split (no menu)     |
| `C-q`       | `evil-quit`                | evil-normal       | Quit buffer/window                   |
| `M-q`       | kill-emacs                 | evil-normal       | Quit Emacs                           |
| `f`         | `evil-avy-goto-char-timer` | evil-normal, evil-visual, evil-operator | Avy jump (displaces vim find-char) |
| `F`         | `er/expand-region`         | evil-normal       | Expand region outward                |
| `<tab>`     | `+workspace/switch-right`  | evil-normal       | Next workspace                       |
| `<backtab>` | `+workspace/switch-left`   | evil-normal       | Previous workspace                   |
| `SPC t t`   | `ghostel`                  | Global (leader)   | Ghostel terminal                     |
| `SPC t h/j/k/l` | ghostel splits         | Global (leader)   | Ghostel in a directional split       |
| `jk`        | `evil-normal-state`        | insert (escape + ghostel) | Better escape                |
| `M-h`       | `evil-shift-left-line`     | evil-normal       | Dedent line                          |
| `M-l`       | `evil-shift-right-line`    | evil-normal       | Indent line                          |
| `M-j`       | `drag-stuff-down`          | evil-normal, evil-visual | Move line/selection down      |
| `M-k`       | `drag-stuff-up`            | evil-normal, evil-visual | Move line/selection up        |
| `d` / `D`   | `cc/delete-blackhole`      | evil-normal, evil-visual | Delete without touching registers |

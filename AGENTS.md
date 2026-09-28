AGENTS.md
=========

Overview
--------

This repository contains a modular Nix configuration managed with flakes.

The configuration must support multiple targets and operating systems while keeping shared functionality reusable and isolated into modules.

Primary targets:

*   cachyos — CachyOS host using Nix tooling

*   nix-wsl — Nix/WSL environment running on Windows

*   nixos — NixOS host


The repository uses:

*   flake.nix as the primary entry point

*   target-specific configuration files such as base.nix, home.nix, and work.nix

*   reusable modules under components/

*   flake.lock for pinned inputs


Prefer small, composable modules over large target-specific configuration files.

Repository Structure
--------------------

A typical layout should look like:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   .  ├── flake.nix  ├── flake.lock  ├── AGENTS.md  │  ├── base.nix  ├── home.nix  ├── work.nix  │  └── components/      ├── dotfiles.nix      │      └── shells/          ├── bash.nix          ├── nushell.nix          └── zsh.nix   `

The exact structure may grow as the configuration grows.

### flake.nix

flake.nix is the source of truth for the available targets and their outputs.

Do not infer a target's flake output name solely from a filename.

Before modifying or validating a target, inspect flake.nix and determine the exact output being affected.

### Target configuration files

Files such as:

*   base.nix

*   home.nix

*   work.nix


should compose reusable modules rather than contain large amounts of implementation-specific configuration.

Use these files to describe _which components a target needs_.

### components/

Reusable functionality belongs under components/.

Examples:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   components/  ├── dotfiles.nix  └── shells/      ├── bash.nix      ├── nushell.nix      └── zsh.nix   `

Components should generally have one clear responsibility.

For example:

*   components/dotfiles.nix — dotfile management

*   components/shells/bash.nix — Bash configuration

*   components/shells/nushell.nix — Nushell configuration

*   components/shells/zsh.nix — Zsh configuration


Prefer composing several focused components over creating a single large module.

Working Rules
=============

1\. Verify the Target First
---------------------------

Before making any changes, identify:

1.  The exact target configuration being changed.

2.  The exact flake output corresponding to that target.

3.  The machine/OS on which the configuration must be validated.

4.  The appropriate validation command.


Do **not** assume that:

*   a filename is the same as its flake output name;

*   a hostname is the same as a configuration name;

*   a configuration can be validated from the current machine;

*   a NixOS configuration can be safely validated using a non-NixOS host;

*   nix run, nixos-rebuild, home-manager, nix-darwin, or system-manager are interchangeable.


Before editing, explicitly state:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`Target config:   Validation host:   Planned verification:`

Example:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   Target config: nixos  Validation host: my-nixos-machine / NixOS  Planned verification: nix eval .#nixosConfigurations.my-nixos-machine.config.system.build.toplevel   `

If the correct validation host is unavailable, do not pretend that the target was fully validated.

2\. Inspect Before Editing
--------------------------

Before changing Nix code:

1.  Inspect flake.nix.

2.  Inspect flake.lock when inputs may be relevant.

3.  Locate the target configuration.

4.  Determine the module/component dependency structure.

5.  Inspect existing conventions before introducing new ones.


Use the existing repository structure and conventions whenever possible.

Do not reorganize unrelated configuration as part of a focused fix.

3\. Keep Configuration Modular
------------------------------

Prefer reusable components under components/.

For example:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   {    imports = [      ./components/dotfiles.nix      ./components/shells/bash.nix      ./components/shells/zsh.nix    ];  }   `

A component should expose configuration that can be independently enabled, imported, or reused where practical.

Avoid:

*   duplicating the same configuration across targets;

*   putting unrelated services in one module;

*   creating target-specific copies of shared components;

*   unnecessarily coupling shell, editor, desktop, networking, and system configuration.


If two targets need the same functionality, prefer a shared component.

If only one target needs functionality, keep it target-specific unless there is a clear reason to generalize it.

4\. Separate Shared Configuration From Target-Specific Configuration
--------------------------------------------------------------------

Use shared modules for common behavior and target files for composition.

For example:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   base.nix      ├── dotfiles      ├── common packages      └── common shell configuration  home.nix      ├── base      └── home-specific components  work.nix      ├── base      ├── work-specific packages      └── work-specific components   `

Avoid encoding machine-specific assumptions in shared components.

When behavior differs between targets, prefer explicit options or conditional composition over duplicated modules.

Flakes and Dependencies
=======================

5\. Prefer Upstream Fixes
-------------------------

When an issue appears to originate upstream, investigate the upstream status before writing a local workaround.

The order of preference is:

1.  Existing fix in the currently available configuration.

2.  Update the relevant flake input to a version containing the fix.

3.  Use an upstream PR commit or already-merged upstream commit if appropriate.

4.  If the repository has its own nixpkgs fork, ask whether the change should be made there and consumed by commit hash.

5.  Only then create a local patch.


For repositories using flakes, update the relevant flake input or flake.lock before introducing a local patch.

Do not immediately patch around an issue that is already fixed upstream.

When updating inputs:

*   make the smallest appropriate input update;

*   inspect the resulting lockfile changes;

*   verify that unrelated inputs were not unnecessarily changed;

*   validate the affected target afterward.


6\. Local Patches
-----------------

Only create a local patch when upstream options are insufficient.

Local patches must be:

*   minimal;

*   narrowly scoped;

*   isolated from unrelated changes;

*   documented when the reason is not obvious.


Use a separate file named:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   {package}-path-{fix-reason}.nix   `

For example:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   foo-path-missing-config-option.nix   `

Do not bury package-specific patches inside unrelated modules.

Prefer removing a local patch once the upstream fix becomes available.

Validation
==========

7\. Always Run nix eval
-----------------------

After **every Nix change**, run a matching nix eval against the **exact target output** before claiming success.

Evaluation is the minimum validation requirement.

Do not claim that a Nix change works if the matching target has not successfully evaluated, unless the appropriate validation host is genuinely unavailable; in that case, state the limitation explicitly.

### NixOS

For NixOS targets, evaluate the matching system configuration output.

For example:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   nix eval .#nixosConfigurations..config.system.build.toplevel   `

Use the actual output name from flake.nix.

Do not substitute a similarly named configuration.

### Other targets

Use the target's actual flake output and evaluate the relevant attribute.

Examples might include:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   nix eval .#homeConfigurations.   `

or:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   nix eval .#   `

The exact command must be derived from the repository's flake.nix, not guessed.

8\. Follow Evaluation With Stronger Validation When Practical
-------------------------------------------------------------

nix eval is the minimum bar, not the complete test plan.

After a successful evaluation, run an appropriate dry-run, build, check, or test when practical.

For example:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   nix build .#   `

or, for a NixOS target:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   sudo nixos-rebuild dry-run --flake .#   `

Use the command appropriate for the target and environment.

Do not run commands that modify the running system merely to validate a change unless explicitly requested.

Prefer:

1.  nix eval

2.  dry-run/check

3.  build/test when useful

4.  activation/switch only when explicitly required


9\. Validate the Correct Machine
--------------------------------

Validation must account for the actual target operating system.

### CachyOS

CachyOS is not NixOS.

Do not use nixos-rebuild as though CachyOS were a NixOS host.

Validate the relevant Nix/Home Manager/etc. output using tooling supported by the CachyOS environment.

### Nix WSL

The WSL target runs inside a Windows environment.

Do not assume that a native Linux/NixOS validation procedure applies unchanged.

Validate WSL-specific configuration on the WSL target where system behavior depends on WSL.

### NixOS

NixOS configurations should be validated on an appropriate NixOS host.

For system-level changes, use the matching NixOS configuration output.

Change Procedure
================

For a normal configuration change, follow this sequence:

### 1\. Identify the target

Determine:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`Target config:   Validation host:   Planned verification:`

### 2\. Inspect

Read:

*   flake.nix

*   relevant target configuration

*   relevant components

*   flake.lock if dependencies may be involved


### 3\. Determine whether the problem is upstream

If the problem originates from a package or upstream module:

*   check whether the fix already exists upstream;

*   update the flake input if appropriate;

*   prefer an upstream commit over a local patch.


### 4\. Make the smallest modular change

Put reusable functionality under components/.

Keep target composition separate from component implementation.

### 5\. Evaluate

Run the exact target's matching:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   nix eval ...   `

### 6\. Test further

When practical, run:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   nix build ...   `

or an appropriate dry-run/check/test command.

### 7\. Report validation

When finishing, state what was actually run.

For example:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   Target config: nixos  Validation host: workstation / NixOS  Verification:  - nix eval .#nixosConfigurations.workstation.config.system.build.toplevel  - nixos-rebuild dry-run --flake .#workstation   `

If something could not be tested, say exactly what was not tested and why.

Dependency and Lockfile Discipline
==================================

When modifying dependencies:

*   prefer targeted input updates;

*   avoid unnecessary lockfile churn;

*   preserve unrelated pins;

*   inspect git diff -- flake.lock;

*   evaluate affected targets after updating inputs.


Do not blindly run a full flake update when only one input needs changing.

Prefer targeted updates where supported.

Shell Components
================

Shell configuration should remain independently composable.

Example structure:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   components/  └── shells/      ├── bash.nix      ├── nushell.nix      └── zsh.nix   `

Do not put all shell configuration into one large module unless there is a compelling reason.

Shared shell-independent configuration belongs elsewhere.

For example:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   components/  ├── dotfiles.nix  └── shells/      ├── bash.nix      ├── nushell.nix      └── zsh.nix   `

A target should import only the shells it actually needs.

Cross-Platform Configuration
============================

The configuration must account for differences between:

*   CachyOS

*   Nix WSL

*   NixOS


Do not assume that a Linux distribution and NixOS have identical system-module semantics.

In particular:

*   NixOS modules should not automatically be imported into CachyOS or WSL configurations unless the target supports them.

*   System-level configuration should be separated from portable user-level configuration.

*   Portable components should avoid unnecessary OS-specific assumptions.

*   OS-specific behavior should live in clearly identified modules or target-specific composition.


Prefer a structure such as:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   components/  ├── common/  ├── dotfiles.nix  ├── shells/  │   ├── bash.nix  │   ├── nushell.nix  │   └── zsh.nix  ├── cachyos/  ├── nix-wsl/  └── nixos/   `

when platform-specific functionality becomes substantial.

Do not create these directories prematurely; introduce them when the configuration actually needs platform-specific components.

Editing Guidelines
==================

*   Make focused changes.

*   Avoid unrelated formatting changes.

*   Preserve existing style.

*   Do not rename outputs without checking all consumers.

*   Do not rename target files merely to make them match flake output names.

*   Do not introduce abstractions without a reuse case.

*   Prefer explicit configuration over clever Nix expressions.

*   Keep modules understandable to someone unfamiliar with the repository.

*   Remove obsolete workarounds when their upstream fixes become available.


Completion Criteria
===================

A change is complete only when:

*   The exact target was identified before editing.

*   The validation host was identified.

*   The planned verification command was identified.

*   The relevant flake.nix output was verified rather than guessed.

*   The change is placed in the appropriate target or reusable component.

*   Upstream fixes were checked when the issue is upstream-related.

*   flake.lock was updated when an upstream dependency update is the appropriate fix.

*   A local patch was avoided unless necessary.

*   If a local patch was necessary, it follows the required naming convention.

*   nix eval was run against the exact affected target.

*   Additional dry-run/build/test validation was performed when practical.

*   Validation results are reported accurately.

*   Any untested target or limitation is explicitly stated.


Guiding Principle
=================

**Compose targets from small, reusable components; verify the exact target you changed; prefer upstream fixes; and never claim a Nix change works without evaluating the corresponding flake output.**

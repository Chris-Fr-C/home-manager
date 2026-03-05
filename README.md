# Setup
## Prerequisites
Run `install-nix.sh` then reopen your terminal.

```bash
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```
(or --no-daemon if you do not want it system wide)



## Execution
```bash

curl -fsSL https://raw.githubusercontent.com/Chris-Fr-C/home-manager/refs/heads/main/install-nix.sh | bash
```
to install home-manager

Note: You need to restart your shell at that step.

Then:
```bash
mv ~/.config/home-manager ~/.config/home-manager-backup
git clone https://github.com/Chris-Fr-C/home-manager.git ~/.config/home-manager
```


You can then 
```bash
cd ~/.config/home-manager && home-manager switch -f work.nix
```
Or you can select home for home setup.


## Optional dependencies
```bash
home-manager switch -f work-wsl.nix
```


After your first instal you can also just write `refresh`

# Setup
## Prerequisites
Run `install-nix.sh` then reopen your terminal.

```
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon

(or --no-daemon if you do not want it system wide)

```
curl 
https://raw.githubusercontent.com/Chris-Fr-C/home-manager/refs/heads/main/install-nix.sh
Run `home-manager switch`


## Execution
```

curl -fsSL https://raw.githubusercontent.com/Chris-Fr-C/home-manager/refs/heads/main/install-nix.sh | bash
```
to install homemanager

Note: You need to restart your shell at that step.

Then:
```
git clone https://github.com/Chris-Fr-C/home-manager.git ~/.config
```


You can then 
```bash
cd ~/.config/home-manager && home-manager switch
```


## Optional dependencies
```bash
home-manager switch -f work-wsl.nix
```

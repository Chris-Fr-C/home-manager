init:
	git submodule init

	# source: https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone
	nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	nix-channel --update

build:
	home-manager switch --extra-experimental-features "nix-command flakes" --flake .#christophe

axpo:
	home-manager switch --extra-experimental-features "nix-command flakes" --flake .#axpo-wsl

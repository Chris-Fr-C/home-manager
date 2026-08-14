.init:
	git submodule init

	# source: https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone
	nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	# To allow flake experimental feature but at the user level only.
	mkdir -p ~/.config/nix && echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

home:
	home-manager switch --extra-experimental-features "nix-command flakes" --flake .#home

axpo:
	home-manager switch --extra-experimental-features "nix-command flakes" --flake .#axpo-wsl

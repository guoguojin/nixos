check:
	nix flake check

switch: check
	sudo nixos-rebuild switch

update:
	nix flake update


#!/usr/bin/env bash

home_manager_first_generation() {
	nix-shell '<home-manager>' -A install
}

home_manager_update() {
	home-manager switch
}

stow_dotfiles() {
	rm "$HOME/.config/home-manager/home.nix"
	rm "$HOME/.profile"
	stow --target="$HOME" --dir="$HOME/Projects/bkps" --stow .dotfiles
}

home_manager_first_generation
stow_dotfiles
home_manager_update
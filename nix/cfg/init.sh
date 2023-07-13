#!/usr/bin/env bash

source "$HOME/.nix-profile/share/asdf-vm/asdf.sh"

path+=(
	"$HOME/.local/bin"
	"$HOME/.local/share/coursier/bin"
)

nix_update() {
	rm -rf "$HOME/.config/gtk-3.0/settings.ini.backup"
	rm -rf "$HOME/.config/gtk-4.0/settings.ini.backup"
	home-manager switch -b backup
}

nix_clear() {
	nix-collect-garbage
}

system_update() {
	sudo apt update
	sudo apt full-upgrade
}

system_clear() {
	sudo apt autoremove
	sudo apt autoclean
}
#! /run/current-system/sw/bin/bash
cd ~/.config/dotfiles
nixos-rebuild switch --flake .#SERRATA-NIX --use-remote-sudo # CHANGE FLAKE (.#[whatever]) TO YOUR HOSTNAME!


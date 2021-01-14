# My updated dotfiles

This repository contains most of my config files (dotfiles) for linux/macOS. It has been extensively rewritten on an archlinux based system, so might not work out of the box on other distribs/macOS.
These dotfiles are managed using the *git bare repository method*, see here for details: https://www.atlassian.com/git/tutorials/dotfiles.

The dotfiles are self-explanatory. The configs for the window managers require certain packages to be installed.

To get up and running on a fresh arch install:

```sudo pacman -S alacritty thunar network-manager-applet nitrogen picom xcape fish zsh vim neovim tmux firefox thunderbird rofi dmenu playerctl alsa-utils acpilight```

```yay -S powerkit optimus-manager libinput-gestures starship todotxt xlayoutdisplay```

Then one needs to install pyenv, and omf, and update the plugins in vim and neovim, make sure to configure optimus-manager and libinput-gestures by reading their wikis.

Then, some additionall software that I use

```pacman -S lxappearance lxrandr vlc timeshift qbittorrent etcher steam discord```

```yay -S stacer spotify signal slack zoom zotero lastpass-cli nordvpn-cli pycharm-professional```

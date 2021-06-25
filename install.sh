#!/bin/sh
#
# This script should be run via curl:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/nick-strohm/server-setup/main/install.sh)"
# or via wget:
#   sh -c "$(wget -qO- https://raw.githubusercontent.com/nick-strohm/server-setup/main/install.sh)"
# or via fetch:
#   sh -c "$(fetch -o - https://raw.githubusercontent.com/nick-strohm/server-setup/main/install.sh)"
#
# As an alernative, you can first download the install script and run it afterwards
#   wget https://raw.githubusercontent.com/nick-strohm/server-setup/main/install.sh
#   sh install.sh

# Halts the execution until the user presses a key
pause() {
    read -n 1 -s -r -p "Press any key to continue..."
}

fmt_error() {
  printf '%sError: %s%s\n' "$BOLD$RED" "$*" "$RESET" >&2
}

fmt_underline() {
  printf '\033[4m%s\033[24m\n' "$*"
}

fmt_code() {
  # shellcheck disable=SC2016 # backtic in single-quote
  printf '`\033[38;5;247m%s%s`\n' "$*" "$RESET"
}

setup_color() {
	# Only use colors if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		RESET=""
	fi
}

# Helper function to allow installation of a set of packages
# $1 is a list of packages
install() {
    echo "${BLUE}Installing packages \"$1\"${RESET}"
    #apt-get install -y $1
}

clone_repo() {
    REQUIREMENTS="git"
    install "$REQUIREMENTS"
    git clone https://github.com/nick-strohm/server-setup.git /tmp/server-setup
}

setup_zsh() {
    REQUIREMENTS="wget git zsh chroma"
    install "$REQUIREMENTS"
    #sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh --unattended)"
    #git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    #cp /tmp/server-setup/configurations/.zshrc ~/.zshrc
    #cp /tmp/server-setup/configurations/.p10k.zsh ~/.p10k.zsh
    #chsh -s /usr/bin/zsh
}

main() {
    setup_color

    clone_repo
    setup_zsh

    echo "${YELLOW}Done${RESET}"
    pause
}

main
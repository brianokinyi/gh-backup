#!/bin/bash

# Shell variables for output
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
# echo "${red}red text ${green}green text${reset}"

# Install gh
# echo "[*] Installing gh"
# $(brew install gh)
# echo "${green}[*] Installed gh${reset} \n"


DIR=/var/www # Enter directory here

cd "$DIR"

for A in */; do
    [ -d "$A" ] || continue # Skip if not a directory
    A=${A%/} # Remove trailing slash
    echo "[*] Switched to $(pwd)"
    REPO=$(echo $A | tr " " "-")
    cd $A

    echo "[*] Creating repo $REPO"
    $(gh repo create $REPO --private)
    REMOTE="git@github.com:brianokinyi/${REPO}.git"
    $(git remote set-url origin $REMOTE)

    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    echo "[*] Pushing code to $REMOTE branch $BRANCH"
    $(git push -u origin ${BRANCH})
    echo "[*] Pushing code to $REMOTE"
    echo "${green}[*] Pushed code to REMOTE${reset}"
done

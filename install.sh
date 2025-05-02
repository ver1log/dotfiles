#!/bin/bash
## Set repo URL and Git dir/work tree
REPO_URL="https://github.com/ver1log/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"
ALIAS_NAME="config"
## 1. Clone bare repo to a safe place
git clone --bare "$REPO_URL" "$DOTFILES_DIR"
## 2. Define an alias for easy use
alias $ALIAS_NAME='/usr/bin/git --git-dir=$DOTFILES_DIR/ --work-tree=$HOME'
## 3. Backup any conflicting files
echo "Backing up pre-existing dot files..."
mkdir -p $HOME/.dotfiles-backup
$ALIAS_NAME checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | while read -r file; do
  mkdir -p "$(dirname "$HOME/.dotfiles-backup/$file")"
    mv "$HOME/$file" "$HOME/.dotfiles-backup/$file"
    done
#
## 4. Checkout the actual content
$ALIAS_NAME checkout
#
## 5. Configure Git to not show untracked files
$ALIAS_NAME config status.showUntrackedFiles no
#
echo "Dotfiles installed. Backup of overwritten files is in ~/.dotfiles-backup"
#

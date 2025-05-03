#!/bin/bash
## Set repo URL and Git dir/work tree
REPO_URL="https://github.com/ver1log/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"
#
## 1. Clone bare repo to a safe place
git clone --bare "$REPO_URL" "$DOTFILES_DIR"
#
## 2. Define the specific git command for easy use
GIT_CMD='/usr/bin/git --git-dir=$DOTFILES_DIR/ --work-tree=$HOME'
#
## 3. Backup any conflicting files
echo "Backing up pre-existing dot files..."
mkdir -p $HOME/.dotfiles-backup
$GIT_CMD checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' | while read -r file; do
  if [ -e "$HOME/$file" ]; then
    mkdir -p "$(dirname "$HOME/.dotfiles-backup/$file")"
    mv "$HOME/$file" "$HOME/.dotfiles-backup/$file"
  fi
done
#
## 4. Checkout the actual content
$GIT_CMD checkout
#
## 5. Configure Git to not show untracked files
$GIT_CMD config status.showUntrackedFiles no
#
echo "Dotfiles installed. Backup of overwritten files is in ~/.dotfiles-backup"
#

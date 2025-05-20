#!/bin/bash

# Define paths with $HOME to ensure expansion
VAULT_PATH="$HOME/Dropbox/Obsidian_Repo/Starter_Vault"
QUARTZ_PATH="$HOME/Coding/Projects/Vault-Deployment"

# Copy index.md to Home.md
cp "$VAULT_PATH/index.md" "$VAULT_PATH/Home.md"

# Sync files using rsync
rsync -av --delete "$VAULT_PATH/" "$QUARTZ_PATH/content"

# Navigate to the Quartz repo and commit changes
cd "$QUARTZ_PATH" || exit
git add .
git commit -m "Daily sync"
git push origin main 

echo "Sync and Git push completed!"


# # Old WSL Paths
# # Define paths
# VAULT_PATH="/mnt/c/users/diego/Dropbox/Obsidian_Repo/Starter_Vault"
# QUARTZ_PATH="/mnt/c/users/diego/OneDrive/Documents/Coding/quartz"
#
# # Copy index.md to Home.md
# cp "$VAULT_PATH/index.md" "$VAULT_PATH/Home.md"
#
# # Sync files using rsync
# rsync -av --delete "$VAULT_PATH/" "$QUARTZ_PATH/content" > /home/diego/sync/manual_cron_rsync.log 2>&1
#
# # Navigate to the Quartz repo and commit changes
# cd "$QUARTZ_PATH" || exit
# /usr/bin/git add .
# /usr/bin/git commit -m "Daily sync"
# /usr/bin/git push origin main > /home/diego/sync/cron_git.log 2>&1
#
# echo "Sync and Git push completed!"

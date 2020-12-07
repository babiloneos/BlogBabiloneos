#!/bin/sh

# If a command fails then the deploy stops
set -e

msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi

printf "\033[0;32mDeploying updates to General GitHub...\033[0m\n"

# Add changes
git add .

# Commit changes.
git commit -m "$msg"

# Push source and build repos.
git push origin main

printf "\033[0;32mDeploying updates to babiloneos.github.io...\033[0m\n"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public

# Add changes to git.
git add .

# Commit changes.

git commit -m "$msg"

# Push source and build repos.
git push origin main
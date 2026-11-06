#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
hugo -t pulp 

# Go To Public folder
cd public

# Make sure we're on the master branch (a submodule may sit on a detached HEAD,
# which would make the commit below invisible to `git push origin master`)
git checkout -f master 2>/dev/null || git checkout -f -B master origin/master

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master


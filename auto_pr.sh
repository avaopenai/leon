#!/bin/bash

# GitHub user and repo details
GITHUB_USER="avaopenai"
REPO_NAME="leon"
BASE_BRANCH="develop"
FEATURE_BRANCH=$(git branch --show-current)

# Ensure you're on a feature branch
if [ "$FEATURE_BRANCH" == "$BASE_BRANCH" ]; then
    echo "⚠️ You are on the '$BASE_BRANCH' branch. Switch to a feature branch first!"
    exit 1
fi

# Configure Git user info
git config --global user.email "daniel@tradeservicez.com"
git config --global user.name "Daniel Brown"

# Add, commit, and push changes
git add .
git commit -m "feat: Auto PR creation for $FEATURE_BRANCH"
git push origin "$FEATURE_BRANCH"

# Authenticate GitHub CLI (Run manually if not logged in)
gh auth login --with-browser

# Create, approve, and merge pull request
gh pr create --base "$BASE_BRANCH" --head "$FEATURE_BRANCH" --title "Auto PR: $FEATURE_BRANCH" --body "This is an automated pull request."
gh pr review --approve
gh pr merge --squash --delete-branch

echo "✅ Pull request created and merged!"

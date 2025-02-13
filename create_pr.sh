#!/bin/bash

# GitHub User Info
GITHUB_USER="avaopenai"
GITHUB_EMAIL="daniel@tradeservicez.com"
REPO_NAME="leon"
BASE_BRANCH="develop"
FEATURE_BRANCH=$(git branch --show-current)

# Ensure Git author identity is set
echo "⚙️ Configuring Git user identity..."
git config --global user.name "$GITHUB_USER"
git config --global user.email "$GITHUB_EMAIL"

# Ensure the user is on a feature branch
if [ "$FEATURE_BRANCH" == "$BASE_BRANCH" ]; then
    echo "⚠️ You are on the '$BASE_BRANCH' branch. Switch to a feature branch first!"
    exit 1
fi

# Add, commit, and push changes
echo "📤 Pushing changes to GitHub..."
git add .
git commit -m "Update: Auto PR creation for $FEATURE_BRANCH"
git push origin "$FEATURE_BRANCH"

# Generate the Pull Request URL
PR_URL="https://github.com/$GITHUB_USER/$REPO_NAME/compare/$BASE_BRANCH...$GITHUB_USER:$FEATURE_BRANCH"

# Open the PR page automatically
echo "🔗 Opening Pull Request page: $PR_URL"
xdg-open "$PR_URL" 2>/dev/null || open "$PR_URL" 2>/dev/null || echo "Open this link in your browser: $PR_URL"

echo "✅ Done! Complete the PR in your browser."

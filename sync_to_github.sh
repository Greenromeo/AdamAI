#!/bin/bash

# Navigate to the project directory
cd ~/Projects/AdamAI

# Stage all changes
git add .

# Commit with a message
commit_msg='Daily update'
git commit -m "$commit_msg"

# Push to GitHub
git push origin master

echo 'Project synced with GitHub successfully!'

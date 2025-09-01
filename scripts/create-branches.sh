#!/usr/bin/env bash
set -euo pipefail

if [ ! -d .git ]; then
  git init
  git add .
  git commit -m "Init: Actions hand-in"
fi

git branch -M main

# dev from main if missing
git rev-parse --verify dev >/dev/null 2>&1 || git branch dev main

# f1..f9 from dev if missing
for i in {1..9}; do
  br="f${i}"
  git rev-parse --verify "$br" >/dev/null 2>&1 || git branch "$br" dev
done

# prod/uat from main if missing
git rev-parse --verify prod >/dev/null 2>&1 || git branch prod main
git rev-parse --verify uat  >/dev/null 2>&1 || git branch uat  main

echo "Pushing to origin (ignore if already exists)..."
git push -u origin main || true
git push -u origin dev  || true
for i in {1..9}; do git push -u origin "f${i}" || true; done
git push -u origin prod || true
git push -u origin uat  || true

echo "Done. Now push a commit to f1 (or any fX) to trigger cascade."

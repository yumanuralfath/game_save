#!/bin/bash
GAME=$1
SOURCE=$2
USER=yumanuralfath
REPO_NAME=game_save
REPO_DIR=~/$REPO_NAME
TARGET=$REPO_DIR/$GAME

# 1. Clone repo kalau belum ada
if [ ! -d "$REPO_DIR/.git" ]; then
  if gh repo view $USER/$REPO_NAME &>/dev/null; then
    gh repo clone $USER/$REPO_NAME "$REPO_DIR"
  else
    gh repo create $USER/$REPO_NAME --public --confirm
    gh repo clone $USER/$REPO_NAME "$REPO_DIR"
  fi
fi

# 2. Sync isi save
mkdir -p "$TARGET"
rsync -av --delete "$SOURCE/" "$TARGET/"

# 3. Pastikan tidak ada .git di dalam folder game
if [ -d "$TARGET/.git" ]; then
  rm -rf "$TARGET/.git"
fi

# 4. Commit & push
cd "$REPO_DIR" || exit 1
git rm -r --cached "$GAME" 2>/dev/null
git add "$GAME"

if ! git diff --cached --quiet; then
  git commit -m "Update save for $GAME"
  git push -u origin main
else
  echo "Tidak ada perubahan pada $GAME"
fi

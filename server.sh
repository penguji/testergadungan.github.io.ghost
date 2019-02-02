#!/usr/bin/env bash

HOME_PATH=$HOME
GHOST_PATH="./current"
GHOST_SERVER_URL="https://testergadungan.github.io"
EXPORT_DIR="gh-pages"

function color_echo {
  echo -e "========== \033[33m$1\033[0m =========="
}

deploy() {
	if [ -d "$GHOST_PATH" ]; then
		# cd "$GHOST_PATH"
    # color_echo "remove old build"
    # rm -rf $EXPORT_DIR
		
    color_echo "[INFO] Generating static files"
		# buster generate --domain="$GHOST_SERVER_URL"
    $(npm bin)/gssg --url "$GHOST_SERVER_URL" --dest $EXPORT_DIR
    
    color_echo "[INFO] Commit files"
    cd $EXPORT_DIR
    git add -A
		git commit -m "Update on the website at $(date)"

    color_echo "[INFO] Push to server"
    git push -u origin gh-pages -f
  fi
}

if [ ! -d "./node_modules" ]; then
  color_echo "[WARN] node module not found, let's install it"
  yarn
fi

if [ $1 = "start" ]; then
  color_echo "[INFO] starting all"
  $(npm bin)/ghost start
elif [ $1 = "deploy" ]; then
  color_echo "[INFO] Deploying to github"
  if nc -z localhost 2368 2>/dev/null; then
    color_echo "Server ✓"
  else
    color_echo "Server ✗"
    color_echo "[INFO] starting all"
    $(npm bin)/ghost start
  fi
  deploy
else
  color_echo "[INFO] stopping all" 
  $(npm bin)/ghost stop
fi
#!/bin/bash

REPO_DIR="$HOME/projects/nitinarya1001"

CONTAINER_PORT="3001"
LOCAL_PORT="127.0.0.1:3001"

cd "$REPO_DIR" || { echo "Failed to change directory to $REPO_DIR"; exit 1; }

git fetch
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse @{u})

if [ "$LOCAL" != "$REMOTE" ]; then
    echo "Changes detected! Pulling the latest version..."
    git pull

    echo "Stopping and removing the existing 'portfolio_webapp' container..."
    docker rm -f portfolio_webapp 2>/dev/null || echo "No existing container found."

    echo "Removing the old 'portfolio_app' image..."
    docker rmi portfolio_app 2>/dev/null || echo "No existing image found."
    
    echo "Building new Docker image 'portfolio_app'..."
    docker build -t portfolio_app .

    echo "Starting the new 'portfolio_webapp' container..."
    docker run -d --name portfolio_webapp -p $LOCAL_PORT:$CONTAINER_PORT portfolio_app

    echo "Deployment successful."
fi

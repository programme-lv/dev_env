#!/usr/bin/bash

read -p "The script will remove all running containers. Are you sure? [yY] "
if [[ $REPLY =~ ^[Yy]$ ]]
then
    if [[ $(docker ps -a -q) ]]; then
        echo "Removing all running containers..."
        docker stop $(docker ps -a -q)
        docker container prune -f
    else
        echo "No running containers found."
    fi
fi
echo "Script finished."
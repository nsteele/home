#!/bin/bash

SSH_CONFIG=$(vagrant ssh-config)
HOST=$(echo "$SSH_CONFIG" | grep "HostName " | awk '{print $2}')
USER=$(echo "$SSH_CONFIG" | grep "User " | awk '{print $2}')

/opt/VirtualGL/bin/vglconnect "${USER}@${HOST}"

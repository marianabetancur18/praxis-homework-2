#!/usr/bin/env bash
#Backend run
#Part 1: Search for the binary
cd /shared

#Part 2: Search how to run the command in the background (aka, detach it from the terminal) so that you can close your terminal and the process will still runs in the background. Also, remember about the environment variable. It's a requirement for this exercise to run the app in the port 4001
sudo echo 'export PORT=4001' >> /etc/profile

#Part 3: Run the command in the background
cd /shared/
nohup ./vuego-demoapp > server.out 2>&1 &

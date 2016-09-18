#!/bin/bash
if [ ! -d "log" ]; then
    echo "Creating log directory..."
    mkdir log
fi
echo "Starting bot..."
nohup ruby compclubbot.rb >> log/ccb.log 2>> log/ccb-err.log &
echo "Bot started!"

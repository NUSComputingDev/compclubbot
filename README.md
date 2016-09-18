#CompClubBot
Utility bot that gives info regarding NUS Students' Computing Club.

Written in Ruby.

#Setup
To start the bot:
1. Run `cp secrets.yml.example secrets.yml`
2. Open `secrets.yml` and fill in the token for this bot.
3. Run `./start.sh` to start the bot in the background.

To kill the bot once started:
1. Run `ps -af`.
2. Find the PID for `ruby compclubbot.rb`.
3. Run `kill <PID>` where <PID> is the PID found in the previous step.

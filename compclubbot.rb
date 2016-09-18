require './secrets.rb'
require 'telegram/bot'
require 'nokogiri'
require 'open-uri'

welcomeMessage = "Welcome to Computing Club Bot.\n\nUse /getblast to get the latest email blast message."
errorMessage = "Error retrieving email blast. Please try again later."
unknownCmdMessage = "Unknown command. Please try again."

Telegram::Bot::Client.run(token, logger: Logger.new($stderr)) do |bot|
    bot.listen do |message|
        bot.logger.info message.text
        messageSplit = message.text.split
        cmd = messageSplit[0]

        case cmd
        when '/start'
            bot.api.send_message(chat_id: message.chat.id,
                                 text: welcomeMessage
                                )

        when '/getblast', '/gb', '/getblast@compclubbot', '/gb@compclubbot'
            if messageSplit.length == 1 || messageSplit[1] == 'latest'
                bot.api.send_message(chat_id: message.chat.id,
                                     text: "Retrieving latest email blast, please wait..."
                                    )
            else
                bot.api.send_message(chat_id: message.chat.id,
                                     text: "Retrieving email blast \"#{messageSplit[1]}\", please wait..."
                                    )
            end

            begin
                blastpage = Nokogiri::HTML(open('https://newsletters.nuscomputing.com'))
                blastItems = blastpage.css('p')
                compiledBlast = ''
                blastItems.each do |item|
                    compiledBlast << item.text << "\n"
                end
                puts compiledBlast
                bot.api.send_message(chat_id: message.chat.id,
                                     text: compiledBlast
                                    )

            rescue OpenURI::HTTPError
                bot.api.send_message(chat_id: message.chat.id,
                                     text: errorMessage
                                    )
            end

        else
            bot.api.send_message(chat_id: message.chat.id, 
                                 text: welcomeMessage
                                )
        end
    end
end
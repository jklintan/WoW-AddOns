--[[--------------------------------------------------------------------------
  Copyright (c) 2020, Josefine Klintberg, jklintan.github.io
  All rights reserved.

  A fun plug-in for additional jokes and special guild easter eggs for
  the guild Stockholm Syndrome
--------------------------------------------------------------------------]]--

if(jokify) then
    C_Timer.After(4, function() 
        error("ERROR!! -> jokify already loaded")
        for i=1, 10 do
            DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000ERROR!!|r -> Jokes already loaded! Please only have one jokify installed")
        end
    end);
    error("ERROR!! -> Jokes already loaded! Please only have one jokify installed")
    DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000ERROR!!|r -> Jokes already loaded! Please only have one jokify installed")
    jokify = {}
    return nil;
end


jokify = {...}

local jokes = {"Time flies like an arrow. Fruit flies like a banana.", "Show me a piano falling down a mineshaft and I'll show you A-flat minor.", "To write with a broken pencil is pointless.",
                "A bicycle can't stand on its own because it is two-tired.", "Those who get too big for their britches will be exposed in the end.", "When a clock is hungry it goes back four seconds.",
                "A chicken crossing the road is poultry in motion.", "If you don't pay your exorcist you get repossessed.", "What's the definition of a will? It's a dead giveaway.", 
                "The man who fell into an upholstery machine is fully recovered.", "Every calendar's days are numbered.", "Bakers trade bread recipes on a knead to know basis.", 
                "When the electricity went off during a storm at a school the students were de-lighted.", "I used to be a tap dancer until I fell in the sink.", 
                "He wears glasses during math because it improves division.", "She was only a whisky maker but he loved her still.", "She had a boyfriend with a wooden leg, but broke it off.",
                "Those who jump off a Paris bridge are in Seine.", "It wasn't school John disliked it was just the principal of it.", "It's better to love a short girl than not a tall.", 
                "There was once a cross-eyed teacher who couldn't control his  pupils.", "A grenade thrown into a kitchen in France would result in Linoleum Blownapart.", 
                "A boiled egg in the morning is hard to beat.", "The one who invented the door knocker got a No-bell prize.", "Old power plant workers never die they just de-generate.", 
                "There was a ghost at the hotel, so they called for an inn spectre.", "With her marriage she got a new name and a dress.", 
                "The short fortune-teller who escaped from prison was a small medium at large", "Some Spanish government employees are Seville servants.", 
                "He drove his expensive car into a tree and found out how the Mercedes bends.", "Show me someone in denial and I'll show you a person in Egypt up to their ankles.", 
                "Two peanuts were walking in a tough neighborhood and one of them was a-salted.", "When cannibals ate a missionary they got a taste of religion.", 
                "When an actress saw her first strands of gray hair she thought she'd dye.", "He often broke into song because he couldn't find the key.", 
                "Marathon runners with bad footwear suffer the agony of defeat.", "Driving on so many turnpikes was taking its toll.", "To some - marriage is a word ... to others - a sentence.",
                "Old lawyers never die they just lose their appeal.", "In democracy its your vote that counts. In feudalism its your count that votes.", "Atheism is a non-prophet organization",
                "It was an emotional wedding. Even the cake was in tiers.", "Old skiers never die -- they just go down hill.", "A cardboard belt would be a waist of paper.", 
                "Local Area Network in Australia: the LAN down under.", "When the TV repairman got married the reception was excellent.", 
                "An office with many people and few electrical outlets could be in for a power struggle.", "How do you make antifreeze? Steal her blanket.", 
                "A small boy swallowed some coins and was taken to a hospital. When his grandmother telephoned to ask how he was a nurse said 'No change yet'.", 
                "A pediatrician is a doctor of little patients.", "Nylons give women a run for their money.", "Talking to her about computer hardware I make my mother board.", 
                "Ancient orators tended to Babylon.", "The best way to stop a charging bull is to take away his credit card.", "If you give some managers an inch they think they're a ruler.", 
                "Two silk worms had a race. They ended up in a tie.", "He had a photographic memory that was never developed.", "Old burglars never die they just steal away.", 
                "A lawyer for a church did some cross-examining.", "Chronic illegal parkers suffer from parking zones disease.", "Some people don't like food going to waist..",
                "A cannibal's favourite game is 'swallow the leader'.", "You feel stuck with your debt if you can't budge it.", "Boys who don't get asked out as often as their friends could feel out-dated.",
                "We were so poor when I was growing up we couldn't even afford to pay attention. ", "A pet store had a bird contest with no perches necessary.", "A backwards poet writes inverse.",
                "If a lawyer can be disbarred can a musician be denoted or a model deposed?", "Once you've seen one shopping center you've seen a mall.", "When the smog lifts in Los Angeles, U C L A.",
                "A plateau is a high form of flattery.", "When chemists die, we barium.", "A long knife has been invented that cuts four loaves of bread at a time called a four loaf cleaver.",
                "When the wheel was invented, it caused a revolution.", "Two robbers with clubs went golfing, but they didn't play the fairway.", "Seven days without a pun makes one weak.",
                "A circus lion won't eat clowns because they taste funny.", "A toothless termite walked into a tavern and said, 'Is the bar tender here?'", 
                "Did you hear about the fire at the circus? The heat was intense.", "A tattoo artist has designs on his clients.", "Santa's helpers are subordinate clauses.", 
                "A lot of money is tainted. It taint yours and it taint mine.", "When they bought a water bed, the couple started to drift apart.", "What you seize is what you get.", 
                "Gardeners always know the ground rules.", "Some people's noses and feet are build backwards: their feet smell and their noses run.", 
                "Two banks with different rates have a conflict of interest.", "A successful diet is the triumph of mind over platter.", "What do you call cheese that is not yours? Nacho Cheese.", 
                "When a new hive is done bees have a house swarming party.", "Looting a drugstore is called Pillaging", "Never lie to an x-ray technician. They can see right through you.", 
                "Old programmers never die, they just can't C as well.", "A music store had a small sign which read: Bach in a Minuet.", "Long fairy tales have a tendency to dragon.", 
                "Visitors to Cuba are usually Havana good time.", "A bachelor is a guy who is footloose and fiancée-free.", "A ditch digger was entrenched in his career.", 
                "A girl and her boyfriend went to a party as a barcode. They were an item.", "A criminal's best asset is his lie ability."}

-- EVENTHANDLER
local EventFrame = CreateFrame("frame", "EventFrame")
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
EventFrame:RegisterEvent("MAIL_SHOW")
EventFrame:RegisterEvent("PLAYER_DEAD")
EventFrame:RegisterEvent("START_LOOT_ROLL")
EventFrame:RegisterEvent("PLAYER_LEVEL_UP")

EventFrame:SetScript("OnEvent", function(self, event, ...)
    local playerName = UnitName("player")
    if(event == "PLAYER_ENTERING_WORLD") then    
        print("Welcome back", playerName)
        print("You are playing with jokify, extra fun guaranteed. Good choice!")
        local guildName = GetGuildInfo("player")
        if(guildName == "Stockholm Syndrome")
        then
            print("BÄSTA guilden dessutom")
        end
    end
    if(event == "MAIL_SHOW") then
        local mailJoke = "What do you get if you cross a werewolf with a dog? A terrified postman"
        print(mailJoke)
    end
    if(event == "PLAYER_DEAD") then
        print("You died", playerName, "... You know corpses aren't very funny, they're dead serious")
    end
    
    if(event == "START_LOOT_ROLL") then
        local guildName = GetGuildInfo("player")
        if(guildName == "Stockholm Syndrome")
        then
            print("Hmmm, vad är oddsen att du rollar 28?!")
        end
    end
    
    if(event == "PLAYER_LEVEL_UP")then
        if(guildName == "Stockholm Syndrome")then
            SendChatMessage("DING!", "GUILD")
        end
    end
end)

SLASH_JOKIFY1 = "/jokify"
SLASH_JOKIFY2 = "/joke"
local first = true

SlashCmdList["JOKIFY"] = function(txt)
    local playerName = UnitName("player")
    local guildName = GetGuildInfo("player")
    local rand = math.random (1, 100)
    local currJoke = jokes[rand]

    local targetName = UnitName("target")

    if(UnitInParty("player"))then     
        if(playerName == "Hasenöhrl" or playerName == "Zweistein")then
            if(targetName ~= nil)then
                if(targetName == "Farahwaynah")then
                    print("Haha, skulle du vara roligare än Jossan?! Tror knappast det...")
                    DoEmote("CRY")
                end
            end
        else
            SendChatMessage(currJoke, "PARTY")
        end
    else
        if(targetName ~= nil) then
            SendChatMessage(currJoke, "WHISPER", nil, GetUnitName("PLAYERTARGET"))
            DoEmote("LAUGH")
        else
            print("JOKE TIME: ", currJoke)
            DoEmote("LAUGH")
        end
    end

    DEFAULT_CHAT_FRAME.editBox:Hide();
    editBox:ClearFocus()
end

-- SHOW STATS ABOUT GUILD
SLASH_STATS1 = "/stats"
SlashCmdList["STATS"] = function(txt)
    jokifyFrameStats:Show()
    local numTotal, numOnlineMaxLevel, numOnline = GetNumGuildMembers();
    local guildName, guildRankID, guildRank = GetGuildInfo("player")
    if(guildName ~= nil)then 
        local text = "In your guild " .. guildName .. " \n there is " .. numTotal .. " guild members: " .. numOnline .. " online"
        message(text)
    else
        print("You are currently not in a guild...")
    end
end
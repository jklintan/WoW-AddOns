--[[--------------------------------------------------------------------------
  Copyright (c) 2020, Josefine Klintberg, jklintan.github.io
  All rights reserved.

  A plug-in for easy statistics about online guild members and level up
  messages within the guild chat.
--------------------------------------------------------------------------]]--

if(guilder) then
    C_Timer.After(4, function() 
        error("ERROR!! -> guilder already loaded")
        for i=1, 10 do
            DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000ERROR!!|r -> Guilder already loaded! Please only have one guilder installed")
        end
    end);
    error("ERROR!! -> Guilder already loaded! Please only have one guilder installed")
    DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000ERROR!!|r -> Guilder already loaded! Please only have one guilder installed")
    jokify = {}
    return nil;
end

guilder = {...}

-- EVENTHANDLER
local EventFrame = CreateFrame("frame", "EventFrame")
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
EventFrame:RegisterEvent("START_LOOT_ROLL")
EventFrame:RegisterEvent("PLAYER_LEVEL_UP")
EventFrame:RegisterEvent("PLAYER_LOGOUT")
EventFrame:RegisterEvent("ADDON_LOADED")

EventFrame:SetScript("OnEvent", function(self, event, ...)
    local playerName = UnitName("player")
    if(event == "PLAYER_ENTERING_WORLD") then    
        local guildName = GetGuildInfo("player")
        if(levelUpMessage == "") then
            print("Welcome to Guilder. You do not have any 'level up message' set. Set your custom level up message by typing /setlvlmsg followed by your custom level up message.")
            if(guildName == "Stockholm Syndrome") then
                print("BÄSTA guilden dessutom")
            end
        end
    end
    if(event == "ADDON_LOADED") then
        if(levelUpMessage == nil) then
            levelUpMessage = "" -- if no level up message is set
        end
    end
    if(event == "START_LOOT_ROLL") then
        local guildName = GetGuildInfo("player")
        if(guildName == "Stockholm Syndrome")
        then
            print("Hmmm, vad är oddsen att du rollar 28?!")
        end
    end
    if(event == "PLAYER_LEVEL_UP")then
        local guildName = GetGuildInfo("player")
        if(levelUpMessage ~= "") then
            if(guildName ~= nil) then 
                SendChatMessage(levelUpMessage, "GUILD")
            else
                print(levelUpMessage)
            end
        end
    end
end)

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

-- DISPLAY LEVEL UP MESSAGE
SLASH_LVLMSG1 = "/lvlmsg"
SlashCmdList["LVLMSG"] = function(txt)
    local text = "Current level up message is set to: " .. levelUpMessage
    message(text)
end

-- SET LEVEL UP MESSAGE
SLASH_SETLVLMSG1 = "/setlvlmsg"
SlashCmdList["SETLVLMSG"] = function(txt)
    levelUpMessage = txt
    local text = "Your level up message is set to: " .. levelUpMessage
    message(text)
end
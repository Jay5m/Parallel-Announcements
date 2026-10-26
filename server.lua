local RESOURCE = GetCurrentResourceName()

-- os.time() of the next scheduled restart, so players who load in during the
-- final countdown still get the warning.
local restartAt = nil

local function sendAnnouncement(target, message, author)
    TriggerClientEvent(RESOURCE .. ':announcement', target, message, author)
end

local function sendRestart(target, secondsRemaining)
    TriggerClientEvent(RESOURCE .. ':restart', target, secondsRemaining)
end

-- txAdmin -> "Send Announcement" (web panel, in-game menu, or Discord bot)
AddEventHandler('txAdmin:events:announcement', function(data)
    local author = data.author
    if GetConvar('txAdmin-hideAdminInMessages', 'false') == 'true' then
        author = GetConvar('txAdmin-serverName', 'txAdmin')
    end
    sendAnnouncement(-1, data.message or '', author)
end)

-- txAdmin scheduler warnings (fired at 30, 15, 10, 5, 4, 3, 2 and 1 minutes before a restart)
AddEventHandler('txAdmin:events:scheduledRestart', function(data)
    local seconds = tonumber(data.secondsRemaining) or 0
    restartAt = os.time() + seconds
    sendRestart(-1, seconds)
end)

local function onRestartSkipped()
    restartAt = nil
    TriggerClientEvent(RESOURCE .. ':restartCancel', -1)
end
AddEventHandler('txAdmin:events:scheduledRestartSkipped', onRestartSkipped)
AddEventHandler('txAdmin:events:skippedNextScheduledRestart', onRestartSkipped)

RegisterNetEvent(RESOURCE .. ':requestState', function()
    local src = source
    if not restartAt then return end
    local remaining = restartAt - os.time()
    if remaining > 0 and remaining <= Config.RestartStickyBelow then
        sendRestart(src, remaining)
    end
end)

if Config.TestCommands then
    RegisterCommand('txnotify_announce', function(_, args)
        local message = table.concat(args, ' ')
        if message == '' then message = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit' end
        sendAnnouncement(-1, message, 'txAdmin')
    end, true)

    RegisterCommand('txnotify_restart', function(_, args)
        -- Preview only: shows the countdown but does not restart anything.
        sendRestart(-1, tonumber(args[1]) or 15)
    end, true)
end

-- The default txAdmin UI keeps showing alongside ours unless these are enabled.
CreateThread(function()
    Wait(2000)
    local missing = {}
    if GetConvar('txAdmin-hideDefaultAnnouncement', 'false') ~= 'true' then
        missing[#missing + 1] = 'Hide Announcement Notifications'
    end
    if GetConvar('txAdmin-hideDefaultScheduledRestartWarning', 'false') ~= 'true' then
        missing[#missing + 1] = 'Hide Scheduled Restart Warnings'
    end
    if #missing > 0 then
        print(('^3[%s] txAdmin is still showing its default notifications. Enable "%s" in txAdmin > Settings > Game > Notifications, then restart the server.^0')
            :format(RESOURCE, table.concat(missing, '" and "')))
    end
end)

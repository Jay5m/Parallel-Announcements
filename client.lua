local RESOURCE = GetCurrentResourceName()

local function playSound()
    if Config.Sound.Enabled then
        PlaySoundFrontend(-1, Config.Sound.Name, Config.Sound.Set, true)
    end
end

-- The page posts this once React has mounted and is listening for messages.
RegisterNUICallback('ready', function(_, cb)
    SendNUIMessage({
        action = 'settings',
        data = {
            position = Config.Position,
            offset = Config.Offset,
            maxAnnouncements = Config.MaxAnnouncements,
        },
    })
    TriggerServerEvent(RESOURCE .. ':requestState')
    cb({})
end)

RegisterNetEvent(RESOURCE .. ':announcement', function(message, author)
    SendNUIMessage({
        action = 'announcement',
        data = {
            message = message,
            author = author,
            duration = Config.AnnouncementDuration,
        },
    })
    playSound()
end)

RegisterNetEvent(RESOURCE .. ':restart', function(secondsRemaining)
    SendNUIMessage({
        action = 'restart',
        data = {
            secondsRemaining = secondsRemaining,
            message = Config.RestartMessage,
            duration = Config.RestartDuration,
            stickyBelow = Config.RestartStickyBelow,
        },
    })
    playSound()
end)

RegisterNetEvent(RESOURCE .. ':restartCancel', function()
    SendNUIMessage({ action = 'restartCancel' })
end)

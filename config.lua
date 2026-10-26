Config = {}

-- Where the notifications sit on screen: 'top', 'center' or 'bottom'
Config.Position = 'top'
-- Distance from the top/bottom edge in 1080p pixels (scaled to the player's resolution)
Config.Offset = 60

-- How long an announcement stays on screen (seconds)
Config.AnnouncementDuration = 12
-- Max announcements shown at once; the oldest is pushed out when a new one arrives
Config.MaxAnnouncements = 3

-- How long each scheduled restart warning stays on screen (seconds)
Config.RestartDuration = 15
-- Once the restart is this close (seconds), the card stays up and counts down live until the restart
Config.RestartStickyBelow = 60
-- Body text of the restart card
Config.RestartMessage = 'Please find a safe place to log out or you may lose progress.'

-- Frontend sound played when a notification appears (set Enabled = false to mute)
Config.Sound = {
    Enabled = true,
    Name = 'CHALLENGE_UNLOCKED',
    Set = 'HUD_AWARDS',
}

-- Admin test commands: /txnotify_announce <text> and /txnotify_restart <seconds>
-- Restricted: grant with  add_ace group.admin command.txnotify_announce allow  (same for txnotify_restart)
Config.TestCommands = true

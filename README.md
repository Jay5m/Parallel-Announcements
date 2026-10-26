# txadmin-notify

React + TypeScript replacement for txAdmin's default **Server Announcement** and **Scheduled Restart** notifications.

## Install

1. Copy this folder into your server's `resources` (you only need `fxmanifest.lua`, `config.lua`, `client.lua`, `server.lua` and `web/dist`; `web/src` and `web/node_modules` are for editing the UI).
2. Add `ensure txadmin-notify` to `server.cfg`.
3. In **txAdmin → Settings → Game → Notifications**, turn on:
   - **Hide Announcement Notifications**
   - **Hide Scheduled Restart Warnings**

   Save, then restart the server. txAdmin applies these as the convars `txAdmin-hideDefaultAnnouncement` and `txAdmin-hideDefaultScheduledRestartWarning`. Set them in the panel, not in `server.cfg`, because txAdmin overrides them on launch. Until both are on, the resource prints a yellow warning in the console and txAdmin keeps drawing its own popup next to this one.

## How it works

| txAdmin event | Shows |
| --- | --- |
| `txAdmin:events:announcement` | Orange **SERVER ANNOUNCEMENT** card with the admin's message |
| `txAdmin:events:scheduledRestart` | White **SERVER RESTARTING IN X MINUTES/SECONDS** card with a live countdown |
| `txAdmin:events:scheduledRestartSkipped` | Hides the restart card |

Inside the last `Config.RestartStickyBelow` seconds (default 60), the restart card stays on screen and counts down to zero. Players who join during that window see it too.

## Testing in game

With the ace permissions granted (`add_ace group.admin command.txnotify_announce allow`, and the same for `command.txnotify_restart`):

- `/txnotify_announce Hello everyone`
- `/txnotify_restart 15` (only shows the countdown, does not restart anything)

## Editing the UI

```
cd web
npm install
npm run dev     # browser preview with test buttons and a Figma overlay toggle
npm run build   # outputs web/dist, which is what FiveM loads
```

The layout is in Figma pixels at 1920×1080 and scales to the player's resolution.

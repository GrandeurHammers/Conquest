# Overwatch: Conquest
Originally designed as an adaptation of Destiny 2's Control and Iron Banner gamemodes for Overwatch, Conquest is a fast-paced arcade-style team deathmatch. Team fight to control 3 zones, which grant more points per kill. Should a team cap all 3 points, a Power Play will ensue, locking down all the zones and freeing the advantaged team to chase down kills. Supports teams of any size, so grab your friends and game on!  
Project Link: [workshop.codes/conquest](https://workshop.codes/conquest)  
Trailer: [YouTube](https://youtu.be/PxxSFlxicuk)

Gameplay Overview
--------
Two teams fight to control 3 zones and earn kills. Fully capturing a zone yields 1 point, and kills have a base value of 1 point. However, the more zones a team controls, the more valuable each kill is. Should a team capture all 3 zones, Power Play will trigger. During Power Play, all zones are locked, freeing the advantaged team to chase down kills for a set period of time. First team to reach 100 points wins!

Installation
----------
The `lobby.owcs` contains custom game settings that can be copied and pasted into a Custom Game by the host by doing the following:
- Copy the contents of `lobby.owcs`
- Open the Settings of the custom game
- Click the orange paste icon

Alternatively, the latest Workshop code can be found [at this link](https://workshop.codes/conquest)

*Note: `lobby.owcs` is the latest compiled version of the branch it is in.*

Supported Maps
-----
- Blizzard World*
- Lijang Tower: Control Center*
- Lijang Tower: Garden*
- Lijang Tower: Night Market*
- Oasis: City Center
- Oasis: Gardens
- Oasis: University

\**All seasonal/event variants supported*

More maps coming soon!

Customization
-------------
![](https://i.imgur.com/vYpqwDI.png)
- Capture Rate | `% per second = captureRatePerPlayer * min(# capturing players, maxPlayerRate) + baseCaptureRate`
	- `baseCaptureRate` | Default: 4%/s
	- `captureRatePerPlayer` | Default: 2%/s
	- `maxPlayerRate` | Default: 6 players
- Power Play
	- `powerPlayEnabled` | Whether all 3 zones being controlled by one team will trigger Power Play - Default: True
	- `powerPlayDuration` | Default: 30 seconds
	- `powerPlayMarkers` | Whether the targeted team will have markers giving away their position during Power Play - Default: True
- `Score To Win` | Default: 100
	- This does not automatically update the in-game scoreboard. In order for the scoreboard to display properly, the host must change "Settings > Modes > Score to Win" to match this value.

Technical Details
----
### Zones:
- See **`Customization > Capture Rate`** for capture rate formula
- When both teams enter a zone, capture progress (if there is any) is immediately frozen.
- If a zone is controlled by a team, the other team has accrued capture progress, and the currently controlling team remains alone on the zone for 1 second, capture progress is immediately reset.
- A zone which has capture progress and which has not been contested or progressed for 3 seconds will have its capture progress decay at a rate of 25% per second until it reaches 0.
- A team which attempts to capure a neutral zone with capture progress from the other team must remain in the zone uncontested for 1 second before the zone will reset capture progress and begin counting progress towards their team instead.
- The capture region of a zone is a cylinder which extends for half a meter below the designated zone location and up to the designated zone height. For capturing purposes, a zone considers a player's foot position, not their camera position.
### Power Play:
- A Power Play cannot last for longer than the remaining amount of regulation time remaining. This limitation does not affect Overtime.

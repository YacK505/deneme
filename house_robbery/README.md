# House Robbery Script

This is a simple **FiveM** resource for `qb-core` that lets players lockpick a house door and loot spots inside. It uses `ox_lib` for the lockpick minigame and rewards are given via `ox_inventory`.

## Features

- Lockpick a door using `ox_lib`'s lockpick mini-game
- Teleport to a small interior when the lockpick succeeds
- Multiple houses defined in `config.lua`
- Six lootable spots that reward the player with random items or cash
- Configurable search duration when looting
- Noise meter that alerts police when too much noise is made
- On-screen text UI, notifications and progress bars provided by `ox_lib`

## Usage

1. Place the `house_robbery` folder in your FiveM resources folder.
2. Add `ensure house_robbery` to your `server.cfg`.
3. Give players a lockpick item. Trigger the event `houseRobbery:useLockpick` when they use it.

The coordinates in `config.lua` are examples. Adjust them to fit your map/interior.

# esx_backpack
FiveM Script - Usable Backpack Item

**Forum:** https://forum.cfx.re/t/release-esx-usable-backpack-item/4805469

**Discord Support:** https://discord.gg/5hHSBRHvJE

## Description
* You can use the `bag` Item, then you get `nobag` Item and a Bag will be added to your Ped.
* If you use `nobag` Item then then the Bag will be removed from your Ped an you get the `bag` Item.

## Config
```lua
Config = {}
----------------------------------------------------------------
Config.Locale = 'de'
Config.VersionChecker = true
Config.Debug = true
----------------------------------------------------------------
-- If you use the Plugin for Chezza Inventory, make sure this is the same ID
-- as in Config.Bags = {82} in the config.lua from chezza inventory
Config.Bags = {
    male = {bagID_1 = 82, bagID_2 = 0},
    female = {bagID_1 = 82, bagID_2 = 0}
}
----------------------------------------------------------------
-- If set to true go to server.lua and change the IDs to what you set in esx_parachute
Config.useParachute = true -- Set false if you dont use my esx_parchute Script
----------------------------------------------------------------
Config.CarryLongWeapon = true -- Set 'true' if you want that Players can only carry a Weapon if they have a Bag
Config.WeaponBags = {82} -- Backpack IDs // {ID, ID, ID} | Only for 'Config.CarryLongWeapon' function!!
Config.Weapons = {
    'WEAPON_CARBINERIFLE',
    'WEAPON_GUSENBERG',
    'WEAPON_PUMPSHOTGUN',
    'WEAPON_ADVANCEDRIFLE',
    'WEAPON_ASSAULTRIFLE',
}
```

## Requirements
* esx_skin
* skinchanger
* ESX 1.2 *(v1-final)* / Legacy
* Chezza Inventory (https://forum.cfx.re/t/paid-release-chezzas-inventory-esx/2040417)

Should work with ESX Legacy too but I didn't test it.

### Chezza Inventory Plugin

Add `Config.Bags = {82}` and `Config.BagWeight = 60` in the `config.lua` from chezza inventory.

#### Events / Commands
* `/openbag` - Open your own Bag
* `/stealbag` - Open the Bag from Player next to you
* Search Bag *[clientsided]* - `TriggerServerEvent('inventory:updateStealInventoryBag', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))`

## License
**GNU General Public License v3.0**

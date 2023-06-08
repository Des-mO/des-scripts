local attacker = PlayerPedId()
local weaponHash = GetSelectedPedWeapon(attacker)
local damageAmount = 25
local damageType = 1
local entity = GetVehiclePedIsIn(attacker, false)

TriggerServerEvent("vehicleDamage", attacker, weaponHash, damageAmount, damageType, entity)

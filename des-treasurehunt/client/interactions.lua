-- Example interaction code (e.g., when the player interacts with the ped)
function InteractWithPed(pedId)
    local playerId = -- Player ID or source of the player interacting with the ped
    TriggerServerEvent('playerInteractPed', pedId) -- Trigger the event on the server-side
end

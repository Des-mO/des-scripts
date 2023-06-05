-- Define quest data
local quests = {
    {
        name = 'Quest 1',
        objective = 'Find the ancient artifact',
        reward = 'coke_brick', -- change reward
        clue = 'The treasure is hidden near the old oak tree.'
    },
    -- Add more quests here
}


-- create ped at set vectors

local pedPositions = {
    vector3(100.0, -200.0, 30.0),
    vector3(150.0, -250.0, 30.0),
    vector3(200.0, -300.0, 30.0)
}

function SpawnPedForQuest()
    local model = GetHashKey('s_m_y_dealer_01')  -- Ped model (customize as needed)
    local pedCoords = pedPositions[math.random(1, #pedPositions)]  -- Get a random position from the list

    local ped = CreatePed(5, model, pedCoords.x, pedCoords.y, pedCoords.z, 0, false, true)
    SetEntityAsMissionEntity(ped, true, true)
    SetPedDropsWeaponsWhenDead(ped, false)

    exports['my-ped-interaction']:SetPedAsInteractable(ped)

    TriggerClientEvent('startQuestPedSpawned', -1, ped)
end

-- Event and interaction handling code...

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    SpawnPedForQuest()
end)


-- Function to give a clue to a player
function GiveClue(playerId)
    local randomQuest = quests[math.random(1, #quests)]  -- Select a random quest
    TriggerClientEvent('receiveClue', playerId, randomQuest.clue)  -- Send clue to the client
end

-- Function to handle player interaction with a treasure
function InteractTreasure(playerId)
    local randomQuest = quests[math.random(1, #quests)]  -- Select a random quest
    TriggerClientEvent('interactTreasure', playerId, randomQuest.reward)  -- Send treasure reward to the client
    CompleteQuest(playerId)  -- Complete the quest for the player
end

-- Trigger events to simulate gameplay
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)  -- Wait for 60 seconds (adjust this as needed)

        -- Simulate giving a clue to a random player
        local players = GetPlayers()
        if #players > 0 then
            local randomPlayer = players[math.random(1, #players)]
            GiveClue(randomPlayer)
        end
    end
end)

-- Register command to start a quest for a player
RegisterCommand('startquest', function(source, args, rawCommand)
    local playerId = source
    StartQuest(playerId)
end, false)

-- Register command to interact with a treasure for a player
RegisterCommand('interacttreasure', function(source, args, rawCommand)
    local playerId = source
    InteractTreasure(playerId)
end, false)

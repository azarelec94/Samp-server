local Players = {}

Players.data = {}

function Players.create(playerid)
    Players.data[playerid] = {
        connected = true,
        logged = false,

        account_id = 0,
        character_id = 0,

        name = "",
        cash = 0,
        bank = 0,

        faction_id = 0,
        faction_rank = 0,

        job_id = 0,
        phone_number = nil,

        health = 100
    }
end

function Players.get(playerid)
    return Players.data[playerid]
end

function Players.exists(playerid)
    return Players.data[playerid] ~= nil
end

function Players.isLogged(playerid)
    local player = Players.get(playerid)

    return player ~= nil and player.logged == true
end

function Players.remove(playerid)
    Players.data[playerid] = nil
end

function Players.setLogged(playerid, account_id)
    local player = Players.get(playerid)

    if not player then
        return false
    end

    player.logged = true
    player.account_id = account_id

    return true
end

return Players

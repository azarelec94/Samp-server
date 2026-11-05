local Health = {}

function Health.get(playerid)
    return interop.native.GetPlayerHealth(playerid)
end

function Health.set(playerid, value)
    if type(value) ~= "number" then
        return false
    end

    if value < 0 or value > 100 then
        return false
    end

    interop.native.SetPlayerHealth(playerid, value)

    return true
end

function Health.heal(playerid)
    return Health.set(playerid, 100)
end

return Health

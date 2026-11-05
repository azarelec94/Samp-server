local Commands = {}

Commands.list = {}

function Commands.register(name, callback)
    assert(type(name) == "string")
    assert(type(callback) == "function")

    name = string.lower(name)

    if Commands.list[name] then
        error("Comando duplicado: " .. name)
    end

    Commands.list[name] = callback
end

function Commands.execute(playerid, command, params)
    command = string.lower(command)

    local callback = Commands.list[command]

    if not callback then
        return false
    end

    local success, result = pcall(
        callback,
        playerid,
        params or ""
    )

    if not success then
        print("[COMMAND ERROR] " .. tostring(result))
        return false
    end

    return result == true
end

return Commands

local interop = require "interop"
local native = interop.native

local Config = require "config.server"

local Bootstrap = require "core.bootstrap"
local Players = require "core.players"
local Commands = require "core.commands"

local Health = require "systems.health"

print("--------------------------------")
print(" SAMP FULL ROLEPLAY")
print(" Lua Runtime iniciado")
print("--------------------------------")

-- Registrar modulos
Bootstrap.register("health", Health)

-- Comando ayuda
Commands.register("ayuda", function(playerid)
    native.SendClientMessage(
        playerid,
        Config.colors.green,
        "Bienvenido a " .. Config.name
    )

    native.SendClientMessage(
        playerid,
        Config.colors.white,
        "Comandos disponibles: /ayuda /estado"
    )

    return true
end)

-- Comando estado
Commands.register("estado", function(playerid)
    if not Players.exists(playerid) then
        return false
    end

    local player = Players.get(playerid)

    native.SendClientMessage(
        playerid,
        Config.colors.yellow,
        "Estado: conectado"
    )

    native.SendClientMessage(
        playerid,
        Config.colors.white,
        "Cuenta: " .. tostring(player.logged and "Conectada" or "Sin iniciar sesion")
    )

    return true
end)

-- Conexion
function interop.public.OnPlayerConnect(playerid)
    playerid = interop.asinteger(playerid)

    Players.create(playerid)

    native.SendClientMessage(
        playerid,
        Config.colors.green,
        "Bienvenido a " .. Config.name
    )

    native.SendClientMessage(
        playerid,
        Config.colors.white,
        "Usa /ayuda para consultar los comandos."
    )

    return 1
end

-- Desconexion
function interop.public.OnPlayerDisconnect(playerid, reason)
    playerid = interop.asinteger(playerid)

    Players.remove(playerid)

    return 1
end

-- Comandos
function interop.public.OnPlayerCommandText(playerid, cmdtext)
    playerid = interop.asinteger(playerid)
    cmdtext = interop.asstring(cmdtext)

    local command, params = string.match(
        cmdtext,
        "^/([^ ]+)%s*(.*)$"
    )

    if not command then
        return 0
    end

    if Commands.execute(playerid, command, params) then
        return 1
    end

    return 0
end

-- Inicializacion
if not Bootstrap.start() then
    error("No se pudieron iniciar los modulos.")
end

print("[ROLEPLAY] Sistema principal cargado.")

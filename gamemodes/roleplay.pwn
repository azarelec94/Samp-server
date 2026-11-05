#include <a_samp>
#include <YALP>

new Lua:g_Lua;

public OnGameModeInit()
{
    print("----------------------------------");
    print(" SAMP FULL ROLEPLAY");
    print(" Inicializando entorno Lua");
    print("----------------------------------");

    g_Lua = lua_newstate();

    if (g_Lua == Lua:0)
    {
        print("[ERROR] No se pudo crear la maquina Lua.");
        return 0;
    }

    if (lua_loadfile(g_Lua, "lua/main.lua") != 0)
    {
        print("[ERROR] No se pudo cargar lua/main.lua.");
        lua_stackdump(g_Lua);
        return 0;
    }

    lua_bind(g_Lua);

    print("[ROLEPLAY] Entorno Lua vinculado.");

    return 1;
}

public OnGameModeExit()
{
    print("[ROLEPLAY] Cerrando GameMode.");

    return 1;
}

public OnPlayerConnect(playerid)
{
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    return 1;
}

local Bootstrap = {}

Bootstrap.modules = {}
Bootstrap.started = false

function Bootstrap.register(name, module)
    assert(type(name) == "string")
    assert(type(module) == "table")

    assert(
        Bootstrap.modules[name] == nil,
        "Modulo duplicado: " .. name
    )

    Bootstrap.modules[name] = module
end

function Bootstrap.start()
    if Bootstrap.started then
        return false
    end

    local names = {}

    for name in pairs(Bootstrap.modules) do
        names[#names + 1] = name
    end

    table.sort(names)

    for _, name in ipairs(names) do
        local module = Bootstrap.modules[name]

        if module.init then
            local ok, err = pcall(module.init)

            if not ok then
                print("[ERROR] " .. name .. ": " .. tostring(err))
                return false
            end
        end

        print("[ROLEPLAY] Modulo iniciado: " .. name)
    end

    Bootstrap.started = true

    print("[ROLEPLAY] Todos los modulos iniciados.")

    return true
end

return Bootstrap

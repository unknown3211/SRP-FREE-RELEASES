RPC.register("np-beekeeping:installHive", function(pSrc,pCoords, pHeading)
    local timestamp = os.time()
    local installHive = Await(SQL.execute("INSERT INTO _beehives (coords, heading, timestamp) VALUES (@coords, @heading, @timestamp)", {
        ['@coords'] = json.encode(pCoords),
        ['@heading'] = pHeading,
        ['@timestamp'] = timestamp
    }))
    print('installHive.insertId',installHive.insertId)
    if installHive.affectedRows then
        TriggerClientEvent("np-beekeeping:trigger_zone", -1, 2, {
            id = installHive.insertId,
            coords = pCoords,
            heading = pHeading,
            has_queen = 'false',
            last_harvest = 0,
            timestamp = timestamp
        })
    end
    return true
end)

RPC.register("np-beekeeping:addQueen", function(pSrc,pID)
    local execute = Await(SQL.execute("UPDATE _beehives SET has_queen = @has_queen WHERE id = @id", {
        ["@has_queen"] = 'true',
        ["@id"] = pID
    }))
    if execute.affectedRows >= 0 then
        local dataQueen = Await(SQL.execute("SELECT * FROM _beehives WHERE id = ?", {pID}))
        local coords = json.decode(dataQueen[1].coords)
        dataQueen[1].coords = vector3(coords.x, coords.y, coords.z)
        TriggerClientEvent("np-beekeeping:trigger_zone", -1, 3, dataQueen[1])
    end
    return true
end)


RPC.register("np-beekeeping:removeHive", function(pSrc,pData, pIsReady)
    Await(SQL.execute("DELETE FROM _beehives WHERE id = ?", {tonumber(pData.id)} ))
    TriggerClientEvent("np-beekeeping:trigger_zone", -1, 4, pData)
    return true
end)

RPC.register("np-beekeeping:harvestHive", function(source,pID)
    local chance = math.random()
    if HiveConfig.QueenChance > chance then
        TriggerClientEvent("player:receiveItem", source, "beequeen", 1)
    end

    TriggerClientEvent("player:receiveItem", source, "beeswax", 1)
    TriggerClientEvent("player:receiveItem", source, "honey", 3)
    
    local execute = Await(SQL.execute("UPDATE _beehives SET last_harvest = ? WHERE id = ?", {os.time(), pID} ))
    
    if execute.affectedRows > 0 then
        local dataHive = Await(SQL.execute("SELECT * FROM _beehives WHERE id = ?", {pID}))

        local coords = json.decode(dataHive[1].coords)
        dataHive[1].coords = vector3(coords.x, coords.y, coords.z)
        if ((os.time() - dataHive[1].timestamp) / 60) >= HiveConfig.LifeTime then
            Await(SQL.execute("DELETE FROM _beehives WHERE id = ?", {pID} ))

            TriggerClientEvent("np-beekeeping:trigger_zone", -1, 4, dataHive[1])
        else
            TriggerClientEvent("np-beekeeping:trigger_zone", -1, 3, dataHive[1])
        end
        return true
    end
end)

RPC.register("np-beekeeping:getBeehives", function()
    local retrievehives = Await(SQL.execute("SELECT * FROM _beehives"))
    for k, v in pairs(retrievehives) do
        local coords = json.decode(v.coords)
        local getX = coords.x
        local getY = coords.y
        local getZ = coords.z
        v.coords = vector3(getX, getY, getZ)
    end
    TriggerClientEvent("np-beekeeping:trigger_zone", -1, 1, retrievehives)
    return true
end)
Config = {}

-- list of houses with entrance coordinates and interior coordinates
-- you can add as many as you want
Config.Houses = {
    {
        entrance = vec3(349.0, -1003.0, 29.0),
        interior = vec4(266.0, -1007.0, -101.0, 0.0)
    },
    {
        entrance = vec3(340.0, -1005.0, 29.0),
        interior = vec4(266.0, -1007.0, -101.0, 0.0)
    }
}

-- 6 loot spots inside the house interior
Config.LootSpots = {
    vec3(263.1, -1004.7, -99.0),
    vec3(263.5, -998.1, -99.0),
    vec3(260.6, -998.5, -99.0),
    vec3(259.0, -1003.5, -99.0),
    vec3(259.1, -1007.4, -99.0),
    vec3(261.3, -1008.8, -99.0)
}

-- possible loot rewards
Config.LootItems = {
    {type = 'money', account = 'cash', min = 50, max = 150},
    {type = 'item', name = 'lockpick', min = 1, max = 1},
    {type = 'item', name = 'rolex', min = 1, max = 2}
}

-- duration of the search progress bar (in ms)
Config.SearchDuration = 5000

-- noise meter settings
Config.NoisePerSearch = 20  -- amount of noise added when searching a spot
Config.NoiseThreshold = 100 -- noise limit that will alert police

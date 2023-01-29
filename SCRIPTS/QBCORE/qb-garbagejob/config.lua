Config = {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'

Config.Vehicle = 'trash2'

-- Price taken and given back when delivered a truck
Config.TruckPrice = 250

-- Want to give out a cryptostick per stop?
Config.GiveCryptoStick = false

-- Has to roll this number or higher to receive a cryptostick
Config.CryptoStickChance = 10

-- How many stops minimum should the job roll?
Config.MinStops = 1

-- Upper worth per bag
Config.BagUpperWorth = 100

-- Lower worth per bag
Config.BagLowerWorth = 50

-- Minimum bags per stop
Config.MinBagsPerStop = 2

-- Maximum bags per stop
Config.MaxBagsPerStop = 5

-- WIP: Do not use
-- If you want to use custom routes instead of random amount of stops stops set to true
Config.UsePreconfiguredRoutes = true

Config.Peds = {
    {
        model = 's_m_y_garbage',
        coords = vector4(-354.23, -1546.3, 26.72, 273.77),
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0
        }
    }
}

Config.Locations = {
    ["main"] = {
        label = "Garbage Depot",
        coords = vector3(-334.81, -1564.88, 24.94),
    },
    ["vehicle"] = {
        label = "Garbage Truck Storage",
        coords = { -- parking spot locations to spawn garbage
            [1] = vector4(-335.04, -1564.7, 24.94, 58.06),
        },
    },
    ["paycheck"] = {
        label = "Payslip Collection",
        coords = vector3(-354.32, -1546.29, 27.72),
    },
    ["trashcan"] ={
        [1] = {
            name = "forumdrive",
            coords = vector4(-168.07, -1662.8, 33.31, 137.5),
        },
        [2] = {
            name = "grovestreet",
            coords = vector4(118.06, -1943.96, 20.43, 179.5),
        },
        [3] = {
            name = "jamestownstreet",
            coords = vector4(297.94, -2018.26, 20.49, 119.5),
        },
    },
}
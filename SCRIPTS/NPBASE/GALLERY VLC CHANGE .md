 1- Add Gallery Mlo
 2- Add To np-jobs\client\cl_gallery.lua -- PASTE THE FOLLOWING

 RegisterNetEvent('gallery:change:ipl')
AddEventHandler('gallery:change:ipl', function()
    local galleryData = {		
		{
            title = "Gallery",
            description = "Choose Interior",
            key = "EVENTS.GALLERY",
			children = {
				{ title = "Fight Night", action = "gallery:interior:change:fight", key = "EVENTS.INTERIOR", icon = "brush" },
				{ title = "Car Display", action = "gallery:interior:change:car", key = "EVENTS.INTERIOR", icon = "brush" },
                { title = "Function Room", action = "gallery:interior:change:empty", key = "EVENTS.INTERIOR", icon = "brush" },
            },
        },
    }
    exports["np-interface"]:showContextMenu(galleryData)
end)

RegisterInterfaceCallback("gallery:interior:change:fight", function(data, cb)	
    cb({ data = {}, meta = { ok = true, message = '' } })    
	TriggerEvent('gallery:change:fight')	
end)

RegisterInterfaceCallback("gallery:interior:change:car", function(data, cb)	
    cb({ data = {}, meta = { ok = true, message = '' } })    
	TriggerEvent('gallery:change:car')		
end)

RegisterInterfaceCallback("gallery:interior:change:empty", function(data, cb)	
    cb({ data = {}, meta = { ok = true, message = '' } })    
	TriggerEvent('gallery:change:empty')			
end)

RegisterNetEvent('gallery:change:fight')
AddEventHandler('gallery:change:fight', function()    
    RequestIpl("nutt_auction_milo_")
  local interiorid = GetInteriorAtCoords(-477.4793, 45.12653, 52.25219)       
  EnableInteriorProp(interiorid, "fight_night")
  DisableInteriorProp(interiorid, "car_auction")
  RefreshInterior(interiorid)   
end)

RegisterNetEvent('gallery:change:car')
AddEventHandler('gallery:change:car', function()
    RequestIpl("nutt_auction_milo_")
  local interiorid = GetInteriorAtCoords(-477.4793, 45.12653, 52.25219)     
  EnableInteriorProp(interiorid, "car_auction")
  DisableInteriorProp(interiorid, "fight_night")    
  RefreshInterior(interiorid)
end)

RegisterNetEvent('gallery:change:empty')
AddEventHandler('gallery:change:empty', function()
    local interiorid = GetInteriorAtCoords(-477.4793, 45.12653, 52.25219)
  DisableInteriorProp(interiorid, "car_auction")
  DisableInteriorProp(interiorid, "fight_night") 
  RefreshInterior(interiorid)
end)
---------------------------------------------------------------------------------------

3- Add To np-interact\client\entries\cl_npcs.lua ---- Put Anywhere

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
      {
          id = "galleryinteriorcars",
          label = "Enable Auction Stand",
          icon = "circle",
          event = "np-gallery:interiorSwap",
          parameters = { "cars" },
      },
      {
          id = "galleryinteriorfights",
          label = "Enable Fight Ring",
          icon = "circle",
          event = "np-gallery:interiorSwap",
          parameters = { "fights" },
      },
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"gallery_interior_swap"}
  }
}
------------------------------------------------------------------------------------------

4- Add To np-interact\client\cl_init.lua

exports["np-polytarget"]:AddBoxZone("gallery_ipl_scene", vector3(-471.65, 49.23, 52.41), 1.8, 1.8, {
		heading=0,
		minZ=51.41,
		maxZ=53.81
	})
------------------------------------------------------------------------------------------


The End Fully Working Gallery Ipl Chnager (vlc, car display, function room)

ENJOY!! =)

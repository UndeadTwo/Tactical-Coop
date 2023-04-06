AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "client/cl_hud.lua" )

AddCSLuaFile( "shared/pl_tactical.lua" )
AddCSLuaFile( "shared/pl_breacher.lua" )


include( "shared.lua" )

include( "server/sv_revival.lua" )

function GM:PlayerInitialSpawn(player, transition)
	player_manager.SetPlayerClass(player, "player_tactical")
end
DEFINE_BASECLASS( "player_default" )
 
 local PLAYER = {} 
 
 --
 -- See gamemodes/base/player_class/player_default.lua for all overridable variables
 --
 PLAYER.WalkSpeed = 175
 PLAYER.RunSpeed  = 350
 
 
 function PLAYER:Loadout()
 	self.Player:RemoveAllAmmo()

 	self.Player:GiveAmmo(135, "SMG1", true)
 	self.Player:Give("weapon_smg1", true)
 
    self.Player:GiveAmmo(24, "Shotgun", true)
    self.Player:Give("weapon_shotgun", true)

    self.Player:GiveAmmo(3, "Grenade", true)
    self.Player:Give("weapon_grenade", true)
 end
 
 player_manager.RegisterClass( "player_breacher", PLAYER, "player_default" )
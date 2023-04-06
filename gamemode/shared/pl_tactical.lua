DEFINE_BASECLASS( "player_default" )
 
local PLAYER = {} 

PLAYER.DisplayName        = "Default Class"
PLAYER.WalkSpeed = 200
PLAYER.RunSpeed  = 400
PLAYER.CrouchedWalkSpeed   = 0.3    -- Multiply move speed by this when crouching
PLAYER.DuckSpeed        = 0.3    -- How fast to go from not ducking, to ducking
PLAYER.UnDuckSpeed         = 0.3    -- How fast to go from ducking, to not ducking
PLAYER.JumpPower        = 200    -- How powerful our jump should be
PLAYER.CanUseFlashlight    = true      -- Can we use the flashlight
PLAYER.MaxHealth        = 100    -- Max health we can have
PLAYER.MaxArmor            = 100    -- Max armor we can have
PLAYER.StartHealth         = 100    -- How much health we start with
PLAYER.StartArmor       = 0         -- How much armour we start with
PLAYER.DropWeaponOnDie     = false     -- Do we drop our weapon when we die
PLAYER.TeammateNoCollide   = true      -- Do we collide with teammates or run straight through them
PLAYER.AvoidPlayers        = true      -- Automatically swerves around other players
PLAYER.UseVMHands       = true      -- Uses viewmodel hands

function PLAYER:SetupDataTables()
    self.Player:NetworkVar( 'Vector', 0, 'RespawnPosition')
    self.Player:NetworkVar( 'Bool', 0, 'Revived' )
end

function PLAYER:Init()
end

function PLAYER:Spawn()
    if(self.Player:GetRespawnPosition() ~= Vector(0, 0, 0))then
        self.Player:SetPos(self.Player:GetRespawnPosition())
    end
end

function PLAYER:Loadout()
    self.Player:RemoveAllAmmo()

    self.Player:GiveAmmo(135, "SMG1", true)
    self.Player:Give("weapon_smg1", true)

    self.Player:GiveAmmo(144, "Pistol", true)
    self.Player:Give("weapon_pistol", true)
end

function PLAYER:SetModel()
   local cl_playermodel = self.Player:GetInfo( "cl_playermodel" )
   local modelname = player_manager.TranslatePlayerModel( cl_playermodel )
   util.PrecacheModel( modelname )
   self.Player:SetModel( modelname )
end

function PLAYER:Death( inflictor, attacker )
    local navarea = navmesh.GetNearestNavArea(self.Player:GetPos(), false, 1024, false, true, TEAM_ANY)
    self.Player:SetRespawnPosition( navarea:GetClosestPointOnArea(self.Player:GetPos()) )

    local body = ents.Create( "tco_player_body" )
    body:SetPos( navarea:GetClosestPointOnArea( self.Player:GetPos() ) )
    body:Spawn()
    body:SetPlayer(self.Player)
end

-- Clientside only
function PLAYER:CalcView( view ) end      -- Setup the player's view
function PLAYER:CreateMove( cmd ) end     -- Creates the user command on the client
function PLAYER:ShouldDrawLocal() end     -- Return true if we should draw the local player

-- Shared
function PLAYER:StartMove( cmd, mv ) end  -- Copies from the user command to the move
function PLAYER:Move( mv ) end            -- Runs the move (can run multiple times for the same client)
function PLAYER:FinishMove( mv ) end      -- Copy the results of the move back to the Player

function PLAYER:ViewModelChanged( vm, old, new )
end

function PLAYER:PreDrawViewModel( vm, weapon )
end

function PLAYER:PostDrawViewModel( vm, weapon )
end

function PLAYER:GetHandsModel()
    return { model = "models/weapons/c_arms_cstrike.mdl", skin = 1, body = "0100000" }
end
 
player_manager.RegisterClass( "player_tactical", PLAYER, "player_default" )
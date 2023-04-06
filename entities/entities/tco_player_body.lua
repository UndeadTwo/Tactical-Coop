AddCSLuaFile()

ENT.Type = "anim"
ENT.AutomaticFrameAdvance  = true

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "FinishTime")
	self:NetworkVar("Bool", 0, "IsUsing")
	self:NetworkVar("Bool", 1, "WasUsing")
	self:NetworkVar("Entity", 0, "Player")
end

function ENT:Initialize()
	self:SetFinishTime(0)
	self:SetIsUsing(false)
	self:SetWasUsing(false)
	self:SetModel("models/player/monk.mdl")
	
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
end

function ENT:Spawn()
	self:SetSequence("zombie_slump_idle_01")
end

function ENT:Use( activator, caller, useType, value )
	if( activator:IsPlayer() )then
		self:SetIsUsing(true)

		if(not self:GetWasUsing())then
			self:SetFinishTime(CurTime() + 4.0)
		end
	end
end

function ENT:Think()
	if(CurTime() > self:GetFinishTime())then
		self:GetPlayer():Revive()
	end

	self:NextThink( CurTime() )
	return true
end
local plyMeta = FindMetaTable('Player')

function plyMeta:Revive()
    self:SetRevived(true)
end

function GM:PlayerInitialSpawn(ply)

end

function GM:PlayerDeathThink(ply)
	return ply:GetRevived()
end

function GM:Respawn()

end
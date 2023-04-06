hook.Add("HUDPaint", "HUDPaint_DrawTeamIndicators", function()
	local players = player.GetAll()
	table.RemoveByValue(players, LocalPlayer())

	for i = 1, #players do
		surface.SetDrawColor( healthGradient( players[i]:Health(), players[i]:GetMaxHealth() ) )
		surface.DrawRect( 50 * i, ScrH() - 50, 40, 40 )

		local angle = math.atan2( LocalPlayer():EyePos().y - players[i]:EyePos().y,
			LocalPlayer():EyePos().x - players[i]:EyePos().x )

		drawArrow( 50 * i + 20, ScrH() - 50 + 20, math.rad(LocalPlayer():EyeAngles().y) - angle + math.pi/2 )

		draw.DrawText(string.Right( players[i]:GetName(), 6 ), "BudgetLabel", 50 * i + 5, ScrH() - 25)
	end
end)

COLOR_HEALTH_HALE = Color(0, 255, 0)
COLOR_HEALTH_HURT = Color(128, 128, 0)
COLOR_HEALTH_DEAD = Color(50, 0, 0)

function healthGradient( health, healthMax )
	local t = math.Clamp(health / healthMax, 0.0, 1.0)

	if(t < 0.5)then
		return Lerp( 1.0 - t * 2.0, COLOR_HEALTH_HURT:ToVector(), COLOR_HEALTH_DEAD:ToVector() ):ToColor()
	elseif(t >= 0.5)then
		return Lerp( 1.0 - (t - 0.5) * 2.0, COLOR_HEALTH_HALE:ToVector(), COLOR_HEALTH_HURT:ToVector() ):ToColor()
	end
end

function drawArrow( offsetX, offsetY, angle )
	surface.SetDrawColor( 255, 255, 255, 255 )
	
	local legL = angle - math.pi / 4
	local legR = angle + math.pi / 4

	local tipX, tipY = math.cos( angle ) * 20, math.sin( angle ) * 20
	local legLX, legLY = math.cos( legL ) * 11, math.sin( legL ) * 11
	local legRX, legRY = math.cos( legR ) * 11, math.sin( legR ) * 11

	-- surface.DrawLine(offsetX, offsetY, offsetX + tipX, offsetY + tipY)


	-- print(offsetX + legLX, offsetY + legLY, offsetX + tipX, offsetY + tipY, offsetX + legRX, offsetY + legRY)
	-- print(offsetX, offsetY, offsetX + tipX, offsetY + tipY)

	draw.NoTexture()
	surface.DrawPoly( {
		{x=offsetX + legLX, y=offsetY + legLY, u=0.0, v=0.0},
		{x=offsetX + tipX, y=offsetY + tipY, u=0.5, v=1.0},
		{x=offsetX + legRX, y=offsetY + legRY, u=1.0, v=0.0}
	} )
end
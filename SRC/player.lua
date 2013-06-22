
function player_load()
		player = {
		x = 0,
		y = 0,
		y_velocity = 0,
	}
end

function player_draw()
	love.graphics.rectangle("fill", 20, 50, 60, 120 )
end
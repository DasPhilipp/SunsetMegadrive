require "player"

function love.load()
	local devmode = true
	console = "Console: "
	love.graphics.setBackgroundColor(255,255,255)

	gamestate = "menu"

	pic = {
			logo = love.graphics.newImage("/img/logo.png")
		}

	if gamestate == "playing" then
		player_load()
	end	
end


function love.update(dt)
	
end

function love.keypressed(key, unicode)
	if key == "escape" then
		love.event.push("quit")
	end
	if key == "return" then
		gamestate = "playing"
	end
	if devmode == true then
		if unicode > 31 and unicode < 127 then
        	console = console .. string.char(unicode)
    	end
    end
end


function love.draw()
	if gamestate == "menu" then 
		love.graphics.draw(pic.logo, 60, 125)
	end

	if gamestate == "playing" then
		love.graphics.setBackgroundColor(0,0,0)
		player_draw()
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("fill", 0, 580, 800, 20)
	end
if devmode == true then
		love.graphics.setColor(255,255,255)
		love.graphics.printf(console, 0, 0, 800)
	end
	
end
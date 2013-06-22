require "player"
require "menu"

function love.load()
	devmode = true
	devcon = false
	love.graphics.setBackgroundColor(255,255,255)

	console = "Console: "

	gamestate = "menu"

	pic = {
			logo = love.graphics.newImage("/img/logo.png"),
			console = love.graphics.newImage("/img/console.png")
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

	if key == "return" and
		gamestate == "menu" then
			gamestate = "playing"
	end

	-- Dev-Console
	if devmode == true and
		gamestate == "playing" and
			key == "c" and
				devcon == false then
					devcon = true
	elseif devcon == true then
			devcon = false
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
		love.graphics.setBackgroundColor(0,0, 0)
		player_draw()
	end

	if gamestate == "playing" and
		devcon == true then
			love.graphics.draw(pic.console, 0, 0)
	end
	if gamestate == "playing" and
			devcon == false then
				love.graphics.clear()
	end
	
end
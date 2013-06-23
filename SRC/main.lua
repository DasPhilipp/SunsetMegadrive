require "player"
require "menu"

function love.load()
	devmode = true
	devcon = false
	love.graphics.setBackgroundColor(255,255,255)

	console = "Console: "

	gamestate = "menu"

	img = {
			logo = love.graphics.newImage("/img/logo.png"),
			console = love.graphics.newImage("/img/console.png")
	}

	-- initiate player values unso
	
	p = player:new()

	p.x = 300
	p.y = 300
	p.width = 20
	p.height = 20
	p.jumpSpeed = -800
	p.runSpeed = 500
	p.pic = love.graphics.newImage("/img/playa.png")

	gravity = 1800

	yFloor = 500
end


function love.update(dt)
	if gamestate == "playing" then
		if love.keyboard.isDown("d") then
			p:moveRight()
		end
		if love.keyboard.isDown("a") then 
			p:moveLeft()
		end
		if love.keyboard.isDown("space") then
			p:jump()
		end
		p:update(dt, gravity)

		if p.x > 800 - p.width then p.x = 800 - p.width end
		if p.x < 0 then p.x = 0 end
		if p.y < 0 then p.y = 0 end
		if p.y > yFloor - p.height then
			p:hitFloor(yFloor)
		end
	end
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
		love.graphics.draw(img.logo, 60, 125)
	end

	-- ingame
	if gamestate == "playing" then
		local x = math.floor(p.x)
		local y = math.floor(p.y)
		love.graphics.setBackgroundColor(0,0,0)
		player_draw()

		love.graphics.setColor(25,200,25)
		love.graphics.rectangle("fill", 0, yFloor, 800, 100)

		love.graphics.setColor(255,255,255)

	end

	if gamestate == "playing" and
		devcon == true then
			love.graphics.draw(img.console, 0, 0)
	end
end


function love.keyreleased(key)
	if gamestate == "playing" then
		if (key == "d") or (key == "a") then
			p:stop()
		end
	end
end


function love.load()
	playerColor = {255, 0, 128}
	groundColor = {25, 200, 25}

	-- initiate Playa stuffz
	require "Player"
	p = Player:new()

	p.x = 300
	p.y = 300
	p.width = 25
	p.height = 40
	p.jumpSpeed = -800
	p.runSpeed = 500

	gravity = 1800

	yFloor = 300
end

function love.update(dt)

	if love.keyboard.isDown("d") then
		p:moveRight()
	end
	if love.keyboard.isDown("a") then
		p:moveLeft()
	end

	if love.keyboard.isDown(" ") then
		p:jump()
	end

	-- update playaz pos
	p:update(dt, gravity)

	if p.x > 800 - p.width then p.x = 800 - p.width end
	if p.x < 0 then p.x = 0 end
	if p.y < 0 then p.y = 0 end
	if p.y > yFloor - p.height then
		p:hitFloor(yFloor)
	end
end

function love.draw()

	local x = math.floor(p.x)
	local y = math.floor(p.y)

	love.graphics.setColor(playerColor)
	love.graphics.rectangle("fill", x, y, p.width, p.height)

	-- grund drawen
	love.graphics.setColor(groundColor)
	love.graphics.rectangle("fill", 0, yFloor, 800, 100)

	-- debug
	love.graphics.setColor(255,255,255)
	love.graphics.print("Player coordinates: ("..x..","..y..")", 5, 5)
	love.graphics.print("Current state: "..p.state, 5, 20)

end


function love.keyreleased(key)
	if key == "escape" then
		love.event.push("quit")
	end
	if (key == "a") or (key == "d") then
		p:stop()
	end
end

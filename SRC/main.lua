require "player/player"
require "player/SpriteAnimation"
--require "camera"

function love.load()
	playerColor = {255, 0, 128}
	groundColor = {25, 200, 25}

	-- initiate Playa stuffz
	p = Player:new()

	p.x = 300
	p.y = 300
	p.width = 40
	p.height = 64
	p.jumpSpeed = -800
	p.airSpeed = -400
	p.runSpeed = 0
	p.fallSpeed = -300
	p.maxSpeed = 500

	p.acc = 300

	gravity = 1800

	yFloor = 400

	-- Player Animation

	delay = 120

	animation = SpriteAnimation:new("player/test.png", 64, 64, 9, 2)
	animation:load(delay)
end

function love.update(dt)

	if love.keyboard.isDown("d") then
		p:moveRight()
		animation:flip(false,false)
	end
	if love.keyboard.isDown("a") then
		p:moveLeft()
		animation:flip(true, false)
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


	if (p.state == "stand") then
        animation:switch(1, 1, 200)
    end
    if (p.state == "moveRight") or (p.state == "moveLeft") then
        animation:switch(2, 8, 120)
    end

    animation:update(dt)
end

function love.draw()

	local x, y = math.floor(p.x), math.floor(p.y)

	love.graphics.setColor(255,255,255)
	animation:draw(x, y)

	-- grund drawen
	love.graphics.setColor(groundColor)
	love.graphics.rectangle("fill", 0, yFloor, 800, 50)

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


function love.keypressed(key)
	if key == "a" then
		if p.xSpeed < p.maxSpeed then
			p.xSpeed = p.xSpeed - p.acc
		end
	end
end

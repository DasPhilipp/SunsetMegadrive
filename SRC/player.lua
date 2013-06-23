player = {}

function player:new()
	local object = {
	x = 0,
	y = 0,
	width = 0,
	height = 0,
	xSpeed = 0,
	ySpeed = 0,
	state = "",
	jumpSpeed = 0,
	runSpeed = 0,
	canJump = false,
	pic = love.graphics.newImage("/img/playa.png")
	}
	setmetatable(object, {__index = player })
	return object
end


-- Movement
function player:jump()
	if self.canJump then
		self.ySpeed = self.jumpSpeed
		self.canJump = false
	end
end

function player:moveRight()
	self.xSpeed = self.runSpeed
	self.state = "moveRight"
end

function player:moveLeft()
	self.xSpeed = -1 * (self.runSpeed)
	self.state = "moveLeft"
end

function player:stop()
	self.xSpeed = 0
end

function player:hitFloor(maxY)
	self.y = maxY - self.height
	self.ySpeed = 0
	self.canJump = true
end


-- Updates n Stuff
function player:update(dt, gravity)
	-- update Player position
	self.x = self.x + (self.xSpeed * dt)
	self.y = self.y + (self.ySpeed * dt)

	-- gravity
	self.ySpeed = self.ySpeed + (gravity * dt)

	-- update player state
	if not (self.canJump) then
		if self.ySpeed < 0 then
			self.state = "jump"
		elseif self.ySpeed > 0 then
			self.state = "fall"
		end
	else
		if self.xSpeed > 0 then
			self.state = "moveRight"
		elseif self.xSpeed < 0 then
			self.state = "moveLeft"
		else
			self.state = "stand"	
		end
	end
end

function player_draw()
	love.graphics.draw(p.pic, x, y)
end
-- Player class
-- Author: Sean Laurvick
-- A simple Player object for use in the Platformer game.

Player = {}

-- Constructor
function Player:new()
    -- define our parameters here
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
    fallSpeed = 0,
    airSpeed = 0,
    acc = 0,
    maxSpeed = 0,
    canJump = false
    }
    setmetatable(object, { __index = Player })
    return object
end

-- Movement functions
function Player:jump()
    if self.canJump then
        self.ySpeed = self.jumpSpeed
        self.canJump = false
    end
end

function Player:moveRight()
    if self.state == "stand" and
        self.xSpeed < self.maxSpeed then
                self.xSpeed = self.runSpeed + self.acc
    elseif self.state == "jump" then
        self.xSpeed = -1 * (self.airSpeed)
    elseif self.state == "fall" then
        self.xSpeed = -1 * (self.fallSpeed)
    end
end

function Player:moveLeft()
    if self.state == "stand" and
        self.xSpeed < self.maxSpeed then
                self.xSpeed = -1 * (self.xSpeed) - self.acc
    elseif self.state == "jump" then
        self.xSpeed = (self.airSpeed)
    elseif self.state == "fall" then
        self.xSpeed = self.fallSpeed
    end
end

-- fuer wall jump
--[[
    self.xSpeed = -1 * (self.runSpeed)
    if self.state == "jump" then
        self.xSpeed = -1 * (self.jumpSpeed)
    end
]]
function Player:stop()
    self.xSpeed = 0
end

function Player:hitFloor(maxY)
    self.y = maxY - self.height
    self.ySpeed = 0
    self.canJump = true
end

-- Update function
function Player:update(dt, gravity)
    -- update the player's position
    self.x = self.x + (self.xSpeed * dt)
    self.y = self.y + (self.ySpeed * dt)
    
    -- apply gravity
    self.ySpeed = self.ySpeed + (gravity * dt)

    -- update the player's state
    if not(self.canJump) then
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


ui = {}

function ui:new(uiT)
	local obejct = {
		x = 0,
		y = 0, 
		typ = "",
		width = 0,
		height = 0
	}

	setmetatable(object, { __index = ui })
	return object
	
end

function console_draw()

	love.graphics.draw(pic.console, 0, 0)
	love.graphics.setColor(255,255,255)
	love.graphics.printf(console, 0, 0, 800)

end


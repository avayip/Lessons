--[[

Lesson 1 : Hello

]]

-- This is a comment line, not code and will not be executed
-- Comment begins with two -
-- Comment is useful for telling human what the code is doing, but ignored by the machine

--[[
This is a comment block, surrounded by two - followed by two [ and ends with two ]
Comment block is useful for multi-line comments
]]


-- this is the load function and will be called only once when program starts
function love.load()
	-- load a picture named "hello-my-name-is.jpg" into variable called background
	background = love.graphics.newImage("hello-my-name-is.jpg")

	-- set the windows size to match picture width and height
	love.window.setMode(background:getWidth(), background:getHeight())
end

-- this is the draw function and will be called many times until the program ends
function love.draw()
	-- set color to white
    love.graphics.setColor(255, 255, 255, 255)

	-- draw our background
	love.graphics.draw(background, 0, 0)

	-- set color to red
    love.graphics.setColor(255, 0, 0, 255)

	-- set font to new font with size 20
	love.graphics.setFont(love.graphics.newFont(20))

	-- print name in middle of screen
    love.graphics.printf("Your Name Here", 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
end

--[[
  _______           _   _     _
 |__   __|         | | | |   (_)
    | |_ __ _   _  | |_| |__  _ ___
    | | '__| | | | | __| '_ \| / __|
    | | |  | |_| | | |_| | | | \__ \
    |_|_|   \__, |  \__|_| |_|_|___/
             __/ |
            |___/

1. Make it print your real name.

2. Make your name bigger.

3. Change the color of your name.

4. Change background color.

]]

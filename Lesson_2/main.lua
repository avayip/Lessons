--[[

Lesson 2 : Move the ball

]]

-- this is the load function and will be called only once when program starts
function love.load()
	-- get the screen width and height for later
	screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

	-- load new image "blue-ball.jpg" into variable ballImage
	ballImage = love.graphics.newImage("blue-ball.jpg")

	-- successImg is set to nil (nil means nothing or not defined); we will load it later
	successImg = nil

	-- x and y variables store the cooridinates on where we want to draw the ball later
	x, y = 0, 0
end

-- this is the draw function and will be called many times until the program ends
function love.draw()
	-- make the background color white
	love.graphics.setBackgroundColor(255, 255, 255, 255)

	-- set color to white
    love.graphics.setColor(255, 255, 255, 255)

	-- draw ballImage at (x, y), see love.load() function where we initialized x and y variables
	love.graphics.draw(ballImage, x, y)

	-- draw successImg if we have it
	if successImg then
		love.graphics.draw(successImg, 0, 0, 0,    -- this is a multi-line statment
			screenWidth/successImg:getWidth(),     -- multi-line statments are useful for breaking
			screenHeight/successImg:getHeight())   -- up long lines to make it more readable
	end
end

-- this is the update function and will be called before draw function is called
function love.update()
	-- only execute code between 'then' and 'end' when the left arrow key is pressed
	if love.keyboard.isDown("left") then
		-- move the ball to the left by making x smaller by 1 step
		x = x - 1
	end

	-- test to see if right arrow key is press then do something
	if love.keyboard.isDown("right") then
		-- move the ball to the right by making x bigger by 1 step
		x = x + 1
	end

	-- see if down arrow key is pressed
	if love.keyboard.isDown("down") then
		-- what to do here?

	end

	-- see if up arrow key is pressed
	if love.keyboard.isDown("up") then
		-- what to do here?

	end

	-- what does this code do?
	if x > screenWidth/2 and y > screenHeight/2 then
		successImg = love.graphics.newImage("success_kid.jpg")
	end
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

1. Move the ball down by making y variable bigger when down arrow key is pressed.

2. Move the ball up by making y variable smaller when up arrow key is pressed.

3. The ball is moving too slowly. Make it go faster.

4. Move the ball to the lower right corner.

]]

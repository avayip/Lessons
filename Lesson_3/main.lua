--[[

Lesson 3 :

]]

gui = require("gui")

result = 0.0
enteredNumber = 0.0

function calculatorButtonClicked(btn)
	if btn.id == "0" or btn.id == "1" or btn.id == "2" or btn.id == "3" or
	   btn.id == "4" or btn.id == "5" or btn.id == "6" or btn.id == "7" or
	   btn.id == "8" or btn.id == "9"
	then
		enteredNumber = enteredNumber..btn.id
	elseif btn.id == '+' then
	elseif btn.id == '-' then
	elseif btn.id == '*' then
	elseif btn.id == '/' then
	end
end

local function createCalculatorButtons(startX, startY)
	local loc = {x = startX, y = startY}
	local size = {w = (screenWidth - startX)/4, h = (screenHeight - startY)/4}
	local textColor = {0, 0, 0, 255}
	local buttonImage = love.graphics.newImage("metal-button.jpg")
    local buttonFont = love.graphics.newFont(20)

	local layout = {
		{{text="7"},{text="8"},{text="9"},{text="/"}},
		{{text="4"},{text="5"},{text="6"},{text="*"}},
		{{text="1"},{text="2"},{text="3"},{text="-"}},
		{{text="0", span=2},{text="."},{text="+"}}
	}

	for _, row in ipairs(layout) do
		loc.x = startX
		for _, button in ipairs(row) do
			local span = button.span or 1
			gui.newButton{
				id = button.id or button.text,
				text = button.text,
				font = buttonFont,
				x = loc.x, y = loc.y,
				w = size.w*span, h = size.h,
				normalImage = buttonImage,
				color = textColor,
				onClick = calculatorButtonClicked
			}
			loc.x = loc.x + size.w*span
		end
		loc.y = loc.y + size.h
	end
end

local function drawResult()
	love.graphics.setColor(20,20,20,100)
	love.graphics.rectangle("fill", 2, 2, screenWidth - 4, screenHeight/5 - 4)
	love.graphics.setColor(255,255,255,255)
	love.graphics.setFont(resultFont)
	love.graphics.printf(result, 12, 2, screenWidth - 24, "right")
end

-- this is the load function and will be called only once when program starts
function love.load()
	-- get the screen width and height for later
	screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

	createCalculatorButtons(2, screenHeight/5)

	resultFont = love.graphics.newFont(70)
	result = 0.0
end

-- this is the draw function and will be called many times until the program ends
function love.draw()
	-- make the background color white
	love.graphics.setBackgroundColor(255, 255, 255, 255)
	gui.draw()
	drawResult()
end

-- this is the update function and will be called before draw function is called
function love.update()
end

function love.mousereleased(x, y, btn)
	gui.mousereleased(x, y, btn)
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


]]


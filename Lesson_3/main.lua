--[[

Lesson 3 : Calculator

]]

--[[
GUI stands for Graphical User Interface
The following line make code written by other people avaliable for us to use here.
Code written by other people offten grouped into libraries or modules. For example, "gui" is a module.
When you see code begin with "gui.somefunction", it is using code in the gui module.
]]
gui = require("gui")

-- expression holds math expressoin we want to show in the calculator screen
expression = ""

-- answer holds the answer of math expression
answer = "0.0"

-- addToExpression function appends user input to expression
function addToExpression(str)
	expression = expression .. str
end

-- This function is called when a button is clicked by user
-- The parameter btn tells us which button is clicked
function calculatorButtonClicked(btn)
	-- btn.id has the ID or label we assigned to the button in createCalculatorButtons function
	print(btn.id.." key pressed")

	-- clear out the expression display once when clearExpression is true
	if clearExpression then
		expression = ""

		-- reset clearExpression to false so it won't affect the next button click
		clearExpression = false
	end

	if btn.id == "C" then
		-- C button is pressed, clear out the expression

	elseif btn.id == "Ans" then
		-- Ans button is pressed, add answer to expression
		addToExpression("answer")

	elseif btn.id == "Del" then
		-- Del button is pressed, remove the last character from expression
		expression = expression:sub(1, -2)

	elseif btn.id == "=" then
		-- = button is pressed, calculate the answer
		local eval = loadstring(string.format("return %s", expression))
		if eval then
			answer = eval()
			if answer == nil then
				answer = "Error"
			end
		else
			answer = "Error"
		end

		-- set clearExpression to true so we will clear out the expression
		--clearExpression = true

	elseif btn.id >= "0" and btn.id <= "5" then
		-- one of the number key is pressed, add the key to expression
		addToExpression(btn.id)

	elseif btn.id == "+" or btn.id == "-" or btn.id == "*" or btn.id == "/" then
		addToExpression(btn.id)

	end
end

local function createCalculatorButtons(startX, startY)
	local loc = {x = startX, y = startY}
	local size = {w = (screenWidth - startX)/5, h = (screenHeight - startY)/5}
	local textColor = {0, 0, 0, 255}
	local buttonImage = love.graphics.newImage("metal-button.jpg")
    local buttonFont = love.graphics.newFont(20)

	local layout = {
		{{label="C"},{label="Ans"},{label="("},{label=")"},{label="Del"}},
		{{label="7"},{label="8"},{label="9"},{label="*"},{label="/"}},
		{{label="4"},{label="5"},{label="6"},{label="+"},{label="-"}},
		{{label="1"},{label="2"},{label="3"},{label="=",vspan=2,hspan=2}},
		{{label="0", hspan=2},{label="."},{vspan=0},{vspan=0}}
	}

	for _, row in ipairs(layout) do
		loc.x = startX
		for _, button in ipairs(row) do
			local hspan = button.hspan or 1
			local vspan = button.vspan or 1
			if hspan > 0 and vspan > 0 then
				gui.newButton{
					id = button.id or button.label,
					text = button.label,
					font = buttonFont,
					x = loc.x, y = loc.y,
					w = size.w*hspan, h = size.h*vspan,
					normalImage = buttonImage,
					imageColor = {255,255,255,200},
					color = textColor,
					onClick = calculatorButtonClicked
				}
			end
			loc.x = loc.x + size.w*hspan
		end
		loc.y = loc.y + size.h
	end
end

local function drawDisplay()
	love.graphics.setColor(20,20,20,100)
	love.graphics.rectangle("fill", 2, 2, screenWidth - 4, screenHeight/5 - 4)
	love.graphics.setColor(255,255,255,255)
	love.graphics.setFont(expressionFont)
	love.graphics.printf(expression, 12, 4, screenWidth - 24, "right")
	love.graphics.setFont(answerFont)
	love.graphics.printf(tostring(answer):sub(1, 15), 12, 35, screenWidth - 24, "right")
end

-- this is the load function and will be called only once when program starts
function love.load()
	-- get the screen width and height for later
	screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

	createCalculatorButtons(2, screenHeight/5)

	expressionFont = love.graphics.newFont(20)
	answerFont = love.graphics.newFont(30)
	result = 0.0
end

-- this is the draw function and will be called many times until the program ends
function love.draw()
	-- make the background color white
	love.graphics.setBackgroundColor(255, 255, 255, 255)
	gui.draw()
	drawDisplay()
end

-- love.mousereleased function is called whenever a muse button is pressed than released
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

1. Click the buttons 1 + 2 =
   Did you get the answer 3?
   After you clicked the = button the math expression was not cleared, so any subsequence button
   you click simply get appended to the end. That's not what we want. Can you fix it?

2. If you made an mistake, you can use the C button to clear out the input.
   The C button does work as it supposed to. Please fix it.

3. Try calculating 5 + 5.
   Got the answer 10? Good. Now try 5 + 6.
   The 6 key doesn't work? Fix it!

4. Fix the ( and ) buttons.

]]


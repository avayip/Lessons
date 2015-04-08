--[[

Lesson 4 : Super Calculator

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

-- x and y variables
x = 0.0
y = 0.0

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
		expression = ""

	elseif btn.id == "Ans" then
		-- Ans button is pressed, add answer to expression
		addToExpression("answer")

	elseif btn.id == "Del" then
		-- Del button is pressed, remove the last character from expression
		expression = expression:sub(1, -2)

	elseif btn.id == "=" then
		-- = button is pressed, calculate the answer
		local eval = loadstring(string.format("return %s", expression))
		answer = (eval and eval()) or "Error"

		-- set clearExpression to true so we will clear out the expression
		clearExpression = true

	-- ############################################################# --
	-- Problem 3 solution
	elseif btn.id == "x=" then
		if answer ~= "Error" then
			x = answer
		end
	-- ############################################################# --

	elseif btn.id == "y=" then
		if answer ~= "Error" then
			y = answer
		end

	elseif btn.id == "1/x" then
		if expression ~= "" then
			expression = string.format("rcp(%s)", expression)
		elseif answer ~= "Error" then
			answer = rcp(answer)
		end
	else
		addToExpression(btn.id)
	end
end

-- ############################################################# --
-- Problem 5 solution
-- Make the rpc function return 1/num
-- ############################################################# --
-- Problem 6 solution
-- Check divide by zero
-- ############################################################# --
function rcp(num)
	if num == 0 then
		return "Error"
	end
	return 1/num
end

local function createCalculatorButtons(startX, startY)
	local buttonImage = love.graphics.newImage("metal-button.jpg")
    local buttonFont = love.graphics.newFont(20)
	local imageColor = {255,255,255,200}
	local textColor = {0, 0, 0, 255}

	local b = function(label, hspan, vspan)
		return {
			maker = gui.newButton,
			init = {
				id = label,
				text = label,
				font = buttonFont,
				normalImage = buttonImage,
				imageColor = imageColor,
				color = textColor,
				onClick = calculatorButtonClicked
			},
			hspan = hspan,
			vspan = vspan
		}
	end

	-- ############################################################# --
	-- Problem 2 solution
	-- ------------------------------------------------------------
	-- Add a row to the table as shown below
	-- ############################################################# --
	local buttonLayout = {
		{b("C"),b("Ans"),b("("),b(")"),b("Del")},
		{b("x="),b("x"),b("y="),b("y"),b("1/x")}, -- <-- Problem 2 solution
		{b("7"),b("8"),b("9"),b("*"),b("/")},
		{b("4"),b("5"),b("6"),b("+"),b("-")},
		{b("1"),b("2"),b("3"),b("=", 2, 2)},
		{b("0", 2),b("."),{},{}}
	}

	local numberPad = gui.Grid:new{
		id = "numPad",
		x = startX,
		y = startY,
		w = screenWidth - startX*2,
		h = screenHeight - startY,
		layout = buttonLayout
	}
	gui.add(numberPad)
end

-- this is the load function and will be called only once when program starts
function love.load()
	-- get the screen width and height for later
	screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

	createCalculatorButtons(2, screenHeight/5)

	statusFont = love.graphics.newFont(10)
	expressionFont = love.graphics.newFont(25)
	answerFont = love.graphics.newFont(30)
	result = 0.0
end

local function drawDisplay()
	love.graphics.setColor(20,20,20,100)
	love.graphics.rectangle("fill", 2, 2, screenWidth - 4, screenHeight/5 - 4)
	love.graphics.setColor(255,255,255,255)

	local status = {}
	if x then
		status[#status + 1] = string.format("x=%s", x)
	end
	if y then
		status[#status + 1] = string.format("y=%s", y)
	end

	love.graphics.setFont(statusFont)
	love.graphics.printf(table.concat(status, " "), 2, 4, screenWidth - 24, "left")

	love.graphics.setFont(expressionFont)
	love.graphics.printf(expression, 12, 10, screenWidth - 24, "right")

	love.graphics.setFont(answerFont)
	love.graphics.printf(tostring(answer):sub(1, 15), 12, 35, screenWidth - 24, "right")
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

1. Learn how to use the search function of your code eidtor and use it to search for "you found me" in this file.
   How many did you find?

2. Create buttons "x=", "x", "y=", "y", and "1/x" in the 2nd row.
   After you're done, you should have 5 buttons in the 2nd row just above the "7", "8", "9", "*", "/" row.
   See instructions for Problem 2 in createCalculatorButtons function. Hint, search for "Problem 2" in this file.

3. The button "x=" is supposed to save current answer to variable x and the "x" button is used to recall the value.
   For example, if you click "1", "+", "2", "=" than "x=", you should get the answer 3 and x variable has value 3.
   After stored 3 in variable, click "2", "*", "x", "=" should you give you result of 2*x which is 2*3 or 6.
   Search for "Problem 3"

4. The button "y=" and "y" should work the same way as "x=" and "x" in problem 3
   See instructions for problem 3

5. The button "1/x" is called reciprocal button. When pressed, it calls the rpc function and gets the reciprocal.
   Search for "Problem 5"

6. Try pressing "0" and "1/x"
   Did you get an error?

]]


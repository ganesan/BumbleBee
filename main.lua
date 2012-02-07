display.setStatusBar( display.HiddenStatusBar )

local director = require("director")
local mainGroup = display.newGroup()

local function main()
	local super = require("_main")
	local this = super:newMain()
	mainGroup:insert(director.directorView)
	director:changeScene("menu")	
	return true
end

main()
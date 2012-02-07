
-- _main.lua 2011-04-01T01:28:58.087-07:00

-- This class is generated code. Please do not modify.
-- See main.lua instead.

module(..., package.seeall)

local imagelookup = require("_imagelookup")
local animlookup = require("_animlookup")
local physics = require("physics")

display.setStatusBar(display.HiddenStatusBar)

physics.start()

physics.setGravity(0, 0)

function newMain ()
	local this = display.newGroup()
	
	return this
end


-- longlevel1.lua 2011-03-22T23:53:42.575-07:00

-- Stub class for _longlevel1.lua. All modifications will be preserved.

module(..., package.seeall)
local physics = require("physics")
local imagelookup = require("_imagelookup")
local ui = require("ui")
local game
local appsperseAd
local native = require("native")

local function queryAdListener( event )
	if( event.hasAd ) then
		print ("Ad filled")
	end
end

local shakeListener = function( event )
	print("shake")
        if event.isShake then
			appsperseAd = require("Appsperse")
			appsperseAd.showPromotion(queryAdListener, nil, nil, nil)
		end
		
end
Runtime:addEventListener( "accelerometer", shakeListener )

function new ()
	local super = require("_longlevel1")
	local this = super:newLongLevel1()
	
	this.bee.collisionCommand = "bee"
	this.coin1.collisionCommand = "coin"
	this.coin1.points = 10
	this.coin2.collisionCommand = "coin"
	this.coin2.points = 10
	this.coin3.collisionCommand = "coin"
	this.coin3.points = 10
	
	game = require("GameMechanics")
	game.configLevel(this.bee, this, -1800)
	
	appsperseAd = require("Appsperse")
	appsperseAd.init("577951021d0143c09d46696e5282e947", queryAdListener)
	appsperseAd.show(queryAdListener)
	
	return this
end


-- longlevel1.lua 2011-03-22T23:53:42.575-07:00

-- Stub class for _longlevel1.lua. All modifications will be preserved.

module(..., package.seeall)
local physics = require("physics")
local imagelookup = require("_imagelookup")
local ui = require("ui")
local game
local native = require("native")

local function queryAdListener( event )
	if( event.hasAd ) then
		print ("Ad filled")
	end
	if nil ~= string.find( event.eventType, "didReceiveResponse" ) then
		print ("The system received a network response from the ad network")
		--native.setActivityIndicator( false );
	end
	if nil ~= string.find( event.eventType, "responseError" ) then
		print ("There was a network problem")
		--native.setActivityIndicator( false );
	end
	if nil ~= string.find( event.eventType, "willRequestAd" ) then
		print ("About to send a network request for an ad")
		--native.setActivityIndicator( true );
	end
	if nil ~= string.find( event.eventType, "adShowing" ) then
		print ("The ad is showing")
	end
	if nil ~= string.find( event.eventType, "adStartShowing" ) then
		print ("The ad is going to show")
	end
	if nil ~= string.find( event.eventType, "adShowingError" ) then
		print ("There was an error showing the ad")
	end
	if nil ~= string.find( event.eventType, "adTap" ) then
		print ("The user tapped the ad")
	end
	if nil ~= string.find( event.eventType, "adClose" ) then
		print ("The user closed the ad")
	end
end

appsperseAd = require("Appsperse")
appsperseAd.init("577951021d0143c09d46696e5282e947", queryAdListener)

local shakeListener = function( event )
	print("shake")
        if event.isShake then
			appsperseAd.show()
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
	
	return this
end

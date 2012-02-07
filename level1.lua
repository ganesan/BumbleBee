
-- level1.lua 2011-03-18T17:01:54.24-07:00

-- Stub class for _level1.lua. All modifications will be preserved.

module(..., package.seeall)

local bee
local speed = 1
local direction = 0
local wall
local wall2
local wall3
local wall4
local thisGroup

function new ()
	local super = require("_level1")
	local this = super:newLevel1()
	bee = this.thumbBee_6
	wall = this.wall
	wall2 = this.wall2
	wall3 = this.wall3
	wall4 = this.wall4
	bee.xReference = 5;
	bee.yReference = 5;
	bee.collision = onLocalCollision
	bee:addEventListener( "collision", wall )
	bee:addEventListener( "collision", wall2 )
	bee:addEventListener( "collision", wall3 )
	bee:addEventListener( "collision", wall4 )
	thisGroup = this
	return this
end

local function animate(event)
	--print(bee.rotation)
	--print(math.cos(math.rad(bee.rotation)))
	--print(math.sin(math.rad(bee.rotation)))
	--bee.x = bee.x + math.cos(math.rad(bee.rotation))*speed;
	--bee.y = bee.y + math.sin(math.rad(bee.rotation))*speed;	
	thisGroup.x = thisGroup.x-0.5;
end

local function onTouch(event)
	if(event.phase == "began") then
		--print( "otherTouch: event(" .. event.phase .. ") ("..event.x..","..event.y..")" .. tostring(event.id) )
		if(event.x <= 240) then
			direction = direction - 90;
		end
		if(event.x > 240) then
			direction = direction + 90;
		end
	end
	
	if(event.phase == "began") then
		local rotateParameters = { rotation = direction, time=5, delta=false }
		transition.to( bee, rotateParameters )
	end
end

local function onLocalCollision( self, event )
	print( self.myName .. ": collision began with " .. event.other.myName )
	if ( event.phase == "began" ) then

		print( self.myName .. ": collision began with " .. event.other.myName )

	elseif ( event.phase == "ended" ) then

		print( self.myName .. ": collision ended with " .. event.other.myName )

	end
end

local function onGlobalCollision( event )
	
	print( "**** " .. event.element1 .. " -- " .. event.element2 )
	
end

--Runtime:addEventListener( "collision", onGlobalCollision )

--bee.collision = onLocalCollision
--bee:addEventListener( "collision", wall )
--bee:addEventListener( "collision", wall2 )
--bee:addEventListener( "collision", wall3 )
--bee:addEventListener( "collision", wall4 )

Runtime:addEventListener( "enterFrame", animate );
Runtime:addEventListener( "touch", onTouch )
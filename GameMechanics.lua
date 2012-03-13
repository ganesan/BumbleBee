module(..., package.seeall)
local physics = require("physics")
local moveGroup
local speed = 0
local imagelookup = require("_imagelookup")
local score = require("score")
local ui = require("ui")
local bee
local life1
local life2
local verticalDelta = 0
local verticalSpeed = 1
local lives
local staticGroup = display.newGroup()
-- state = 0 Ready to start
-- state = 1 Playing
-- state = 2 Paused
-- state = 3 Level Passed Detected
-- state = 4 Level Passed Stop
-- state = 99 Level Failed
local state = 0
-- Stop Screen From Diming
system.setIdleTimer( false )

-- Setup Corona Remote
local remote = require ("remote")
remote.startServer( "8080" )
local startingAngle
local finishX
--local gameData = require("GameData")

local function setupLives()
	life1 = display.newImageRect(imagelookup.table["ThumbBee"],imagelookup.table["ThumbBeeWidth"],imagelookup.table["ThumbBeeHeight"])
	life1.x, life1.y = 10, 10
	life1.xScale = 0.4
	life1.yScale = 0.4
	life1.isVisible = true
	
	staticGroup:insert(life1)
	
	life2 = display.newImageRect(imagelookup.table["ThumbBee"],imagelookup.table["ThumbBeeWidth"],imagelookup.table["ThumbBeeHeight"])
	life2.x, life2.y = 25, 10
	life2.xScale = 0.4
	life2.yScale = 0.4
	life2.isVisible = true
	
	staticGroup:insert(life2)
	
	lives = {life1, life2}

end

local messageLabel = ui.newLabel{
	bounds = { 10, 55, 300, 40 },
	text = "Tap the screen to start!",
	font = "AmericanTypewriter-Bold",
	textColor = { 255, 255, 255, 255 },
	size = 18,
	align = "center"
}

messageLabel.x = 100
messageLabel.y = 80

local gameOverLabel = ui.newLabel{
	bounds = { 10, 55, 300, 40 },
	text = "Level Failed! Touch screen to retry",
	font = "AmericanTypewriter-Bold",
	textColor = { 255, 255, 255, 255 },
	size = 18,
	align = "center"
}
gameOverLabel.x = 100
gameOverLabel.y = 80
gameOverLabel.alpha = 0

local pausedLabel = ui.newLabel{
	bounds = { 10, 55, 300, 40 },
	text = "Bee resting. Touch to screen to continue",
	font = "AmericanTypewriter-Bold",
	textColor = { 255, 255, 255, 255 },
	size = 18,
	align = "center"
}
pausedLabel.x = 100
pausedLabel.y = 80
pausedLabel.alpha = 0

local levelPassedLabel = ui.newLabel{
	bounds = { 10, 55, 300, 40 },
	text = "Level Complete! Touch screen to continue",
	font = "AmericanTypewriter-Bold",
	textColor = { 255, 255, 255, 255 },
	size = 18,
	align = "center"
}
levelPassedLabel.x = 100
levelPassedLabel.y = 80
levelPassedLabel.alpha = 0

local function animate(event)
	if(moveGroup.x > finishX)	then
		moveGroup.x = moveGroup.x-speed;
		bee.x = bee.x + speed;
	else
		state = 3;
	end
	if(state == 1) then
		local a2 = math.deg(math.atan2(remote.zGravity, remote.xGravity))
		if(a2 < 0) then
			a2 = 180 + (a2 + 180)
		end
		local delta = a2 - startingAngle
		if(delta < -10) then
			delta = -10
		elseif(delta > 10) then
			delta = 10
		end
		bee.y = 160 - 16*delta
		--transition.to( bee, { time=10, y=(160 - 16*delta) })
	end
	if(state == 3) then
		levelPassedLabel.alpha = 1
		state = 4
	end
end

local function moveBeeAgain ( event )
	speed = 0
	state = 0
	messageLabel.alpha =1
end

local function restartBee ( event )
	verticalDelta = 0
	bee.x = 41
	bee.y = 140
	if(state == 1) then
		staticGroup:remove(table.remove(lives))
	end
	transition.to(bee, {alpha=1, time=1000, delta=false, onComplete=moveBeeAgain})
end

local function restartLevel( event )
	if(table.maxn(lives) == 0) then
		state = 99
		gameOverLabel.alpha = 1
		return
	end
	transition.to(moveGroup, {x=0, time=1000, delta=false, onComplete=restartBee})
end

local function doCollision( object )
	if(object.collisionCommand == "coin") then
		moveGroup:remove(object)
		score.setScore(score.getScore()+object.points)
	end
	if(object.collisionCommand == "stop") then
		print("bubble")
		--object:removeSelf()
		object.isBodyActive = false
		speed = 0
		verticalDelta = 0
		state = 2
		pausedLabel.alpha = 1
	end
end

local function onGlobalCollision( event )
	print("onGlobalCollision")
	if(event.phase == "began") then
		if(event.object1.collisionCommand ~= nil) then
			if(event.object1.collisionCommand ~= "bee") then
				doCollision(event.object1)
				return
			end
		end
		if(event.object2.collisionCommand ~= nil) then
			if(event.object2.collisionCommand ~= "bee") then
				doCollision(event.object2)
				return
			end
		end
		if(state == 1 and speed > 0) then
			transition.to(bee, {alpha=0, time=1000, delta=false, onComplete=restartLevel})
		end
		speed = 0
		verticalDelta = 0
	end
end

local function onTouch(event)
	if(event.phase == "began") then
		if(state == 0) then
			messageLabel.alpha = 0
			speed = 2
			state = 1
			startingAngle = math.deg(math.atan2(remote.zGravity, remote.xGravity))
			if(startingAngle < 0) then
				startingAngle = 180 + (startingAngle + 180)
			end
			print(startingAngle)
			return
		end
		if(state == 99) then
			setupLives()
			gameOverLabel.alpha = 0
			transition.to(moveGroup, {x=0, time=1000, delta=false, onComplete=restartBee})
			return
		end
		if(state == 2) then
			pausedLabel.alpha = 0
			speed = 2
			state = 1
			return
		end
		if(state == 4) then
			Runtime:removeEventListener( "collision", onGlobalCollision);

			Runtime:removeEventListener( "enterFrame", animate );
			Runtime:removeEventListener( "touch", onTouch );
			levelPassedLabel.alpha = 0
			director:changeScene("menu")
		end
	end
	
end

function configLevel(levelBee , levelMoveGroup, levelEndX)
	bee = levelBee
	moveGroup = levelMoveGroup
    finishX = levelEndX
	--gameData.loadData()
	score.init({
	x = 390,
	y = 5}
	)
	score.setScore(0)
	
	setupLives()
	
	Runtime:addEventListener( "collision", onGlobalCollision);

	Runtime:addEventListener( "enterFrame", animate );
	Runtime:addEventListener( "touch", onTouch );
end

-- _longlevel1.lua 2011-04-01T01:28:58.087-07:00

-- This class is generated code. Please do not modify.
-- See longlevel1.lua instead.

module(..., package.seeall)

local imagelookup = require("_imagelookup")
local animlookup = require("_animlookup")
local physics = require("physics")

function newLongLevel1 ()
	local this = display.newGroup()
	
	local thumbBackground01_4 = display.newImageRect(imagelookup.table["ThumbBackground01"],imagelookup.table["ThumbBackground01Width"],imagelookup.table["ThumbBackground01Height"])
	thumbBackground01_4.x, thumbBackground01_4.y = 240, 161.08749999999998
	thumbBackground01_4.xScale = 3.2
	thumbBackground01_4.yScale = 2.857142857142857
	thumbBackground01_4.isVisible = true
	
	this:insert(thumbBackground01_4)
	this.thumbBackground01_4 = thumbBackground01_4
	
	local thumbBackground04_3 = display.newImageRect(imagelookup.table["ThumbBackground04"],imagelookup.table["ThumbBackground04Width"],imagelookup.table["ThumbBackground04Height"])
	thumbBackground04_3.x, thumbBackground04_3.y = 718.5083333333333, 161.39166666666665
	thumbBackground04_3.xScale = 3.2
	thumbBackground04_3.yScale = 2.857142857142857
	thumbBackground04_3.isVisible = true
	
	this:insert(thumbBackground04_3)
	this.thumbBackground04_3 = thumbBackground04_3
	
	local thumbBackground05_1 = display.newImageRect(imagelookup.table["ThumbBackground05"],imagelookup.table["ThumbBackground05Width"],imagelookup.table["ThumbBackground05Height"])
	thumbBackground05_1.x, thumbBackground05_1.y = 1193.5333333333335, 161.3291666666667
	thumbBackground05_1.xScale = 3.2
	thumbBackground05_1.yScale = 2.857142857142857
	thumbBackground05_1.isVisible = true
	
	this:insert(thumbBackground05_1)
	this.thumbBackground05_1 = thumbBackground05_1
	
	local thumbBackground03_1 = display.newImageRect(imagelookup.table["ThumbBackground03"],imagelookup.table["ThumbBackground03Width"],imagelookup.table["ThumbBackground03Height"])
	thumbBackground03_1.x, thumbBackground03_1.y = 1672.2708333333333, 161.16666666666674
	thumbBackground03_1.xScale = 3.2
	thumbBackground03_1.yScale = 2.857142857142857
	thumbBackground03_1.isVisible = true
	
	this:insert(thumbBackground03_1)
	this.thumbBackground03_1 = thumbBackground03_1
	
	local thumbBackground02_3 = display.newImageRect(imagelookup.table["ThumbBackground02"],imagelookup.table["ThumbBackground02Width"],imagelookup.table["ThumbBackground02Height"])
	thumbBackground02_3.x, thumbBackground02_3.y = 2156.045833333333, 160.03749999999997
	thumbBackground02_3.xScale = 1.028472222222221
	thumbBackground02_3.yScale = 1
	thumbBackground02_3.isVisible = true
	
	this:insert(thumbBackground02_3)
	this.thumbBackground02_3 = thumbBackground02_3
	
	local wall_7 = display.newImageRect(imagelookup.table["Wall"],imagelookup.table["WallWidth"],imagelookup.table["WallHeight"])
	wall_7.x, wall_7.y = 229.825, 141.2625
	wall_7.xScale = 0.9375
	wall_7.yScale = 0.939000000000001
	wall_7.isVisible = true
	
	physics.addBody(wall_7, "static", {density = 1.0, friction = 0.3, bounce = 0.2})
	
	this:insert(wall_7)
	this.wall_7 = wall_7
	
	local wall_8 = display.newImageRect(imagelookup.table["Wall"],imagelookup.table["WallWidth"],imagelookup.table["WallHeight"])
	wall_8.x, wall_8.y = 607.25, 203.75
	wall_8.xScale = 1
	wall_8.yScale = 1
	wall_8.isVisible = true
	
	physics.addBody(wall_8, "static", {density = 1.0, friction = 0.3, bounce = 0.2})
	
	this:insert(wall_8)
	this.wall_8 = wall_8
	
	local wall_9 = display.newImageRect(imagelookup.table["Wall"],imagelookup.table["WallWidth"],imagelookup.table["WallHeight"])
	wall_9.x, wall_9.y = 827.25, 88.75
	wall_9.xScale = 1
	wall_9.yScale = 1
	wall_9.isVisible = true
	
	physics.addBody(wall_9, "static", {density = 1.0, friction = 0.3, bounce = 0.2})
	
	this:insert(wall_9)
	this.wall_9 = wall_9
	
	local wall_10 = display.newImageRect(imagelookup.table["Wall"],imagelookup.table["WallWidth"],imagelookup.table["WallHeight"])
	wall_10.x, wall_10.y = 1249.75, 50
	wall_10.xScale = 1
	wall_10.yScale = 1
	wall_10.isVisible = true
	
	physics.addBody(wall_10, "static", {density = 1.0, friction = 0.3, bounce = 0.2})
	
	this:insert(wall_10)
	this.wall_10 = wall_10
	
	local wall_11 = display.newImageRect(imagelookup.table["Wall"],imagelookup.table["WallWidth"],imagelookup.table["WallHeight"])
	wall_11.x, wall_11.y = 1251, 228.74999999999994
	wall_11.xScale = 1
	wall_11.yScale = 1
	wall_11.isVisible = true
	
	physics.addBody(wall_11, "static", {density = 1.0, friction = 0.3, bounce = 0.2})
	
	this:insert(wall_11)
	this.wall_11 = wall_11
	
	local wall_12 = display.newImageRect(imagelookup.table["Wall"],imagelookup.table["WallWidth"],imagelookup.table["WallHeight"])
	wall_12.x, wall_12.y = 1648.5625, 82.5
	wall_12.xScale = 15.46875
	wall_12.yScale = 1
	wall_12.isVisible = true
	
	physics.addBody(wall_12, "static", {density = 1.0, friction = 0.3, bounce = 0.2})
	
	this:insert(wall_12)
	this.wall_12 = wall_12
	
	local wall_13 = display.newImageRect(imagelookup.table["Wall"],imagelookup.table["WallWidth"],imagelookup.table["WallHeight"])
	wall_13.x, wall_13.y = 2184.75, 137.5
	wall_13.xScale = 1
	wall_13.yScale = 1
	wall_13.isVisible = true
	
	physics.addBody(wall_13, "static", {density = 1.0, friction = 0.3, bounce = 0.2})
	
	this:insert(wall_13)
	this.wall_13 = wall_13
	
	local bee = display.newImageRect(imagelookup.table["ThumbBee"],imagelookup.table["ThumbBeeWidth"],imagelookup.table["ThumbBeeHeight"])
	bee.x, bee.y = 41, 140.2
	bee.xScale = 0.6
	bee.yScale = 0.6
	bee.isVisible = true
	
	physics.addBody(bee, "dynamic", {density = 1.0, friction = 0.3, bounce = 0.2})
	
	this:insert(bee)
	this.bee = bee
	
	local coin1 = display.newImageRect(imagelookup.table["Monster"],imagelookup.table["MonsterWidth"],imagelookup.table["MonsterHeight"])
	coin1.x, coin1.y = 421.1, 105.75
	coin1.xScale = 1.367521367521367
	coin1.yScale = 1.3675213675213669
	coin1.isVisible = true
	
	physics.addBody(coin1, "static", {density = 1.0, friction = 0.3, bounce = 0.2})
	
	this:insert(coin1)
	this.coin1 = coin1
	
	local coin2 = display.newImageRect(imagelookup.table["Monster"],imagelookup.table["MonsterWidth"],imagelookup.table["MonsterHeight"])
	coin2.x, coin2.y = 725.55, 212.4
	coin2.xScale = 1.3675213675213627
	coin2.yScale = 1.3675213675213627
	coin2.isVisible = true
	
	physics.addBody(coin2, "static", {density = 1.0, friction = 0.3, bounce = 0.2})
	
	this:insert(coin2)
	this.coin2 = coin2
	
	local coin3 = display.newImageRect(imagelookup.table["Monster"],imagelookup.table["MonsterWidth"],imagelookup.table["MonsterHeight"])
	coin3.x, coin3.y = 970, 135.75
	coin3.xScale = 1.3296296296296286
	coin3.yScale = 1.3296296296296286
	coin3.isVisible = true
	
	physics.addBody(coin3, "static", {density = 1.0, friction = 0.3, bounce = 0.2})
	
	this:insert(coin3)
	this.coin3 = coin3
	
	local bubble = display.newImageRect(imagelookup.table["ThumbBubble"],imagelookup.table["ThumbBubbleWidth"],imagelookup.table["ThumbBubbleHeight"])
	bubble.x, bubble.y = 1142.2166666666667, 136.82777777777778
	bubble.xScale = 0.3844444444444442
	bubble.yScale = 0.3844444444444442
	bubble.isVisible = true
	
	physics.addBody(bubble, "static", {density = 1.0, friction = 0, bounce = 0})
	
	this:insert(bubble)
	this.bubble = bubble
	
	return this
end

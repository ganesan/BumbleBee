module(..., package.seeall)

-- Main function - MUST return a display.newGroup()
function new()
	local ui = require("ui")
	
	local localGroup = display.newGroup()
	
	-- Background
	local background = display.newImage("thumb_Background02.png")

	localGroup:insert(background)
	
	-- Menu Buttons - Start

  local playButton = nil
  local function onPlay ( event )
    if event.phase == "release" and playButton.isActive then
      director:changeScene("longlevel1")
    end
  end	
  playButton = ui.newButton{
		defaultSrc = "images/btn-play.png",
		defaultX = 160,
		defaultY = 32,		
		overSrc = "images/btn-play-over.png",
		overX = 160,
		overY = 32,		
		onEvent = onPlay,
		id = "playButton",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		emboss = false
	}
	playButton.x = 160
	playButton.y = 80
	playButton.isActive = true
	localGroup:insert(playButton)
  

  
					
	unloadMe = function()
	end
						
	-- MUST return a display.newGroup()
	return localGroup
end

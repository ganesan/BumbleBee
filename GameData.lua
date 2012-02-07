
-- Load external libraries
local str = require("str")


-- Set location for saved data
local filePath = system.pathForFile( "GamedData.txt", system.DocumentsDirectory )


function saveData(newGameTable)
	
	--local levelseq = table.concat( levelArray, "-" )

	file = io.open( filePath, "wb" )
	
	for k,v in pairs( newGameTable ) do
		file:write( k .. "=" .. v .. "," )
	end
	
	io.close( file )
end



function loadData()	
	local file = io.open( filePath, "r" )
	
	if file then

		-- Read file contents into a string
		local dataStr = file:read( "*a" )
		
		-- Break string into separate variables and construct new table from resulting data
		local datavars = str.split(dataStr, ",")
		
		local gameTable = {}
		
		for i = 1, #datavars do
			-- split each name/value pair
			local onevalue = str.split(datavars[i], "=")
			gameTable[onevalue[1]] = tonumber(onevalue[2])
		end
	
		io.close( file ) -- important!

	
	else
		local gameTable = {}
		gameTable.score = 0
		gameTable.lives = 3
		gameTable.level = 1
	end
	return gameTable
end
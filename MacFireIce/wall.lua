--wall



local wall = {}
local wall_mt = {__index=wall} -- prep for metatable-based oop
local sheet_runningWall = nil

local sw = 49
local sh = 703
local fr = 1
local scw = 49
local sch = 703

local sequenceData = {
{ name="seq1", sheet=sheet_runningWall, start=1, count=1, time=220, loopCount=0 }
}


local sheetWallOptions =
	{
	    width = 24,
	    height = 24,
	    numFrames = 7
	}


function wall:new(parms) 
	
	print (parms.ssWidth)
	sheetWallOptions.width = parms.ssWidth
	sheetWallOptions.height = parms.ssHeight
	sheetWallOptions.numFrames = parms.ssNumFrames
	print("width .."..parms.ssWidth)
	print("height .."..parms.ssHeight)
	print("img .."..parms.img)
	
	sheet_runningWall  = graphics.newImageSheet( IMG_DIR..parms.img, sheetWallOptions )
	  local instance = {}
	  setmetatable(instance,wall_mt) -- now instance is a wall

	  wallCnt = wallCnt + 1
	  instance.name = "wall"..wallCnt
	  instance.sheet_runningWall = sheet_runningWall
	  
	  instance.lastX = parms.x
	  instance.lastY = parms.y
	  
	  instance.display = display.newSprite( sheet_runningWall, sequenceData)
	  instance.display.name = instance.name
	  if parms.doPhysics ==true then
		timer.performWithDelay(1, function() physics.addBody(instance.display, "static" ) end, 1)
	  	--timer.performWithDelay(1, physics.addBody( instance.display, "static" ))
	 	else
	 		print("no physics")
	  end
	  

	instance.display:setSequence("seq")
	instance.display:play()
		instance.display.x = parms.x
		
		instance.display.y = parms.y
		
	instance.display.isFixedRotation = false 
		
	
    return instance
end

return wall








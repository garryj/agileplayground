--platform



local platform = {}
local platform_mt = {__index=platform} -- prep for metatable-based oop
local sheet_runningPlatform = nil

local sheetPlatformOptions =
	{
	    width = 170,
	    height = 48,
	    numFrames = 8
	}
local sequences_platform = {
		
	{name = "moveRight",
	        start = 1,
	        count = 8,
	        time = 800,
	        loopCount = 0,
	        loopDirection = "forward"}

	}


sheet_runningPlatform  = graphics.newImageSheet( IMG_DIR.."MovingPlatformSpriteSheet.png", sheetPlatformOptions )

function platform:new(parms) 
	
	local x = parms.x
	local y = parms.y
	local isVisible = parms.isVisible

  local instance = {}
  setmetatable(instance,platform_mt) -- now instance is a Platform
  --instance.view = display.newImage("player.png", ..whatever..) -- and "owns" a display object
  plCnt = plCnt + 1
  instance.name = "platform"..plCnt
  instance.sheet_runningPlatform = sheet_runningPlatform
  instance.speed = 2
  instance.direction = 0
  instance.lastX = x
  instance.lastY = y
  instance.offScreenX = 6000
  instance.display = display.newSprite( sheet_runningPlatform, sequences_platform )
  instance.display.name = instance.name
  
  

  instance.display:setSequence("moveRight")
  instance.display:play()
	instance.display.x = x
	print ("y..."..y)
	instance.display.y = y
	
	-- hide off screen
	if isVisible == false then
  	
  		instance.display.isVisible = false
		--instance.display.isSensor = true
		
  	end

	instance.display.isFixedRotation = false  
	if parms.doPhysics ==true then
		--physics.addBody( instance.display, "static" )
		print ("Adding platform physics") 
 
		timer.performWithDelay(1, function() physics.addBody(instance.display, "static" ) end, 1)
	end 
	moveable[instance.name] = instance  
    return instance
end

return platform








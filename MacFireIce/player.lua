--PLAYER
local player = {}

local sheet_runningPlayer = nil




function doSpin() 
	player.runningPlayerAnim.rotation = player.runningPlayerAnim.rotation +10
 	spins = spins + 1
 	--print ("Spins .."..spins) 
 	if spins >=100 then
 		Runtime:removeEventListener( "enterFrame", doSpin)
 		game:over()
 	end
end



--300 x 174
local sheetPlayerOptions =
	{
	    width = 80,
	    height = 139,
	    numFrames = 3
	}
	
local sheetShrinkPlayerOptions =
	{
	    width = 60,
	    height = 104,
	    numFrames = 3
	}
	

	local sequences_player = {
		
	{name = "shimmy",
	        start = 1,
	        count = 3,
	        time = 800,
	        loopCount = 0,
	        loopDirection = "forward"}

	}

function player.reset()
	print ("player reset start")
	player.x = pw /2
	player.y = 300
	player.runningPlayerAnim.x = player.x 
	player.runningPlayerAnim.y = player.y
	player.runningPlayerAnim.rotation = 0 
	print ("player reset end")
end
function player.start() 
	spins = 0
	return player.create()
end


function player.setAlive(bl)
	alive  = bl
end

function player.isAlive()
	return alive
end

function player.die()
	print ("Killing player")
	alive = false
	print ("Alive: "..tostring(alive))
	player:spin()
	
end

function player.shrink()
	--player:shrink()
	--player:create()
	
end

function player.create() 
	sheet_runningPlayer  = graphics.newImageSheet( IMG_DIR.."fireboy_spritesheet_small.png", sheetPlayerOptions )
	player.alive = true
	player.sheet_runningPlayer = sheet_runningPlayer
	player.name = "Fire"
	player.jumping = false
	player.speed = speed
	player.x = pw /2
	player.y = ph - GROUND_HEIGHT
	player.direction = 0
	player.lastX = 0
	player.lastY = 0
	player.upright = true
	player.score = 0
	player.moving = false 

end



-- function player.shrink()
-- 	local prevX= player.runningPlayerAnim.x
-- 	local prevY = player.runningPlayerAnim.y
-- 	timer.performWithDelay(1, function() physics.removeBody(player.runningPlayerAnim) end, 1)

-- timer.performWithDelay(1, function() display.remove(player.runningPlayerAnim) end, 1)

-- timer.performWithDelay(1, function() player.runningPlayerAnim:removeSelf() end, 1)





-- 	sheet_runningPlayer  = graphics.newImageSheet( IMG_DIR.."fireboy_spritesheet_smaller.png", sheetShrinkPlayerOptions )
-- 	runningPlayerAnim = display.newSprite( sheet_runningPlayer, sequences_player )
	
	
-- 	runningPlayerAnim:setSequence("shimmy")
-- 	runningPlayerAnim:play()
-- 	runningPlayerAnim.x = prevX+30
-- 	runningPlayerAnim.y = prevY

-- 	player.runningPlayerAnim = runningPlayerAnim 
-- 	timer.performWithDelay(1, function() physics.addBody( player.runningPlayerAnim, "dynamic" ) end, 1)


-- end

function player.add()






	runningPlayerAnim = display.newSprite( sheet_runningPlayer, sequences_player )
	
	physics.addBody( runningPlayerAnim, "dynamic" )
	runningPlayerAnim:setSequence("shimmy")
	runningPlayerAnim:play()

	runningPlayerAnim.x = paw/2
	runningPlayerAnim.y = pah/2

	-- see if set by player level file
	print ("A***** ADDDING")
	if startX~=nil then
		if startX~=0 then
			print ("Setting startX")
			runningPlayerAnim.x = startX
		end

	end
	if startY~=nil then
		if startY~=0 then
			runningPlayerAnim.y = startY
		end

	end
	runningPlayerAnim.name = "Player"
	runningPlayerAnim.isFixedRotation = true
	player.runningPlayerAnim = runningPlayerAnim 
	playerCreated=true

	

end

function player.spin()
	Runtime:addEventListener( "enterFrame", doSpin)
end

function player.moveRight()
	player.moving = true
	player.direction = "right"
	runningPlayerAnim.x = runningPlayerAnim.x + player.speed
end

function player.moveLeft()
	player.moving = true
	player.direction = "left"
	runningPlayerAnim.x = runningPlayerAnim.x - player.speed
end
return player 

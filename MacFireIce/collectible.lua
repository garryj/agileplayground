--collectible new
local collectible = {}
local collectible_mt = {__index=collectible}

local nextLevelText


local sheetCollectibleOptions =
	{
	    width = 24,
	    height = 24,
	    numFrames = 7
	}
	


	local sequences_collectible = {
		
	{name = "pull",
	        start = 1,
	        count = 3,
	        time = 2200,
	        loopCount = 1,
	        loopDirection = "forward"

	},
	{name = "shimmy", 
	        start = 1,
	        count = 1,
	        time = 800,
	        loopCount = 0,
	        loopDirection = "forward"}

	}

local touchSoundOptions =
{
    channel = 3,
    loops = 1,
    duration = 2000,
    fadein = 0
}

function collectible:display()
	print ("col "..collectible_mt)
end

local function tapListener(event)
    event.target.b = false
    nextLevelText = nil
    game:newLevel()
end

function collectible:touched()
	
	print (self.name)
	audio.play(self.touchSound)
	print ("Bind:")
	print (self.bind)
	
	if self.bind ~=nil then

		if self.bindTrick ~=nil then  
				-- work out what we need
				print ("Activating "..self.bind.display.name)
				if self.bindTrick.funct =="disappear" then  
					print "make object disappear"
					sw = self.bind.display.isVisible 
					if sw then
							self.bind.display.isVisible = false
							self.bind.display.isSensor = true
							
							-- remove physics
							print ("Remove physics for "..self.bind.display.name)
							timer.performWithDelay(1, function() physics.removeBody(self.bind.display, "static" ) end, 1)
					else
							print ("Make visible") 
							self.bind.display.isVisible = true
							self.bind.display.isSensor = false  
							-- add physics
							timer.performWithDelay(1, function() physics.addBody(self.bind.display, "static" ) end, 1)
							
					end
					self.bind.display.lastX = self.bind.display.x
					self.bind.display.lastY = self.bind.display.y
					print "made object disappear"	
				
				end
				if self.bindTrick.funct =="moveRight" then 
					print ("Moving right")
					print (self.bind.display)

					--self.bind.display:setLinearVelocity( 128,    0) -- moves right
					transition.to(self.bind.display,{time=3000,x=850}) 
				end 

				if self.name=="key" then
					print ("make key disappear")
					--print (self.bind.display)
					transition.to(self.display,{time=3000,x=offScreenX})
					print (self.display.name)
					self.display.isVisible = true
				end
		end
		 
	
	end
	print (self.name)
	if string.starts(self.name,"diamond") then 
	
		transition.to(self.display,{time=3000,x=offScreenX})
	end
	-- check scoring
	if self.score ~=nil then
		score = score +self.score
		game:doHudUpdate()
	end
	if self.name=="exit" then
		levelComplete = true

		
	end
	if string.starts(self.name,"water") then
		player:die()
		
	end

	if self.bindTrick then
		if self.bindTrick.funct =="teleport" then 
		
			print (self.name)
				print ("To .."..self.bind.name)
			transition.to(self.display,{time=3000,x=offScreenX})
			player.runningPlayerAnim:toFront()
			transition.to(player.runningPlayerAnim,{time=1,x=self.bind.display.x, y =self.bind.display.y })
			 
		end
	end

	
end




function collectible:new(parms) 
	local instance = {}
	setmetatable(instance,collectible_mt) 
	instance.name = parms.name
	if parms.soundTouch ~=nil then
		instance.touchSound = audio.loadSound(SND_DIR..parms.soundTouch)
	end

	if parms.score~=nil then
		instance.score = parms.score
	end
	
	print ("Binding to ")
	print (parms.bind)
	instance.bind = parms.bind
	instance.bindTrick = parms.bindTrick
	
	print ("bind for "..instance.name.." is ")
	print (parms.bind)
	
	self.bind = parms.bind
	self.bindTrick = parms.bindTrick

	sheetCollectibleOptions.width = parms.ss_width
	sheetCollectibleOptions.height = parms.ss_height
	sheetCollectibleOptions.numFrames = parms.ss_frames
	
	if parms.sequenceOptions~=nil then
		sheetCollectibleOptions = parms.sequenceOptions
	end

	print (sheetCollectibleOptions.width)
	instance.sheet_runningCollectible  = graphics.newImageSheet( IMG_DIR..parms.img, sheetCollectibleOptions )

	if parms.sequences~=nil then
			sequences_collectible = parms.sequences
	end
	instance.display = display.newSprite( instance.sheet_runningCollectible, sequences_collectible )
	
	
	instance.display:play()
	instance.display.name = parms.name
	instance.display.x = parms.x
	instance.display.y = parms.y
	instance.display.lastX = parms.x
	instance.display.lastY = parms.y
	instance.display.isFixedRotation = true
	instance.display.obj = instance
	instance.display.bind = instance.bind

	--timer.performWithDelay( 1, physics.addBody( instance.display, parms.gravity, {isSensor = parms.sensor}) )
	if parms.doPhysics ==true then 
		print ("adding collectible "..parms.gravity.." - "..instance.display.name)
		if parms.addParms ~=nil then
			--addtional parameters
			timer.performWithDelay(1, function() physics.addBody(instance.display, parms.gravity, {isSensor = parms.sensor}, parms.addParms) end, 1)

		else
			timer.performWithDelay(1, function() physics.addBody(instance.display, parms.gravity, {isSensor = parms.sensor} ) end, 1)

		end
		
	 
	 end

	return instance
end 
return collectible
















--enemy new
local enemy = {}
local enemy_mt = {__index=enemy}


local sheetEnemyOptions =
	{
	    width = 24,
	    height = 24,
	    numFrames = 7
	}


	local sequences_enemy = {
		
	{name = "shimmy",
	        start = 1,
	        count = 7,
	        time = 800,
	        loopCount = 0,
	        loopDirection = "forward"} 

	}

function enemy:touched()
	
	print ("TOUCHED:"..self.name)
	self.display.isVisible = false
	self.display.isSensor = true
	audio.play(self.touchSound)
	-- remove physics
	if  self.display then

		timer.performWithDelay(1, function() if self.display then physics.removeBody(self.display, "static" ) end end, 1)
	end

	-- take from health
	health = health - self.damage
	print ("Health: "..health)
	local facUpdate = (health/100)
	game.updateHealth(facUpdate) 

	if health <=0 then
		health=resetHealth 
		timer.performWithDelay(1, function() game:restart() end, 1)
	end
end
 
function enemy:new(parms) 
	local instance = {}
	setmetatable(instance,enemy_mt) 
	instance.name = parms.name
	if parms.soundTouch ~=nil then
		instance.touchSound = audio.loadSound(SND_DIR..parms.soundTouch)
	end
	if parms.damage then
		self.damage = parms.damage
	end
	 
	instance.bind = parms.bind
	instance.bindTrick = parms.bindTrick
	self.bind = parms.bind
	self.bindTrick = parms.bindTrick

	sheetEnemyOptions.width = parms.ss_width
	sheetEnemyOptions.height = parms.ss_height
	sheetEnemyOptions.numFrames = parms.ss_frames

	if parms.sequences_enemy then
		sequences_enemy = parms.sequences_enemy
	end
	instance.sheet_runningEnemy  = graphics.newImageSheet( IMG_DIR..parms.img, sheetEnemyOptions )
	instance.display = display.newSprite( instance.sheet_runningEnemy, sequences_enemy)
	
	timer.performWithDelay(1, function() physics.addBody( instance.display, parms.gravity, {isSensor = parms.sensor}) end, 1)

	instance.display:play()
	instance.display.name = parms.name
	instance.display.x = parms.x
	instance.display.y = parms.y
	instance.display.lastX = parms.x
	instance.display.lastY = parms.y
	instance.display.isFixedRotation = true
	instance.display.obj = instance
	instance.display.bind = instance.bind 



	return instance
end
return enemy

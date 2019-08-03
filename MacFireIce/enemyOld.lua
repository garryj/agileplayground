--ENEMY
local enemy = {}

local sheet_runningEnemy = nil

local imgName = ""
local name = ""
local thisX = 0
local thisY = 0
local mType = "dynamic"

local attrib = {}

--300 x 174
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

function enemy.init(parms)
	attrib = parms
	print ("img name "..imgName)
	sheetEnemyOptions.width = parms.sw
	sheetEnemyOptions.height = parms.sh
	sheetEnemyOptions.numFrames = parms.frames

	
	
end
function enemy.start() 
	return enemy.create()
end

function enemy.create() 
	print (sheetEnemyOptions.width)
	print (sheetEnemyOptions.height)
	print (sheetEnemyOptions.numFrames)
	print ("img name "..imgName)
	sheet_runningEnemy  = graphics.newImageSheet( IMG_DIR..attrib.img, sheetEnemyOptions )
	
	enemy.sheet_runningEnemy = sheet_runningEnemy
	enemy.name =attrib.name
	enemy.jumping = false
	enemy.speed = 2
	
	enemy.direction = 0
	enemy.lastX = thisX
	enemy.lastY = thisY
	enemy.upright = true
	enemy.score = 0
	enemy.moving = false

end

function enemy.add()
	runningEnemyAnim = display.newSprite( sheet_runningEnemy, sequences_enemy )
	runningEnemyAnim:scale(2,2)
	physics.addBody( runningEnemyAnim, attrib.gravity)
	runningEnemyAnim:setSequence("shimmy")
	runningEnemyAnim.name = attrib.name
	runningEnemyAnim:play()
	runningEnemyAnim.x = attrib.x
	runningEnemyAnim.y = attrib.y
	
	runningEnemyAnim.name = name
	runningEnemyAnim.isFixedRotation = true
	enemy.display = runningEnemyAnim

end



return enemy 

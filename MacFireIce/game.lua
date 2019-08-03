--game
-- Background file
local game = {}
local backgroundMusicChannel= nil
local introSound = nil
local overSound = nil
local endLevelSound = nil
local levelText = nil
local myScore = nil
local levelDisplayText = nil
local levelDisplayRect = nil
local healthRect = nil
wall = require("wall")
player = require("player")
--playerMini = require("playerMini")
collectible = require ("collectible")
enemy = require ("enemy")


local levelTextOptions = 
{
    text = "Level 1",     
    x = -500,
    y = 300,
    width = 928,
    font = native.systemFont,   
    fontSize = 128,
    align = "right"  -- Alignment parameter
}

local gameOverOptions = 
{
    text = "Game Over",     
    x = -500,
    y = 300,
    width = 928,
    font = native.systemFont,   
    fontSize = 128,
    align = "right"  -- Alignment parameter
}

local scoreTextOptions = 
{
    text = "Level ",     
    x = -500,
    y = 300,
    width = 928,
    font = native.systemFont,   
    fontSize = 128,
    align = "right"  -- Alignment parameter
}
local introSoundOptions =
{
    channel = 4,
    loops = 1,
    duration = 5000,
    fadein = 0
}
local overSoundOptions =
{
    channel = 4,
    loops = 1,
    duration = 5000,
    fadein = 0
}
function game.start() 
	
	return game.create()
end

function game.doWalls()

	print ("walls: Level .."..level)
	
	local wallFile = "data.levels.level"..level..".wallslevel"..level
	print ("Wall file "..wallFile)
	local wf = require (wallFile)
	wf:addWalls()
end

function game.doPlatforms()

	local pf = require ("data.levels.level"..level..".platformslevel"..level)
	pf:addPlatforms()
end

function game.doEnemies()
	local ef = require ("data.levels.level"..level..".enemieslevel"..level)
	ef:addEnemies()
end

function game.doCollectibles()

	local cf = require ("data.levels.level"..level..".collectibleslevel"..level)
	cf:addCollectibles()
end

function game.doPlayer()
	-- level specific player stuff
	local pf = require ("data.levels.level"..level..".playerlevel"..level)
	pf:addPlayer()
end 


function game.over()
	timer.performWithDelay(1, function()
	text = display.newText(gameOverOptions)
	text:setFillColor( 1, 0, 0 )
	print ("transition")
	transition.to(text,{time=3000,x=1850}) 
	-- print ("play sound")
	audio.play(overSound)

		end, 1)
	game:endLevel()
	score = 0
	timer.performWithDelay(1, function() game:doLevel(false) end, 1)
	game:doHudUpdate()
end


function game.doLevel(doLevelBanner)



	print ("do level start")

	levelTextOptions = 
	{
	    text = "Level "..level,     
	    x = -500,
	    y = 300,
	    width = 928,
	    font = native.systemFont,   
	    fontSize = 128,
	    align = "right"  -- Alignment parameter
	}

if doLevelBanner ==true then
	timer.performWithDelay(1, function()
	levelText = display.newText( levelTextOptions)
	levelText:setFillColor( 1, 0, 0 )
	print ("transition")
	transition.to(levelText,{time=3000,x=1850}) 
	-- print ("play sound")
	-- audio.play(introSound)

		end, 1) 

end


	if playerCreated == false then
		timer.performWithDelay(1, function() game:doPlayer() end, 1)
		
		player.start()
		player.add()
		
 	end

	if level==1 then
		print ("level 1")
		
		game:doWalls()
		game:doPlatforms()
		game:doEnemies()
		game:doCollectibles()
		game:doPlayer()
		
		
	 else
	 	
			print ("Level "..level)
			player.runningPlayerAnim.x = display.contentWidth/2 ; 
			player.runningPlayerAnim.y = display.contentHeight/2 
		
		
		
		
			print ("walls")
			timer.performWithDelay(1, function() game:doWalls() end, 1)
			print ("platforms")
				timer.performWithDelay(1, function() game:doPlatforms() end, 1)
				print ("collectibles")
					timer.performWithDelay(1, function() game:doCollectibles() end, 1)
					print ("enemies")
						timer.performWithDelay(1, function() game:doEnemies() end, 1)
							
						timer.performWithDelay(1, function() game:doPlayer() end, 1)
		timer.performWithDelay(1, function() player:reset() end, 1)
			
		
	end

	



	

	

end


function game.newLevel()
	level = level + 1
	levelTextOptions.text = "Level "..level
	print ("**** DO Level")
	print (levelTextOptions.text)
	game.doLevel(true)
	game:doHudUpdate()
end


function game.endLevel()
	print ("end level")
	-- levelText = display.newText( levelTextOptions)
	-- levelText.text = "Level Complete"
	-- levelText:setFillColor( 1, 0, 0 )
	-- levelText. x= - 500
	-- transition.to(levelText,{time=3000,x=1850})
	audio.play(endLevelSound)

	print ("Removing platforms")
	-- for i =1, #platforms do
	-- 	display.remove(platforms[i].display)
	-- 	platforms[i].display:removeSelf()
	-- 	platforms[i]=nil
	-- end
	for k,v in pairs(platforms) do
		display.remove(v.display)
		v.display:removeSelf()
		v = nil
	end
	platforms = {}

	print ("Removing walls")
	-- for i =1, #walls do
	-- 	display.remove(walls[i].display)
	-- 	walls[i].display:removeSelf()
	-- 	walls[i]=nil
	-- end
	for k,v in pairs(walls) do
		display.remove(v.display)
		v.display:removeSelf()
		v = nil
	end
	walls = {}

	print ("Removing collectibles")
	-- for i =1, #collectibles do
	-- 	display.remove(collectibles[i].display)
	-- 	collectibles[i].display:removeSelf()
	-- 	collectibles[i]=nil
	-- end

	for k,v in pairs(collectibles) do
		display.remove(v.display)
		v.display:removeSelf()
		v = nil
	end


	collectibles = {}

	print ("Removing enemies")
	-- for i =1, #enemies do
	-- 	display.remove(enemies[i].display)
	-- 	enemies[i].display:removeSelf()
	-- 	enemies[i]=nil 
	-- end

	for k,v in pairs(enemies) do
		display.remove(v.display)
		v.display:removeSelf()
		v = nil
	end
	enemies = {}

	
	
end


function game.create() 

	introSound = audio.loadSound(SND_DIR.."gameintro.wav")
	endLevelSound = audio.loadSound(SND_DIR.."endlevel.wav")
	backgroundMusic = audio.loadStream(SND_DIR.."fireice_mainbg.mp3")
	overSound = audio.loadStream(SND_DIR.."gameover.wav")
	if sounds==true then
		
		backgroundMusicChannel = audio.play( backgroundMusic, { channel=3, loops=-1}  )
		
	end

	
	return game 
end

function game.add()
	
end

function game:music()
	print ("Switching on or off music")
	if sounds==true then 
		sounds = false
		audio.stop(backgroundMusicChannel)
	else
		sounds = true
		backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1}  )
	end
end

function game.restart()
	print ("*** Restart ***")
	game:over()
	-- score = 0 

	--  levelComplete = false
	--  game.endLevel()
	--  --level = 1
	--  --game.newLevel()   
	--  game.doHudUpdate()

end


function game.debug()
	collectibles["door"].display:removeSelf()
	collectibles["door"]=nil
end

function game.updateHealth(fac)
	healthRect.xScale = fac
end
function game.doHud()
	-- score
	myScore= display.newEmbossedText("", paw, 40, native.systemFont, 48, { 255, 255, 255, 255 })
	myScore:setTextColor(1)
	myScore:setText( "Score "..score )


	levelDisplayRect = display.newRect(-150, 30, 250, 50)
	levelDisplayRect:setFillColor(1,1,1)
	levelDisplayRect:setStrokeColor(45, 180, 100)
	levelDisplayRect.strokeWidth = 10 

	levelDisplayText= display.newEmbossedText("", -150, 30, native.systemFont, 48, { 255, 255, 255, 255 })
	levelDisplayText:setTextColor(0)
	levelDisplayText:setText( "Level "..level )

	healthRect = display.newRect( paw, 100, health, 10 )
	healthRect:setFillColor( 1,1,1,2 )
	healthRect:setStrokeColor( 1,0,0 )
	healthRect.strokeWidth = 2
 end 
function game.doHudUpdate()
	myScore:setText( "Score "..score )
	levelDisplayText:setText( "Level "..level )

end
return game
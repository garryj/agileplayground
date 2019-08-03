-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

require("globals")

local physics = require "physics"
--physics.setDrawMode( "hybrid")
physics.start(true) 


json = require( "json" )
local widget = require( "widget" )




game = require("game")
game.create()



local bg = require("background") 
bg.start()
bg.add()


platform = require("platform")




local ls = require("landscape")
ls.start()
ls.add()


 


-- Level display

game.doLevel()

game.doHud() -- over the top hud




local function handleMenuButtonSoundEvent( event )
  
    if ( "ended" == event.phase ) then
        game:music() 
    end
end

local function handleMenuButtonRestartEvent( event )
  
    if ( "ended" == event.phase ) then
        game:restart()
    end
end


local function handleMenuButtonDebugEvent( event )
  
    if ( "ended" == event.phase ) then
        game:debug()
    end
end
local function handleMenuButtonNextLevelEvent( event )
  
    if ( "ended" == event.phase ) then
      game.endLevel()
      game:newLevel()
    end
end

-- Add Menu information
local groupMenuItems = display.newGroup()
menuRect = display.newRoundedRect( 0, ph-100, 150, 300, 12 )
menuRect.fill = {0.5,0.5,0}
groupMenuItems:insert(menuRect)

menuCircle = display.newCircle(0, ph, 60 )
menuCircle.fill = {0.2,0.2,0} 
local buttonMenuSound = widget.newButton(
    {
        left = -50,
        top = ph-130,
        id = "music",
        label = "Music",
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 100,
        height = 40,
        cornerRadius = 2,
        Color = {1,1,1,1},
        fillColor = { default={0,0,0,1}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
        strokeWidth = 4,
        onEvent = handleMenuButtonSoundEvent
    }
)
local buttonMenuRestart = widget.newButton(
    {
        left = -50,
        top = ph-170,
        id = "restart",
        label = "Restart",
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 100,
        height = 40,
        cornerRadius = 2,
        Color = {1,1,1,1},
        fillColor = { default={0,0,0,1}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
        strokeWidth = 4,
        onEvent = handleMenuButtonRestartEvent
    }
)

groupMenuItems:insert(buttonMenuRestart)
groupMenuItems:insert(buttonMenuSound)


groupMenuItems.isVisible = false



local function onKeyEvent( event )
 
   if event.keyName == "a" then
				 if event.phase == "down" then
						player.moving = true
						player.direction = "left"
						
					elseif event.phase == "up" then
						player.moving = false
				 end
	end
 	 if event.keyName == "d" then
				 if event.phase == "down" then
						player.moving = true
						player.direction = "right"
						
					elseif event.phase == "up" then
						player.moving = false
				 end
	end
  if event.keyName == "w" then
			 if event.phase == "down" and player.jumping==false then
					player.jumping = true
					player.runningPlayerAnim:setLinearVelocity( 0, -220 )
					
			 end
	end
    -- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
    -- This lets the operating system execute its default handling of the key
    return false
end

 
local function onLocalCollision( self, event )

  if (player.runningPlayerAnim.getLinearVelocity) then
    if player.runningPlayerAnim:getLinearVelocity()~=nil then
        local vx, vy = player.runningPlayerAnim:getLinearVelocity()
        
         player.jumping = false
       
      end
  end
	
 
  if ( event.phase == "began" ) then
  		print( self.name .. ": collision began with " .. event.other.name )
  		
  		
  		
  	 if string.starts(event.other.name,"lever") then 
        event.other:setSequence("pull")
        event.other:play()
        -- need to do this on timer delay
          timerOne = timer.performWithDelay(1,  event.other.obj:touched()  )               
      end

      if string.starts(event.other.name,"key") then 
         -- print ("Collided with "..event.other.name)
           timerOne = timer.performWithDelay(1,  event.other.obj:touched() )
      end

        if string.starts(event.other.name,"exit") then 
         --   print ("Collided with exit")
          timerOne = timer.performWithDelay(1,  event.other.obj:touched() )
        end


          if string.starts(event.other.name,"diamond") then 
          --  print ("Collided with diamond")
          timerOne = timer.performWithDelay(1,  event.other.obj:touched() )
        end

         if string.starts(event.other.name,"water") then 
          print ("Collided with water, alive "..tostring(player.isAlive()))
          if player.isAlive()==true then
            timerOne = timer.performWithDelay(1,  event.other.obj:touched() )
          end

        
          
        end

        if string.starts(event.other.name,"drop") then 
             print ("Collided with drop "..event.other.name)
            timerOne = timer.performWithDelay(1,  event.other.obj:touched() )
          end
          if string.starts(event.other.name,"flame") then 
             print ("Collided with flame "..event.other.name)
            timerOne = timer.performWithDelay(1,  event.other.obj:touched() )
          end
          if string.starts(event.other.name,"pillteleport") then 
         
            timerOne = timer.performWithDelay(1,  event.other.obj:touched() )
        end
  else
  	if ( event.phase == "ended" ) then 
      if levelComplete ==true then

        levelComplete = false
        game.endLevel()
        game.newLevel()
      end
  		 
  	end
  end

return true

end


 

local function frameUpdate(event)

	if player.moving ==true then  
    if (player.runningPlayerAnim) then
       if (player.runningPlayerAnim.x) then
            if player.direction=="left" then
              player.runningPlayerAnim.x = player.runningPlayerAnim.x-player.speed
        end
        if player.direction=="right" then
          player.runningPlayerAnim.x = player.runningPlayerAnim.x+player.speed
        end
      end

  	
    end
	end

						
end

local function tapListener( event )
 
    -- Code executed when the button is tapped
    print( "Object tapped: " .. tostring(event.target) )  -- "event.target" is the tapped object
    return true
end


function menuCircle:touch(event)    
    if event.phase == "began" then
    print (event.target)
    	if groupMenuItems.isVisible then
    		groupMenuItems.isVisible = false
    	else
    		groupMenuItems.isVisible = true
    	end
    	
    end
end

player.runningPlayerAnim.collision = onLocalCollision
player.runningPlayerAnim:addEventListener( "collision" )
player.runningPlayerAnim:addEventListener( "tap", tapListener )
Runtime:addEventListener( "enterFrame", frameUpdate)
Runtime:addEventListener( "key", onKeyEvent )
Runtime:addEventListener( "touch", menuCircle )


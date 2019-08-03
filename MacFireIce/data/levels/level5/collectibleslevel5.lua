	local M = {}
local function addCollectibles()
local moving1 = false
local function onLocalBoulderCollision( self, event )
	--print ("boulder Collision with "..event.other.name)
	if ( event.phase == "began" ) then
		
		if event.other.name=='lever2' and moving1==false then
			-- open door if boulder touched lever2
			moving1=true
			--print ("**** moving platform 1 *****")
			timer.performWithDelay(1, function() transition.to(platforms["pl1"].display,{time=3000,y=500}) end, 1)
			
		end
		return true
	end
	if ( event.phase == "ended" ) then
		--print (self.name.." ended collision with "..event.other.name)

		
	end 
	return true
end



	parms.addParms = {} 

	bindTrick = {funct="disappear"}
parms = {name="lever2", img = "leverpull.png", ss_height=46, ss_width=50, ss_frames = 3, x=-200, y= pah-40, gravity="static", sensor = true, soundTouch = "lever_pull.wav",bind = platforms["plhatch"], bindTrick = bindTrick}
 	parms.doPhysics = true
	lever2 = collectible:new(parms)  



	parms = {name="lever1", img = "leverpull.png", ss_height=46, ss_width=50, ss_frames = 3, x=260, y= 650, gravity="static", sensor = true, soundTouch = "lever_pull.wav", bind = platforms["plhatch"], bindTrick = bindTrick}
	

	parms.doPhysics = true
	lever1 = collectible:new(parms)


 
  
 
 	
  


	--Invisible exit collision bit
	bindTrick = nil
	parms = {name="exit", img = "portal.png", ss_height=135, ss_width=150, ss_frames = 1, x=100, y= 100, gravity="static", sensor = true, soundTouch = "exit.wav", doPhysics = true}
	colExit = collectible:new(parms)

 
	--exit door
	bindTrick = {funct="disappear"}
	parms = {name="door", img = "door.png", ss_height=160, ss_width=101, ss_frames = 1, x=100, y= 100, gravity="static", sensor = false, soundTouch = "dooropen.wav", bindTrick = bindTrick, doPhysics = true}
	print ("Adding door")
	colDoor = collectible:new(parms)

	if openExit ==true then
	  colDoor.display.x = offScreenX  
	end
  
  -- Add portal

	parms = {name="portal1", img = "portal.png", ss_height=135, ss_width=150, ss_frames = 1, x=200, y= pah - 150, gravity="static",  sensor = true, doPhysics = true}
	colPortal1 = collectible:new(parms)

	parms = {name="portal2", img = "portal.png", ss_height=135, ss_width=150, ss_frames = 1, x=200, y= pah - 450, gravity="static",  sensor = true, doPhysics = true}
	colPortal2 = collectible:new(parms)

 
	bindTrick = {funct="disappear"}
	parms = {name="key", img = "key.png", ss_height=45, ss_width=94, ss_frames = 1, x=-100, y= 310, gravity="static", sensor = true, soundTouch = "keycollect.wav", bindTrick = bindTrick, doPhysics = true}
	parms.bind = colDoor
	colKey = collectible:new(parms)

bindTrick = {funct="disappear"}
	parms = {name="diamond1", img = "diamondspinning.png", ss_height=30, ss_width=30, ss_frames = 7, x=paw - 240, y= pah - 370, gravity="static",soundTouch = "diamondcollect.wav",  sensor = true, doPhysics = true, score = 40, bindTrick = bindTrick}
	 
	colDiamond1 = collectible:new(parms)

	bindTrick = {funct="disappear"} 
	parms = {name="diamond2", img = "diamondspinning.png", ss_height=30, ss_width=30, ss_frames = 7, x=paw - 40, y= pah - 170, gravity="static",soundTouch = "diamondcollect.wav",  sensor = true, doPhysics = true, score = 40, bindTrick = bindTrick}
	
	colDiamond2 = collectible:new(parms)

	bindTrick = {funct="disappear"}
	parms = {name="diamond3", img = "diamondspinning.png", ss_height=30, ss_width=30, ss_frames = 7, x=paw - 0, y= pah - 170, gravity="static",soundTouch = "diamondcollect.wav",  sensor = true, doPhysics = true, score = 40, bindTrick = bindTrick}
	colDiamond3 = collectible:new(parms)

 
	bindTrick = {funct="disappear"}
	parms = {name="diamond4", img = "diamondspinning.png", ss_height=30, ss_width=30, ss_frames = 7, x=200, y= pah - 170, gravity="static",soundTouch = "diamondcollect.wav",  sensor = true, doPhysics = true, score = 40, bindTrick = bindTrick}
	colDiamond4 = collectible:new(parms)






bindTrick = {funct="teleport"}

	parms = {name="pillteleport1", img = "teleport_icon.png", ss_height=40, ss_width=40, ss_frames = 1, x=900, y= pah - 170, gravity="static",soundTouch = "diamondcollect.wav",  sensor = true, doPhysics = true, score = 50, bindTrick = bindTrick, bind = colPortal1}
	colPillTele1 = collectible:new(parms)



bindTrick = {funct="teleport"}

	parms = {name="pillteleport2", img = "teleport_icon.png", ss_height=40, ss_width=40, ss_frames = 1, x=50, y= pah - 170, gravity="static",soundTouch = "diamondcollect.wav",  sensor = true, doPhysics = true, score = 50, bindTrick = bindTrick, bind = colPortal2}
	colPillTele2 = collectible:new(parms)


parms = {name="boulder1", img = "boulder.png", ss_height=54, ss_width=76, ss_frames = 1, x=paw - 440, y= pah - 370, gravity="dynamic", sensor = false, doPhysics = true}
	parms.addParms = { friction=1, bounce=0.1 }
	
		parms["x"]=350
		parms["y"]=600
		parms["collision"]= true

		local boulder1 = collectible:new(parms)
		boulder1.display.collision = onLocalBoulderCollision
		boulder1.display:addEventListener( "collision" )

	collectibles["boulder1"]= boulder1


parms = {name="water1", img = "waterwave.png", ss_height=32, ss_width=128, ss_frames = 2, x=550, y= 870, gravity="static", sensor = true, doPhysics = true}
parms.sequences = {
		
	{name = "default",
	        start = 1,
	        count = 62,
	        time = 8200,
	        loopCount = 500,
	        loopDirection = "forward"

	}
}

parms.sequenceOptions = 
{
	    width = 310,
	    height = 80,
	    numFrames = 63
	}
	local water1 = collectible:new(parms)
	
	collectibles["water1"]= water1








	table.insert(collectibles, lever1)
	table.insert(collectibles, lever2)
	-- table.insert(collectibles, lever3)
	-- table.insert(collectibles, lever4)
	
	collectibles["key"] = colKey
	collectibles["exit"]= colExit
	collectibles["door"]= colDoor

collectibles["coldiamond1"]= colDiamond1
collectibles["coldiamond2"]= colDiamond2
collectibles["coldiamond3"]= colDiamond3
collectibles["coldiamond4"]= colDiamond4
collectibles["boulder1"]= boulder1

 
collectibles["teleport1"]= colPillTele1
collectibles["teleport2"]= colPillTele2
collectibles["portal1"]= colPortal1
collectibles["portal2"]= colPortal2
end

M.addCollectibles = addCollectibles
return M

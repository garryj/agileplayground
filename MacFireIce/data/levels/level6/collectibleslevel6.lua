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


	 
  
 
 	
	--exit portal
	parms = {x=paw+300, y=pah-100}
	collectibles["exit"] = require ("data.objects.exit"):new(parms)

 
	--exit door
	parms = {x=paw+300, y = pah-100}
	collectibles["door"] = require ("data.objects.door"):new(parms)

  

	--key
	parms = {x=700, y= pah-100}
	parms.bind = collectibles["door"]
	collectibles["key"] = require ("data.objects.key"):new(parms)


 

	--diamond

	for i = 1, 100 do
		parms = {x=math.random(paw),y= math.random( pah ), name="diamond"..i}
		collectibles[parms.name] = require ("data.objects.diamond"):new(parms)
	end
	




-- parms = {x=550,y= pah-40, name="water1"}
-- collectibles[parms.name] = require ("data.objects.water"):new(parms)

-- parms = {x=550,y= pah-140, name="water2"}
-- collectibles[parms.name] = require ("data.objects.water"):new(parms)




end

M.addCollectibles = addCollectibles
return M

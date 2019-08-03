


local M = {}
local function addEnemies()
	
	sequences_enemy = {
		
	{name = "shimmy",
	        start = 1,
	        count = 5,
	        time = 800,
	        loopCount = 0,
	        loopDirection = "forward"}

	}


	-- negative damage means health gain
	parms = {sequences_enemy = sequences_enemy,img="flame.png", ss_width=24, ss_height=24,ss_frames = 7,  x=200, y=600, gravity ="dynamic",soundTouch = nil, sensor = false,damage = -1}

	
	for i = 1, 100 do 
		parms["x"]=parms["x"]
		parms["y"]=math.random( 300, ph )
		parms["name"] = "flame"..i
		local enemy = enemy:new(parms)
		--move right
		timer.performWithDelay(1, function()
			transition.to(enemy.display,{time=3000,x=paw}) 
		end, 1) 
	  table.insert(enemies, enemy) 
	end 

	sequences_enemy = {
		
	{name = "shimmy",
	        start = 1,
	        count = 5,
	        time = 800,
	        loopCount = 0,
	        loopDirection = "forward"}

	}

		
	-- for i = 1, 100 do 
	-- 	parms = {sequences_enemy = sequences_enemy, img="water_droplet.png", ss_width=50, ss_height=50,ss_frames = 5, name = "drop"..i, x=math.random(paw), y=math.random(pah), gravity ="dynamic",soundTouch = "drip.mp3", sensor = false, damage = 1}
	-- 		enemies["drop"..i]=enemy:new(parms)
	-- end  

 

end

M.addEnemies = addEnemies
return M
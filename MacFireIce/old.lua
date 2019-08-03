parms = {}
	parms.x = 200
	parms.y = 380
	parms.isVisible = true
	platforms["pl1"]= platform:new(parms)
	table.insert(platforms, platforms["pl1"])

	parms.x = 1100
	parms.y = 520
	table.insert(platforms, platform:new(parms))
	parms.x = 1000
	parms.y = 600
	
	parms.x = 900
	parms.y = 700
	parms.isVisible = false
	platforms["pl2"] = platform:new(parms)
	table.insert(platforms, platforms["pl2"])
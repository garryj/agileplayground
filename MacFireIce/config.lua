--
-- For more information on config.lua see the Project Configuration Guide at:
-- https://docs.coronalabs.com/guide/basics/configSettings
--

application =
{
	content =
	{
		width = 2048,
		height = 1516, 
		scale = "letterbox",
		fps = 60,
		
		--[[
		imageSuffix =
		{

		width = system.getInfo("androidDisplayWidthInInches"),
		height = system.getInfo("androidDisplayHeightInInches")
			    ["@2x"] = 2,
			    ["@4x"] = 4,
		},
		--]]
	},
}

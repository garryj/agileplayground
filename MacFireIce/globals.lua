-- Globals

_G.Game = "Platformer"
_G.IMG_DIR ="images/"
_G.SND_DIR ="sounds/"
_G.DATA_DIR ="data/"


_G.moveable = {}

_G.collectible = nil
_G.enemy = nil
_G.wall = nil
_G.player = nil
_G.playerMini = nil
_G.playerCreated = false
_G.fireGirl = false

_G.platforms = {}
_G.collectibles = {}
_G.enemies = {}
_G.walls = {} 

_G.player = nil
_G.alive = true
_G.resetHealth = 100
_G.health = 100
_G.speed = 5
_G.spins = 0

_G.startX = 0
_G.startY = 0

_G.game = nil

-- LEVEL LEVEL LEVEL LEVEL
_G.level  = 4
-- sounds sounds sounds
_G.sounds = false

_G.offScreenX = -1000
_G.pw = display.actualContentWidth
_G.ph = display.actualContentHeight

_G.paw = display.contentWidth
_G.pah = display.contentHeight

_G.PLAYERSTARTX = pw/2
_G.levelComplete = false
-- Backgrounds/ landscapes etc
_G.bgCnt = 0 
_G.lsCnt = 0
_G.plCnt = 0  --platform count
_G.stCnt = 0	-- something count
_G.wallCnt = 0	-- something count


_G.GROUND_WIDTH = pw+1000 
_G.GROUND_HEIGHT = 33

_G.BACKGROUND_WIDTH = 10000
_G.BACKGROUND_HEIGHT = 3000

_G.r = Runtime


_G.openExit = false-- for debug, set to true to allow for open exit

_G.menuCircle = nil
_G.menuRect = nil

_G.score = 0
_G.levelScore = 0


-- read data
function readData(path)
	data = {}
	--print (DATA_DIR..path)
	 local file = io.open(system.pathForFile(DATA_DIR..path), "r")
    for lines in file:lines() do
      --  print (lines)
    end
    io.close(file)
end 



function printTable ( t )  
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] =&gt; "..tostring(t).." ")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] =&gt; "'..val..'"')
                    else
                        print(indent.."["..pos.."] =&gt; "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." ")
        sub_print_r(t,"  ")
        print("")
    else
        sub_print_r(t,"  ")
    end
    print()
end
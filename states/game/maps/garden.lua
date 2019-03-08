local tileString  = [[
RLLLLLLLLLLLLLLLLLLLLLLLR
R                       R
R                       R
R                       R
R                       R
R                       R
R                       R
R   RLLL     RLLLLR     R
R   R        R    R     R
R   R        RLLLLL     R
R   R        R          R
R   LLLL  L  L          R
R                       R
R                       R
R            F     F    R
R                       R
R     F                 R
R                       R
LLLLLLLLLLLLLLLLLLLLLLLLL
]]

local quadInfo = {
	{' ',  0,  0}, --floor
	{'L', 32,  0}, --box
	{'F',  0, 32}, --flower
	{'R', 32, 32} --boxtop
}

newMap(32, 32, 'Images/Textures/garden.png', tileString, quadInfo)

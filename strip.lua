if not os.loadAPI("TApi.lua")then
	return
end

modem = TApi.GetModem()

function getFuel()
TApi.HomeAll()
TApi.Up()
TApi.TurnLeft()
turtle.suck()
TApi.Down()
TApi.TurnRight()
end

function Deposit()
	TApi.HomeAll()
	TApi.TurnLeft()
	for s=1,16 do
		turtle.select(s)
		turtle.drop()
	end
	TApi.TurnRight()
end

local args ={...}
if #args == 0 then
modem.transmit(3, 1,"Usage: strip <width> <hight>")
return
end

width = args[1]

hight = args[2]

while true do
	for i=1,width do
		for j=1,hight do
			
		end
	end
end

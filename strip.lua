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

--while true do
	for i=1,width do
		for j=1,hight-1 do
			if turtle.getFuelLevel()==0 then
				if TApi.SelectItem("minecraft:coal") then
					turtle.refuel(1)
				else
					TApi.SavePosRot()
					getFuel()
					Deposit()
					TApi.RestorePosRot()
				end
			end
			if(TApi.InventoryFull())then
				Deposit()
			end
			turtle.digUp()
			if j~=hight-1 then
				modem.transmit(3, 1,"going up")
				TApi.Up()
			end
		end
		modem.transmit(3, 1,"homing z")
		TApi.HomeZ()
		modem.transmit(3, 1,"going right")
	end
	modem.transmit(3, 1,"homing and starting again")
--end

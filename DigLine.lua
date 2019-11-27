local args={...}
if #args ==0 then
print("Usage: DigLine <x> <z>")
return
end

dist=tonumber(args[1])
hight=tonumber(args[2])

zcounter =0

for i=1,dist do
    turtle.refuel(1)
    while turtle.detectUp() do
        if zcounter==hight then
            break
        else
            turtle.digUp()
            turtle.up()
           zcounter =zcounter+1
         end
    end
    while zcounter~=0 do
        turtle.down()
        zcounter=zcounter-1
    end
    turtle.dig()
    turtle.forward()
end

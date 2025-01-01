function love.load()
k=love.window.getDPIScale()
width,height=love.window.getMode()
width=width/k --scaling for different os
height=height/k --  ""

data={}
track={}
cofac={C({50,7}),C({30,2}),C({0,-6}),C({20,1}),C({10,0}),C({5,0}),C({3,0})}
cocofac={1,2,3,4,5,6,7}
T=0
run=0
trace=0
function love.keypressed(key, isrepeat)
    if key=="space" then
        run=1-run
    end
end
function love.mousepressed(x,y,key)
    if key==1 then
        track={}
        data={}
        full=0
        trace=1
    end
end
function love.mousereleased(x,y,key)
    if key==1 then
        trace=0
        cocofac={}
        cofac=tracer(30)
        sort()
    end
end
end


function love.update(dt)
    if run==1 then
    T=T+dt/2
    end
    if T>2*pi then
        T=0
        full=1
    end
    mx,my=love.mouse.getPosition()
    if trace==1 then
       table.insert(track,C({mx-width/2,my-height/2}))
    end
end


function love.draw()
    love.graphics.translate(width/2,height/2)
    love.graphics.setPointSize(5)
    love.graphics.points(0,0)
    local s=C({0,0})
    local sp=C({0,0})
    for i=1,#cofac do
        sp=s
        s=s+cofac[i]*e(C({0,cocofac[i]*T}))
        love.graphics.setColor(1,0,0)
        trackerball(sp,norm(cofac[i]))
        love.graphics.setColor(0,1,0)
        point(s)
    end
    love.graphics.print("precision iterations="..#cofac/2,-width/2,-height/2)
    love.graphics.print("trace="..trace,-width/2,-height/2+10)
    love.graphics.print("run="..run,-width/2,-height/2+20)
    table.insert(data,s[1])
    table.insert(data,s[2])
    if #data>3 then
        love.graphics.setColor(1,1,1)
        love.graphics.line(data)
    end
    if #track>1 then
    if run~=1 then
        local trackdat={}
        for i=1,#track do
            table.insert(trackdat,track[i][1])
            table.insert(trackdat,track[i][2])
        end
        love.graphics.setColor(0,1,1)
        love.graphics.line(trackdat)
    end
    end
end

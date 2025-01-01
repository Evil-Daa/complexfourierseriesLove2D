function love.conf(t)
    t.window.display=1
end
cos=math.cos
sin=math.sin
exp=math.exp
pi=math.pi
local complex={}
function C(x)
    return(setmetatable(x,complex))
end

function complex.__add(a,b)
    local s=C({})
    s[1]=a[1]+b[1]
    s[2]=a[2]+b[2]
    return(s)
end

function complex.__sub(a,b)
    local s=C({})
    s[1]=a[1]-b[1]
    s[2]=a[2]-b[2]
    return(s)
end

function complex.__mul(a,b)
    local s=C({})
    s[1]=a[1]*b[1]-a[2]*b[2]
    s[2]=a[1]*b[2]+a[2]*b[1]
    return(s)
end

function conj(a)
    local s=C({a[1],-a[2]})
    return(s)
end

function complex.__div(a,b)
    if (b*conj(b))[1]==0 then
        print("trying to divide by zero!!\n")
    end
    local s=C({1,1})
    s=a*conj(b)
    local m=(b*conj(b))[1]
    s[1]=s[1]/m
    s[2]=s[2]/m
    return(s)
end

function e(a)
    local s=C({})
    s[1]=exp(a[1])*cos(a[2])
    s[2]=exp(a[1])*sin(a[2])
    return(s)
end

function point(a)
    love.graphics.points(a[1],a[2])
end

function trackerball(p,r)
    love.graphics.circle("line",p[1],p[2],r)
end

function norm(a)
    local s=0
    s=((a*conj(a))[1])^0.5
    return(s)
end
function f(t) --0 to 2pi track
    local N=#track
    local x=1+(N-1)*t/(2*pi)
    local m=math.floor(x)
    local m2=math.ceil(x)
    return(C({1-x+m,0})*track[m]+C({x-m,0})*track[m2])
end
function sort() --only cofac
    for i=1,#cofac do
        for j=1,#cofac do
            if norm(cofac[i])>norm(cofac[j]) then
                cofac[i]=cofac[i]+cofac[j]
                cofac[j]=cofac[i]-cofac[j]
                cofac[i]=cofac[i]-cofac[j]
                cocofac[i]=cocofac[i]+cocofac[j]
                cocofac[j]=cocofac[i]-cocofac[j]
                cocofac[i]=cocofac[i]-cocofac[j]
            end
        end
    end
end
function tracer(nn)
    local cofac={}
    for i=-nn,nn do
        local co=C({0,0})
        NN=1000
        for j=0,NN do
            local x=2*pi*j/NN
            co=co+f(x)*e(C({0,-i*x}))*C({2*pi/NN,0})*C({1/(2*pi),0})
        end
        table.insert(cofac,co)
        table.insert(cocofac,i)
    end
    return(cofac)
end

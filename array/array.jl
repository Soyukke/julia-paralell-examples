using Distributed
@show nworkers() myid()

@everywhere function hoge()
    sleep(1)
    return myid()
end

@everywhere function hoge3d(x, y, z)
    sleep(1)
    return x*y*z
end

function main()
    N = 10
    a = zeros(N)
    vs = [@spawn hoge() for i in 1:N]
    vv = [fetch(s) for s in vs]
    println(vv)
    # fetchを呼ぶとwaitもする
    vs = [@spawn hoge3d(x, y, z) for x in 1:N for y in 1:N for z in 1:N]
    vv = [fetch(s) for s in vs]
    println(sum(vv))
end

@time main()
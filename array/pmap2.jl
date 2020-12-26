"""
mapをparalellで実行してidを各プロセスで表示する
"""

using Base.Iterators
using Distributed

@everywhere function miseru(x, y)
    @show x y myid()
    sleep(1)
    return x^2 + y
end

function main()
    N::Int64 = 8
    # tuple -> list
    vmiseru = pmap(x -> miseru(x...), product(1:N, 1:N))
    @show vmiseru
    @show size(vmiseru)
    @show typeof(vmiseru)
end

main()

using Distributed

@everywhere function host_id()
    return [gethostname() myid()]
end

vs = Any[]
for worker in workers()
    s = @spawnat worker host_id()
    push!(vs, s)
end

vhost = Array{String, 1}()
vid = Array{Int, 1}()
for (index, s) in enumerate(vs)
    a, b = fetch(s)
    push!(vhost, a)
    push!(vid, b)
end

idx_id = sortperm(vid)
vhost = vhost[idx_id]
vid = vid[idx_id]
onehost = unique(vhost)
oneid = vid[indexin(onehost, vhost)]
for index in 1:length(oneid)
    println("$(onehost[index]) $(oneid[index])")
end
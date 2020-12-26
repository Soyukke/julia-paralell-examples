using Distributed

@everywhere function host_id()
    return [gethostname() myid()]
end

vs = Any[]
for worker in workers()
    s = @spawnat worker host_id()
    push!(vs, s)
end

for s in vs
    a = fetch(s)
    println("HOST: $(a[1]),  ID: $(a[2])")
end
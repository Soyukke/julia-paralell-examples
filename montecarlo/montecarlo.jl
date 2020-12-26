using Distributed
@show myid() nworkers()
@everywhere function sampling()
    return rand()^2 + rand()^2 < 1
end

function main()
    N_SAMPLE = 1000000
    area = @time @distributed (+) for i in 1:N_SAMPLE
        sampling()
    end
    @show 4area/N_SAMPLE
end

main()
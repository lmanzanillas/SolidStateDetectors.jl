# This file is a part of SolidStateDetectors.jl, licensed under the MIT License (MIT).

module SolidStateDetectorsHDF5Ext

@static if isdefined(Base, :get_extension)
    import HDF5
else
    import ..HDF5
end

using SolidStateDetectors


function ssd_write(filename::AbstractString, sim::Simulation)
    if isfile(filename) @warn "Destination `$filename` already exists. Overwriting..." end
    HDF5.h5open(filename, "w") do h5f
        LegendHDF5IO.writedata( h5f, "SSD_Simulation", NamedTuple(sim)  )
    end       
end  

function ssd_read(filename::AbstractString, ::Type{Simulation})
    HDF5.h5open(filename, "r") do h5f
        Simulation(LegendHDF5IO.readdata(h5f, "SSD_Simulation"));
    end     
end  

end # module HDF5

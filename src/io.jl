
using HDF5


function save_params(file::HDF5File, rbm::RBM, name::String)
    write(file, "$(name)___weight", rbm.W')
    write(file, "$(name)___vbias", rbm.visible.bias)
    write(file, "$(name)___hbias", rbm.hidden.bias)
end

function load_params(file::HDF5File, rbm::RBM, name::String)
    rbm.W = read(file, "$(name)___weight")'
    rbm.visible.bias = read(file, "$(name)___vbias")
    rbm.hidden.bias = read(file, "$(name)___hbias")
end

function save_params(file::HDF5File, dbn::DBN)
    for i=1:length(dbn)
        save_params(file, dbn[i], getname(dbn, i))
    end
end
save_params(path::String, dbn::DBN) = h5open(path, "w") do h5
    save_params(h5, dbn)
end


function load_params(file, dbn::DBN)
    for i=1:length(dbn)
        load_params(file, dbn[i], getname(dbn, i))
    end
end
load_params(path::String, dbn::DBN) = h5open(path) do h5
    load_params(h5, dbn)
end



function sdata = shuffleData(data)
    [r,c]   = size(data);
    indices = randperm(r); %Random permutation
    sdata   = data(indices,:);
end
%In here every time indices change.
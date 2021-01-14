function [train, val] = splitTrainVal(data)
    [m,n]  = size(data);
     M     = round(m*0.7);
     train = data(1:M,:);
     val   = data(M+1:end,:);
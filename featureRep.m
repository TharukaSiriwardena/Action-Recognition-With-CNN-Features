function [fetVector1,fetVector2] = featureRep(dataSet,noLabel,count1,count2)
    load('codebook.txt');
    mkdir ('descriptors','testing');
    %% feature representation for training
    
    fetVector = [];%initialize the feature vector
    CBlabel   = [];%initialize the codebook labels
    cnt = 0;
    sum = 1;
    
    for i = 1:noLabel
        fts = [];%initialize the feature points/keypoints concatenate vector for each video in one class
        cnt = cnt + count1(i);
        
        for j = sum:cnt
        
            %load the each of descriptors one by one
            despath = fullfile('descriptors','training');
            desname = strcat('descriptor',num2str(j),'.txt');
            matFile = fullfile(despath,desname);
            y = load (matFile);
            
            matlen = size(y,1);% we get the no of rows , when we get the length(y) we get the largest of (row,col) value
            cblen  = size(codebook,1);
            
            h = zeros(1,cblen);
            
            
            for m = 1:matlen
                
                for n = 1:cblen
                    
                    d(n) = norm(y(m,:)-codebook(n,:));
                end  
            
                [elt,ind] = min(d);%get the minimum distance between one descriptor to each cluster centers
                h(ind) = h(ind) + 1;%put the index of the minumum distance into the histogram bins
           
            end
        
%             figure
%             bar(h);
        
            fetVector = [fetVector;h];
        
        end
    
        CBlabel = [CBlabel ; ones(count1(i),1)*i];
        sum = cnt + 1;
    end
    fetVector1 = [fetVector,CBlabel];
    
    %% feature representation for testing
    
    
    fetVector = [];%initialize the feature vector
    CBlabel   = [];%initialize the codebook labels
    cnt = 0;
    sum = 1;
    
    for i = 1:noLabel
        fts = [];%initialize the feature points/keypoints concatenate vector for each image in one class
        cnt = cnt + count2(i);
        
        for j = sum:cnt
        
            filePath = char(dataSet.Files(j));%convert 1*1 cell array into the char
            [pos,val,dscr]= readSTIP_text(filePath);
            %descriptor = double(descriptor);
            
            %save each descriptor as text file, inside the descriptor folder
            pathname = fullfile('descriptors','testing');
            desname  =  strcat('descriptor',int2str(j),'.txt');
            matfile  = fullfile(pathname,desname);
            save(matfile,'dscr','-ASCII');
        
            y = dscr;
            matlen = size(y,1);% we get the no of rows , when we get the length(y) we get the largest of (row,col) value
            cblen  = size(codebook,1);
            
            h = zeros(1,cblen);
            
            
            for m = 1:matlen
                
                for n = 1:cblen
                    
                    d(n) = norm(y(m,:)-codebook(n,:));
                end  
            
                [elt,ind] = min(d);%get the minimum distance between one descriptor to each cluster centers
                h(ind) = h(ind) + 1;%put the index of the minumum distance into the histogram bins
           
            end
        
%             figure
%             bar(h);
        
            fetVector = [fetVector;h];
        
        end
    
        CBlabel = [CBlabel ; ones(count2(i),1)*i];
        sum = cnt + 1;
    end
    fetVector2 = [fetVector,CBlabel];
    
end


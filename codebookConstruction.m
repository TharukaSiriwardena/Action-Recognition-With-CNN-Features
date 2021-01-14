function [codebook] = codebookConstruction(dataSet,noLabel,count)
    K = 500;% no of cluster centers

   codebook = [];%initialize the codebook
  
   %create new folder as 'descriptor'
   mkdir ('descriptors','training');
   sum = 1;
   cnt = 0;
   
   for i =1:noLabel % go through the each and every sub folders
    
        fts = [];
        cnt = cnt + count(i);
    
        for j=sum:cnt % go through the no of videos' stip files in each folder
            filePath = char(dataSet.Files(j));%convert 1*1 cell array into the char
            [pos,val,dscr]= readSTIP_text(filePath);
            
            fts = [fts;dscr];
            
            %save each descriptor as text file, inside the descriptor folder
            pathname = fullfile('descriptors','training');
            desname  =  strcat('descriptor',int2str(j),'.txt');
            matfile  = fullfile(pathname,desname);
            save(matfile,'dscr','-ASCII');
            
        end
    
        [idx,C] = kmeans(fts,K,'MaxIter',1000);  % k cluster centroid locations in the k-by-p matrix C. , idx is cluster indices of each observation, (k-total*1) vector
        codebook = [codebook;C];
        
        sum = cnt + 1;
       
   
   end
   
end
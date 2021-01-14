%fname = the path of the stip text file
%l1 & l2 are the beginning and ending line indices
% in here create  1×(no of rows of the file) cell array : lines and return
function lines = readlines(fname,l1,l2)
    
    % if the parameters l1 & l2 not given assign them as like below
    if nargin < 2   l1= 1;    end
    if nargin < 3   l2 = Inf; end
    
    lines = {};
    fd = fopen(fname); %Open file, or obtain information about open files : this return 3
    linenum = 0;
    notEOF  = 1; %testing for end of file
    %When you read a portion of your data at a time, you can use feof to check whether you have reached the end of the file. 
    %feof returns a value of 1 when the file pointer is at the end of the file. 
    %Otherwise, it returns 0.
    
    while(notEOF & linenum <= l2)
        line = fgetl(fd); %Read line from file, removing newline characters
        notEOF = ischar(line);%Determine if input is character array it return 1: character array, 0: numeric array
        if (notEOF)
            linenum = linenum + 1;
            if (linenum >= l1 && linenum <= l2)
                lines{end+1} = line;
            end
        end
    end
    fclose(fd);
end
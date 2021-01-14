function [pos,val,dscr]= readSTIP_text(stipfname)

% stipfname = 'walk-simple-stip.txt'
l = readlines(stipfname);
% Set difference of two arrays
% C = setdiff(A,B,setOrder) returns C in a specific order. setOrder can be 'sorted' or 'stable'.
% Find possible matches for string
ind = setdiff(1:length(l),strmatch('#',l));
n=length(ind);
pos=zeros(n,5);
val=zeros(n,1);
dscr=[];
for i=1:length(ind)
    % Transpose vector or matrix
    % Read formatted data from string
    v=transpose(sscanf(l{ind(i)},'%f'));
    if size(v)==0 
      keyboard;
    end
    pos(i,:)=v([3 2 4 5 6]);

    val(i)=v(7);
    if length(v)>7
      dscr(i,:)=v(8:end);
    end
  
end

end
function data = invertData(data,class)
	n = size(data,2); % get the no of col
	
	indices = data(:,n)~=class;
	data(indices,n) = -1;
	
	indices = (data(:,n)==class);
	data(indices,n) = 1;
	
end
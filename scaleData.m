function data = scaleData(data,lLimit,uLimit)
	for i = 1 : end-1
		maxData   = max(data(:,i));
		minData   = min(data(:,i));
		scale     = (uLimit-lLimit)/(maxData-minData);
		data(:,i) = (scale*(data(:,i))-minData)+lLimit;
	end
end
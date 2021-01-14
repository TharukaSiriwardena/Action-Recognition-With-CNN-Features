function accuracy = WinnerTakesAll(actual,predict,classes)
	[m,n] = size(actual);
	[maxp,classp] = max(predict,[],2);
	accuracy = sum(actual(:,n)==classes(classp)')/m;
	
end
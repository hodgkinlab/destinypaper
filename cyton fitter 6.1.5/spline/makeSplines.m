tt = meanLiveData(1, :);
%for ii=2:8
%	Y = meanLiveData(ii,:);
%	[sp, ti] = getSpline(tt, Y);
%	figure(ii-1)
%	plot(tt, Y, 'o', ti, sp, '-')
%end
it = linspace(24,213);
for ii=2:8
	Y = meanLiveData(ii,:);
	sp = akimai(tt, Y, it);
	figure(ii-1)
	plot(tt, Y, 'o', it, sp, '-')
end
function [fullSpline, allTimes] = getSpline( times, popSize, steps )

% Get indices of all nonzero populations or bordering nonzero populations
nonZeroIdx = [0, 0, popSize] + [0, popSize, 0] + [popSize, 0 , 0] ~= 0;
nonZeroIdx = logical(nonZeroIdx(2:end-1));

allTimes = linspace(times(1), times(end), steps);
fullSpline = zeros(1, steps);

nonZeroTimes = times(nonZeroIdx);
startTime = nonZeroTimes(1);
endTime = nonZeroTimes(end);

nonZeroPop =  popSize(nonZeroIdx);

% does not constrain limits to have zero gradient if one of the end data
% points is nonzero. It is impossible to constrain the gradient of only one
% end of the spline, but this is not a problem, since if there is a spike
% one end, there is a long series of zeroes which generate zero gradient
% anyway at the other
if nonZeroPop(1) == 0 && nonZeroPop(end) == 0
	nonZeroPop = [0, nonZeroPop, 0];
end

localSpline = spline(nonZeroTimes, nonZeroPop, ...
	allTimes(allTimes >= startTime & allTimes <= endTime));

fullSpline = [fullSpline(allTimes < startTime), localSpline, fullSpline(allTimes > endTime)];

%fullSpline(fullSpline < 0) = 0;

end


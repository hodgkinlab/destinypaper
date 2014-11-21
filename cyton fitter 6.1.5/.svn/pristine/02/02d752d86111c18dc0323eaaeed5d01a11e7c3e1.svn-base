%{
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013 ~ 2014
%}
function getTimePointMax()
global measuredData;
global modelParams;

nTypes = measuredData.idx.last;
nConc = size(modelParams, 2);
maxVals = NaN(50, nConc, nTypes);
maxNumTimes = 0;

for iType = 1:nTypes
	allObsData = measuredData.data{iType};
	if (isempty(allObsData))
		continue;
	end
	for iConc = 1:nConc
		obsData = squeeze(allObsData(:,:,iConc));
		obsData = obsData(:,~isnan(obsData(1,:)));
		
		repMeasTimes = obsData(1,:);
		measTimes = unique(repMeasTimes);
		numTimes = numel(measTimes);
		if (numTimes > maxNumTimes)
			maxNumTimes = numTimes;
		end
		
		for iTime = 1:numTimes
			selector = (measTimes(iTime) == repMeasTimes);
			points = obsData(:,selector);
			maxVals(iTime, iConc, iType) = max(points(:));
		end
	end
end

maxNumTimes = maxNumTimes + 1;
maxVals(maxNumTimes:end,:,:) = [];
measuredData.maxVals = maxVals;
%disp(num2str(maxVals));
end
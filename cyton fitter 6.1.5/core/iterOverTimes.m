%{
% Executes a cell array of functions for each time, concentration and
% life/death state of the global variable measuredData
%}

function iterOverTimes( functionCell )

global measuredData;
global modelParams;

nTypes = measuredData.idx.last;
nConc = size(modelParams, 2);
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
            
            for iFunc = 1:numel(functionCell)
                func = str2func(functionCell{iFunc});
                func(points, iType, iConc, selector);
            end
		end
	end
end
end



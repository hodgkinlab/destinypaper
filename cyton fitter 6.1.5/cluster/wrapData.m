%{
% Translates raw cell number data as generated by computeModel into format
% readable by fitParameters
%
% INPUTS: modelData: pure data matrix as generated by computeModel
%
% OUTPUTS: measuredData: complete measured data struct in form generated
% by loadMeasuredData and accepted by all functions that take measured data
% as an input
%}

function measuredData = wrapData( modelData )

measuredData.idx		= initDataOrder();
measuredData.data		= modelData;
measuredData.sDataType	= {'live', 'dead', 'drop'};
measuredData.maxTime	= [];

concWeigths = cell(1, measuredData.idx.last);
maxTime = 0;
for iType = 1:measuredData.idx.last
	if ~isempty(modelData{iType})
		measuredData.vConc = 1:size(modelData{iType},3);
		vTime = squeeze(modelData{iType}(1,:,:));
		maxTime = max(maxTime, max(vTime));	
		vConcWeights = numel(vTime);
		concWeigths{iType} = 1./vConcWeights .* ones(1, size(modelData{iType},3));
	else
		concWeigths{iType} = [];
	end
end

measuredData.maxTime = maxTime;
measuredData.concWeigths = concWeigths;

end

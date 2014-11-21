%{
% Converts measurement data from .xsl/.xlsx spreadsheet to struct readable
% by other functions
%
% Called in fitter_multi_gui by pushbutton_numbers_data_Callback
%
% INPUTS: (string) file path including directory path, filename and
% extension
%
% OUTPUTS: (struct) structure containing all measured data
%
% SIDE EFFECTS: modifies the global variables: measuredData, modelParams
%}
function loadMeasuredData(sFilePath)
global measuredData;
global modelParams;
global appContext;
idx = measuredData.idx;

maxTime = 0;
allData = cell(1, idx.last);
%dataStats = cell(1, idx.last);
concWeigths = cell(1, idx.last);

% for each type of data (live, dead, small)
liveOnlyData = true;
for iType = 1:idx.last
	try
		% store each sheet if they exist
		mTable = xlsread(sFilePath, measuredData.sDataType{iType});
		if (isempty(mTable))
			continue
		end
		if (iType ~= idx.live)
			liveOnlyData = false;
		end
		
		% vector of concentrations
		vConc = mTable(:,1);
		
		% get indices of first two non-blank cells
		vIdx = find(~isnan([vConc; 0]), 2);
		
		% find number of measured generations
		rowStep = vIdx(2) - vIdx(1);
		
		% get indices and number of all non-blank cells
		vConc = vConc(~isnan(vConc));
		nConc = numel(vConc);
		
		% this is needed for balancing fits across concentrations
		vConcWeights = NaN(1, nConc);
		
		mData = NaN(rowStep, size(mTable, 2) - 1, nConc);
		rowStart = 1;
		rowStop = rowStep;
		
		% for each concentration
		%figure; colors = 'rgbcymk';
		for iConc = 1:nConc
			mData(:,:,iConc) = mTable(rowStart:rowStop,2:end);
			rowStart = rowStart + rowStep;
			rowStop = rowStop + rowStep;
			
			m = squeeze(mData(2:end,:,iConc));
			vSelect = (sum(isnan(m), 1) < size(m, 1));
			
			% created a vector of time measurements
			vTimes = squeeze(mData(1,:,iConc));
			uniqueTimes = unique(vTimes(vSelect));
			vConcWeights(iConc) = numel(uniqueTimes);
		end
		if (any(vConcWeights == 0))
			error('unhandled division by zero');
		end
		concWeigths{iType} = 1./vConcWeights;
		allData{iType} = mData;
		vTime = squeeze(mData(1,:,:));
		maxTime = max(maxTime, max(vTime(:)));
	catch err
		if (~strcmp(err.identifier, 'MATLAB:xlsread:WorksheetNotFound'))
			rethrow(err);
		end
	end
end
measuredData.data = allData;
measuredData.vConc = vConc;
measuredData.maxTime = ceil(maxTime);
nConc = numel(vConc);
nConcPrev = size(modelParams, 2);
if (nConcPrev < nConc)
	modelParams = repmat(modelParams(:,1), 1, nConc);
elseif (nConcPrev > nConc)
	modelParams = modelParams(:,1:nConc);
end

fitVarianceModel();
getTimePointMax();

appContext.bLiveOnly = liveOnlyData;
appContext.maxEvalTime = measuredData.maxTime;
appContext.numTimeSteps = appContext.timeStepCoeff*measuredData.maxTime;
appContext.maxEvalDiv = ceil(measuredData.maxTime/appContext.minDivTime);
end
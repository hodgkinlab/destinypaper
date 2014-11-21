%{
% Must be run before other functions in the interface
% 
% Sets up global variables with empty or default values
% - Empty:
%   - measuredData
%   - modelParams
% - Default
%   - softwareVersion
%   - userSettings
%   - idxSet
%   - idxPar
%
% No inputs or outputs
%
% SIDE EFFECTS: creates or modifies each of the aforementioned global
% variables
%}
function initialise(fromCommandLine)
global appContext;
global measuredData;
global idxPar;

if (exist('matlabpool', 'file') == 2)
	nWorkers = feature('numCores');
	nActive = matlabpool('size');
	if ((nWorkers > 1) && (nWorkers > nActive))
		if (nActive > 0)
			matlabpool('close');
		end
		fprintf('opening a pool with %d workers\n', nWorkers);
		matlabpool('open', nWorkers);
	end
end

idxPar = initParamsOrder();

measuredData = [];
measuredData.idx		= initDataOrder();
measuredData.data		= cell(1, measuredData.idx.last);
measuredData.sDataType	= {'live', 'dead', 'drop'};
measuredData.vConc		= [];
measuredData.maxTime	= [];

appContext.softwareVersion = '6.1.5';
appContext.sSettingsFile = 'settings.mat';
loadAppContext(); % requires initialized 'idxPar' and 'measuredData'
if (nargin == 1)
	appContext.commandLine = fromCommandLine;
else
	appContext.commandLine = false;
end

setDefaultModelParams();
setDefaultParamBounds();
end


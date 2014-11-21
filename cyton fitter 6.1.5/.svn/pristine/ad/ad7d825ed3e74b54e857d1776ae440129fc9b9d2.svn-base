%{
% Application context is a set of software settings,
% such as fitting options, recent paths, etc.
%
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013
%}
function loadAppContext()
global measuredData;
global appContext;
global idxPar;
nLockFix = idxPar.last;

sSettingsFile = appContext.sSettingsFile;
softwareVersion = appContext.softwareVersion;

appContext = [];
try
	load(sSettingsFile);
	if (~strcmp(softwareVersion, appContext.softwareVersion))
		rethrow (MException(1, 'version mismatch'));
	end
catch err
	fprintf('loading appContext, exception: %s\n', err.message);
	
	% set default values
	% these settings can be set explicitly via GUI
	appContext.numTimeSteps		= 500;
	appContext.maxEvalTime		= 200;
	appContext.maxEvalDiv		= 30;
	appContext.maxIterNum		= 1000;
	appContext.errorTolerance	= 5; % in percents, used for min. variance
	appContext.useLogLikeFit	= 1;
	appContext.bLiveOnly		= 0;
	
	% these settings can be set explicitly via GUI tickboxes
	appContext.vLockParam = false(1, nLockFix);
	appContext.vFixParam = false(1, nLockFix);
	appContext.vLockParam(idxPar.numZombie) = true;
	appContext.vLockParam(idxPar.mechDecay) = true;
	appContext.vFixParam(idxPar.numZombie) = true;
	appContext.vFixParam(idxPar.mechDecay) = true;
	
	% these are implicitly changed during GUI interaction
	appContext.sRecentPath = '.';
	appContext.windowPos = [];
	appContext.arrFigPos = cell(1, 2 + measuredData.idx.last);
	
	% hidden settings, cannot be changed by the user
	appContext.minDivTime		= 5; % #model_divs = maxTime/minDivTime
	appContext.timeStepCoeff	= 3; % #time_steps = coeff*maxTime
	appContext.maxEvalsIter		= 100;
	appContext.fitTolFun		= 1.0e-6;
	appContext.fitTolX			= 1.0e-6;
	appContext.uiLognPercnt		= 0.99;
	appContext.uiMaxTimeAxis	= 1000;
	appContext.minDestProb		= 1.0e-9; % used for progressor fraction
end

% hidden settings, cannot be changed
appContext.sSettingsFile = sSettingsFile;
appContext.softwareVersion = softwareVersion;

end
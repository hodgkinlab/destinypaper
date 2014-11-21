%{
% Command line interface for the Cyton fitter.
% Usage example can be found in [run_script.m].
%
% Damian Pavlyshyn, Andrey Kan
%}
function cyton_fitter(scriptSettings)
global measuredData;
global modelParams;
global paramBounds;
global appContext;

expPath = scriptSettings.outputPath;
mkdir(expPath);

% this initiates global variables
initialise(true); % [appContext] is loaded from the code folder

if (isfield(scriptSettings, 'appContextFile')) % override it if required
	appContext.sSettingsFile = scriptSettings.appContextFile;
	loadAppContext();
end
% override desired [appContext] fields
appContext.useLogLikeFit = scriptSettings.useLogLikeFit;
appContext.maxIterNum = scriptSettings.maxIterNum;

loadMeasuredData(scriptSettings.dataFileName);
loadParameters(scriptSettings.paramFileName);

%create folders for accumulating plots
if appContext.bLiveOnly
	numFigs = 3;
else
	numFigs = 5;
end
mkdir(fullfile(expPath, 'figs'));
for i=1:numFigs
	mkdir(fullfile(expPath, ['figs/fig', int2str(i)]));
end

% if bootstrapping is used, the original measuredData should be preserved
if (scriptSettings.dataResampling)
	initData = measuredData;
end

if (~scriptSettings.randomStart)
	initParams = modelParams;
end

fitStats = { ...
	'path to initial params', 'path to final params', ...
	'contextValue', 'AIC', 'number of iterations'};
allInitParams = [];
allFittedParams = [];
paramHeaders = {};
testCounter = 0;

for j = 1:scriptSettings.numFitCases
	% "test" = fit for [specific_init_param @ specific_sampled_data]
	testPath = fullfile(expPath, sprintf('test_%03d', testCounter));
	testCounter = testCounter + 1;
	mkdir(testPath);
	
	% resample the measured data
	if (scriptSettings.dataResampling)
		measuredData = initData;
		iterOverTimes({'bootStrap'}); % changes [measuredData]
	end
	
	if (scriptSettings.randomStart)
		% generate a parameter set
		initParams = generateParVariable( ...
			paramBounds, numel(measuredData.vConc));
	end
	saveParameters(fullfile(testPath, 'initParams'), initParams, 0);
	
	for k = scriptSettings.fitContext
		fitCtxSuffix = sprintf('errTol_%.02f', k);
		%fitCtxSuffix = strrep(fitCtxSuffix, '.', '_');
		testContPath = fullfile(testPath, fitCtxSuffix);
		mkdir(testContPath);
		
		% FITTING HAPPENS HERE
		modelParams = initParams;
		appContext.errorTolerance = k;
		output = runFitter();
		
		% the reallocation at each loop iteration is inefficient,
		% but the runtime is dominated by runFitter, so the slowdown
		% is insignificant
		allInitParams = [allInitParams, initParams]; %#ok<AGROW>
		allFittedParams = [allFittedParams, modelParams]; %#ok<AGROW>
		
		AICc = [];
		for l = 1:numel(measuredData.vConc)
			concVal = measuredData.vConc(l);
			concSuffix = sprintf('conc_%.02f', concVal);
			%concSuffix = strrep(concSuffix, '.', '_');
			
			paramHeaders = [paramHeaders, ...
				{fullfile(testPath, 'initParams'); k; concVal}]; %#ok<AGROW>
			value = savePlots(fullfile(testContPath, concSuffix), l);
			AICc = [AICc, value]; %#ok<AGROW>
			
			% accumulate all figures in one folder for each figure type
			for m = 1:numFigs
				srcFile = fullfile(testContPath, ...
					concSuffix, ['fig', int2str(m), '.tif']);
				dstFile = fullfile( ...
					expPath, 'figs', ['fig', int2str(m)], ...
					['test', int2str(j-1), ...
					'_', fitCtxSuffix, '_',concSuffix,'.tif']);
				copyfile(srcFile, dstFile);
			end
		end
		%save fitted params
		saveParameters( ...
			fullfile(testContPath, 'fittedParams'), modelParams, 0);
		
		% The mean(AIC) is not strictly necessary, since currently the
		% AIC is calculated over all concentrations, but since it is
		% calculated in makePlots for each concentration, this will
		% work even if that scheme is changed
		fitStats = [fitStats; ...
			{fullfile(testPath, 'initParams.xls'), ...
			fullfile(testContPath, 'fittedParams.xls'), ...
			k, mean(AICc), output.iterations}]; %#ok<AGROW>
	end
end
saveParamStats(allFittedParams, paramHeaders, expPath, 'paramStats.csv');
saveParamStats(allInitParams, paramHeaders, expPath, 'initParamStats.csv');
saveFitStats(fitStats, expPath);

if (isfield(scriptSettings, 'removeBadFits'))
	if (scriptSettings.removeBadFits)
		[allFittedParams, allInitParams] ...
			= removeBadFits(allFittedParams, allInitParams, AICc);
	end
end

mkdir([expPath, '/figs/fit_statistics'])
saveParamPlots(allFittedParams, allInitParams, ...
	[expPath, '/figs/fit_statistics'], scriptSettings.displayStatPlots);
saveStatPlots(fitStats, [expPath, '/figs/fit_statistics'], ...
	scriptSettings.displayStatPlots);

close all;
cleanUp();
end
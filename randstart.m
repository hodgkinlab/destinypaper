function randstart(inputPath, resultsPath, dataFile, paramFile)
% folder for results
scriptSettings.outputPath = fullfile(resultsPath, mfilename());

% specify the name of the measured data file
scriptSettings.dataFileName = fullfile(inputPath, dataFile);

% specify the name of the parameter guess file
scriptSettings.paramFileName = fullfile(inputPath, paramFile);

% fit using log likelihood maximization
scriptSettings.useLogLikeFit = false;

% number of iterations of optimization algorithm (see [optimset] funciton)
scriptSettings.maxIterNum = 1000;

% create new datapoints by resampling the existing ones
scriptSettings.dataResampling = false;

% use random starting parameters
scriptSettings.randomStart = true;

% set the number of experiments to be run with each set of parameters
scriptSettings.numFitCases = 30;

% specify a range of fitting context values to try (e.g., err. tolerance)
scriptSettings.fitContext = 1;

% display plots of various statistics about the fits. These will be saved
% whether or not this option is enabled
scriptSettings.displayStatPlots = false;

% do stuff
cyton_fitter(scriptSettings);
find_best_fits(scriptSettings);
best_fit_preds(scriptSettings);
best_fit_stats(scriptSettings);
end

function find_best_fits(scriptSettings)
global measuredData;
global modelParams;
global appContext;
global idxPar;
numTopFits = 5;

fprintf('find_best_fits\n');

% this initiates global variables
initialise(); % [appContext] is loaded from the code folder

if (isfield(scriptSettings, 'appContextFile')) % override it if required
	appContext.sSettingsFile = scriptSettings.appContextFile;
	loadAppContext();
end
% override desired [appContext] fields
appContext.useLogLikeFit = scriptSettings.useLogLikeFit;
appContext.maxIterNum = scriptSettings.maxIterNum;

loadMeasuredData(scriptSettings.dataFileName);
loadParameters(scriptSettings.paramFileName);

fittedParams = xlsread( ...
	fullfile(scriptSettings.outputPath, 'paramStats.csv'));
fittedParams = fittedParams(3:end,:);
vIdxMeans = [ ...
	idxPar.uDivFirst, idxPar.uDthFirst, ...
	idxPar.uDivBlast, idxPar.uDthBlast];
fittedParams(vIdxMeans,:) = log(fittedParams(vIdxMeans,:));
numConc = size(fittedParams, 2) / scriptSettings.numFitCases;

fitDist = [];
%stats = [];
curStart = 1;
curStop = curStart + numConc - 1;
for j = 1:scriptSettings.numFitCases
	for k = scriptSettings.fitContext
		modelParams = fittedParams(:,curStart:curStop);
		appContext.errorTolerance = k;
		
		ctx.measuredData	= measuredData;
		ctx.appContext		= appContext;
		ctx.modelParams		= modelParams;
		ctx.idxPar			= idxPar;
		if (ctx.appContext.bLiveOnly)
			ctx.computeFunc = @computeModelLive;
		else
			ctx.computeFunc = @computeModel;
		end
		if (ctx.appContext.useLogLikeFit)
			ll = -computeNegLogLike(ctx);
			value = computeAICc(ll);
		else
			ctx.intercept = estimateIntercept( ...
				measuredData, ctx.appContext.errorTolerance);
			value = log( computeResiduals(ctx) );
		end
		fitDist = [fitDist; value]; %#ok<AGROW>
		
		%stats = [stats; mean(AICc)]; %#ok<AGROW>
		curStart = curStart + numConc;
		curStop = curStop + numConc;
	end
end

fprintf('\n\n');
disp(num2str(fitDist));
% disp(num2str(stats));
close all;
cleanUp();

startedParams = xlsread( ...
	fullfile(scriptSettings.outputPath, 'initParamStats.csv'));
startedParams = startedParams(3:end,:);

fittedParams(vIdxMeans,:) = exp(fittedParams(vIdxMeans,:));

bestStartedParams = NaN(size(modelParams, 1) + 1, numTopFits, numConc);
bestFittedParams = NaN(size(modelParams, 1) + 1, numTopFits, numConc);

[~, order] = sort(fitDist);
for idxTopFit = 1:numTopFits
	curIter = order(idxTopFit);
	for idxConc = 1:numConc
		curStartedParams = startedParams(:,(curIter - 1)*numConc + idxConc);
		curFittedParams = fittedParams(:,(curIter - 1)*numConc + idxConc);
		bestStartedParams(1,idxTopFit,idxConc) = fitDist(curIter);
		bestStartedParams(2:end,idxTopFit,idxConc) = curStartedParams;
		bestFittedParams(1,idxTopFit,idxConc) = fitDist(curIter);
		bestFittedParams(2:end,idxTopFit,idxConc) = curFittedParams;
	end
end
for idxConc = 1:numConc
	xlswrite(fullfile(scriptSettings.outputPath, 'top_started.xlsx'), ...
		squeeze(bestStartedParams(:,:,idxConc)),idxConc);
	xlswrite(fullfile(scriptSettings.outputPath, 'top_fitted.xlsx'), ...
		squeeze(bestFittedParams(:,:,idxConc)),idxConc);
end

identifiedStart = squeeze(bestStartedParams(:,1,:));
identifiedStart = identifiedStart(2:end,:);
range = sprintf('A2:%c%d', ('A' + numConc - 1), size(modelParams,1) + 1);
xlswrite(scriptSettings.paramFileName, identifiedStart, range);
end

function best_fit_preds(scriptSettings)
global measuredData;
global modelParams;
global appContext;
global idxPar;

fprintf('predict_totals\n');

% this initiates global variables
initialise(); % [appContext] is loaded from the code folder
loadMeasuredData(scriptSettings.dataFileName);
loadParameters(scriptSettings.paramFileName);

labels = {'time, h', 'total live', 'total drop.'};
numConc = size(modelParams, 2);
for idxConc = 1:numConc
	fittedParams = xlsread( ...
		fullfile(scriptSettings.outputPath, 'top_fitted.xlsx'), idxConc);
	fittedParams = fittedParams(2:end,1);
	vIdxMeans = [ ...
		idxPar.uDivFirst, idxPar.uDthFirst, ...
		idxPar.uDivBlast, idxPar.uDthBlast];
	fittedParams(vIdxMeans,:) = log(fittedParams(vIdxMeans,:));
	modelParams(:,idxConc) = fittedParams;
	
	ctx.measuredData	= measuredData;
	ctx.modelParams		= modelParams;
	ctx.appContext		= appContext;
	ctx.idxPar			= idxPar;
	predData = computeModel(ctx, idxConc);
	
	totalLive = predData{1}';
	times = totalLive(:,1);
	totalLive = totalLive(:,2:end);
	totalLive = sum(totalLive, 2);
	
	totalDrop = predData{3}';
	totalDrop = totalDrop(:,2:end);
	totalDrop = sum(totalDrop, 2);
	
	outTable = [times, totalLive, totalDrop];
	numTimes = numel(times);
	outRange = sprintf('A2:C%d', numTimes);
	xlswrite(fullfile(scriptSettings.outputPath, 'predicted.xlsx'), ...
		outTable, idxConc, outRange);
	xlswrite(fullfile(scriptSettings.outputPath, 'predicted.xlsx'), ...
		labels, idxConc, 'A1:C1');
end
end

function best_fit_stats(scriptSettings)
fittedParams = xlsread( ...
	fullfile(scriptSettings.outputPath, 'paramStats.csv'));
numConc = size(fittedParams, 2) / scriptSettings.numFitCases;

lastDiv = 300;
outParams = NaN(12, numConc);
ddStats = NaN(lastDiv + 2, numConc);
idxPar = initParamsOrder();
for idxConc = 1:numConc
	fittedParams = xlsread( ...
		fullfile(scriptSettings.outputPath, 'top_fitted.xlsx'), idxConc);
	curParam = fittedParams(2:end,1);
	vIdxMeans = [ ...
		idxPar.uDivFirst, idxPar.uDthFirst, ...
		idxPar.uDivBlast, idxPar.uDthBlast];
	curParam(vIdxMeans) = log(curParam(vIdxMeans));
	
	[u, v] = lognstat( ...
		curParam(idxPar.uDivFirst), curParam(idxPar.sDivFirst));
	curParam(idxPar.uDivFirst) = u;
	curParam(idxPar.sDivFirst) = sqrt(v);
	
	[u, v] = lognstat( ...
		curParam(idxPar.uDthFirst), curParam(idxPar.sDthFirst));
	curParam(idxPar.uDthFirst) = u;
	curParam(idxPar.sDthFirst) = sqrt(v);
	
	[u, v] = lognstat( ...
		curParam(idxPar.uDivBlast), curParam(idxPar.sDivBlast));
	curParam(idxPar.uDivBlast) = u;
	curParam(idxPar.sDivBlast) = sqrt(v);
	
	[u, v] = lognstat( ...
		curParam(idxPar.uDthBlast), curParam(idxPar.sDthBlast));
	curParam(idxPar.uDthBlast) = u;
	curParam(idxPar.sDthBlast) = sqrt(v);
	
	outParams(:,idxConc) = curParam(1:12);

	uGamma = curParam(idxPar.uGamma);
	sGamma = curParam(idxPar.sGamma);
	shape = (uGamma/sGamma)^2;
	scale = sGamma*sGamma/uGamma;
	cdfNums = gamcdf(0:lastDiv, shape, scale);
	
	probNums = diff(cdfNums);
	x = 0:(lastDiv - 1);
	meanDD = sum(x.*probNums);
	stdDD = sqrt( sum( ((x - meanDD).^2).*probNums ) );
	ddStats(:,idxConc) = [meanDD; stdDD; probNums(:)];
end
outFile = fullfile(scriptSettings.outputPath, 'best_fit_stats.xls');

paramLabels = { ...
	'mean time first div, h'; 'std time first div, h'; ...
	'mean time first death, h'; 'std time first death, h'; ...
	'mean time subseq div, h'; 'std time subseq div, h'; ...
	'mean time subseq death, h'; 'std time subseq death, h'; ...
	'prop activated'; 'mean of gamma'; 'std of gamma'; ...
	'starting cell num'};
range = sprintf('B1:%c12', 'B' + numConc - 1);
xlswrite(outFile, paramLabels, 'A1:A12');
xlswrite(outFile, outParams, range);

ddLabels = ...
	{'mean DD'; 'std DD'; 'pmf DD 0'; 'pmf DD 1'; 'pmf DD 2'; 'etc.'};
range = sprintf('B2:%c%d', 'B' + numConc - 1, lastDiv + 1 + 2);
xlswrite(outFile, {'the discrete DD distribution'}, 2, 'A1:A1');
xlswrite(outFile, ddLabels, 2, 'A2:A7');
xlswrite(outFile, ddStats, 2, range);
end
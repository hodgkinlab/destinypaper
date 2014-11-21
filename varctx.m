function varctx(inputPath, resultsPath, dataFile, paramFile)
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
scriptSettings.randomStart = false;

% set the number of experiments to be run with each set of parameters
scriptSettings.numFitCases = 1;

% specify a range of fitting context values to try (e.g., err. tolerance)
scriptSettings.fitContext = [0.25 0.5 1 2 4];

% display plots of various statistics about the fits. These will be saved
% whether or not this option is enabled
scriptSettings.displayStatPlots = false;

% do stuff
cyton_fitter(scriptSettings);
eval_treshold_eff(scriptSettings);
end

function eval_treshold_eff(scriptSettings)
fprintf('eval_treshold_eff\n');
numCtxVals = numel(scriptSettings.fitContext);

fittedParams = xlsread( ...
	fullfile(scriptSettings.outputPath, 'paramStats.csv'));
fittedParams = fittedParams(3:end,:);
numColumns = size(fittedParams, 2);
numConc = numColumns / numCtxVals;

labels = {'mean', 'st.dev.', 'coef.var.', '2.5 perc', '97.5 perc'};
rowStart = 2;
rowStop = rowStart + size(fittedParams, 1) - 1;
colStart = 'A';
colStop = colStart + numCtxVals - 1;
colStatStart = colStop + 2;
colStatStop = colStatStart + 4;
rangeData = sprintf('%c%d:%c%d', colStart, rowStart, colStatStop, rowStop);
rangeLabels = sprintf('%c1:%c1', colStatStart, colStatStop);
for idxConc = 1:numConc
	selector = idxConc:numConc:numColumns;
	curParams = fittedParams(:,selector);
	
	a = NaN(size(curParams, 1), 1);
	u = mean(curParams, 2);
	s = std(curParams, 0, 2);
	c = s./u;
	lo = prctile(curParams, 2.5, 2);
	hi = prctile(curParams, 97.5, 2);
	
	outData = [curParams, a, u, s, c, lo, hi];
	xlswrite( ...
		fullfile(scriptSettings.outputPath, 'ctx-val-fits.xlsx'), ...
		labels, idxConc, rangeLabels);
	xlswrite( ...
		fullfile(scriptSettings.outputPath, 'ctx-val-fits.xlsx'), ...
		outData, idxConc, rangeData);
end
end
function bootstrap(inputPath, resultsPath, dataFile, paramFile)
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
scriptSettings.dataResampling = true;

% use random starting parameters
scriptSettings.randomStart = false;

% set the number of experiments to be run with each set of parameters
scriptSettings.numFitCases = 30;

% specify a range of fitting context values to try (e.g., err. tolerance)
scriptSettings.fitContext = 1;

% display plots of various statistics about the fits. These will be saved
% whether or not this option is enabled
scriptSettings.displayStatPlots = false;

% do stuff
cyton_fitter(scriptSettings);
compute_conf_int(scriptSettings);
end

function compute_conf_int(scriptSettings)
fprintf('compute_conf_int\n');
inPath = scriptSettings.outputPath;
outDataFile = fullfile(inPath, 'bootstrapped.xls');
outSumFile = fullfile(inPath, 'summary.xls');
numFitCases = scriptSettings.numFitCases;
rangeLabels = 'A1:E1';
rangeData = 'A2:E15';

fittedParams = xlsread(fullfile(inPath, 'paramStats.csv'));
fittedParams = fittedParams(3:end,:);
numColumns = size(fittedParams, 2);
numConc = numColumns / numFitCases;

labels = {'mean', 'st.dev.', 'coef.var.', '2.5 perc', '97.5 perc'};
for idxConc = 1:numConc
	selector = idxConc:numConc:numColumns;
	curParams = fittedParams(:,selector);
	xlswrite(outDataFile, curParams, idxConc);
	
	u = mean(curParams, 2);
	s = std(curParams, 0, 2);
	c = s./u;
	lo = prctile(curParams, 2.5, 2);
	hi = prctile(curParams, 97.5, 2);	
	
	summary = [u, s, c, lo, hi];
	xlswrite(outSumFile, labels, idxConc, rangeLabels);
	xlswrite(outSumFile, summary, idxConc, rangeData);
end
end
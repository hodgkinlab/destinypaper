close all; clear variables; clearvars -global *; clc;
codePath = 'cyton fitter 6.1.5';
inputPath = '.';

if (1) % run log
	logFile = fullfile([mfilename(), '-log.txt']);
	if (exist(logFile, 'file') == 2)
		diary off;
		delete(logFile);
	end
	fclose( fopen(logFile, 'w') ); % make sure that file exists
	diary(logFile);
	fprintf('%s\n', datestr(now(), 'dd-mmm-yyyy HH:MM:SS'));
end

datasets = dir(fullfile(inputPath, 'input*'));
numData = numel(datasets);
for idxData = 1:numData
	dataset = datasets(idxData).name;
	fprintf('*** processing dataset [%s]\n', dataset);
	currPath = fullfile(inputPath, dataset);
	
	dataFile = dir(fullfile(currPath, '*input*'));
	dataFile = dataFile(1).name;
	fprintf('data file [%s]\n', dataFile);
	paramFile = dir(fullfile(currPath, '*param range*'));
	paramFile = paramFile(1).name;
	fprintf('params file [%s]\n', paramFile);
	
	timeStamp = datestr(now, 'yyyy-mm-dd_HH-MM-SS');
	resultsPath = ['results-', dataset, '__', timeStamp];
	mkdir(resultsPath);
	fprintf('results path [%s]\n', resultsPath);
	
	addpath(genpath(codePath));
	randstart(currPath, resultsPath, dataFile, paramFile);
	varctx(currPath, resultsPath, dataFile, paramFile);
	bootstrap(currPath, resultsPath, dataFile, paramFile);
	
	fprintf('\n');
end
diary off;
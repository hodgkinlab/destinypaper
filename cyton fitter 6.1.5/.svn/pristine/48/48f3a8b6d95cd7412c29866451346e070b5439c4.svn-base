%{
% An example annotated automatic fitting script
%
% Damian Pavlyshyn, Andrey Kan
%}
close all; clear variables; clearvars -global *; clc;

% set the name of the directory in which the results of the next series of
% tests will be saves. This directory should not already exist and will be
% created inside the parent directory by the autofitter
scriptSettings.outputPath = '..\..\fits to all data\testOutput';

% specify the name of the measured data file
scriptSettings.dataFileName = '..\..\fits to all data\input\EX105b live drop input.xlsx';

% specify the name of the parameter guess file
scriptSettings.paramFileName = '..\..\fits to all data\input\EX105b param range.xls';

% specify the path to cyton_fitter code
scriptSettings.fitterCode = '.';

% fit using log likelihood maximization
scriptSettings.useLogLikeFit = true;

% number of iterations of optimization algorithm (see [optimset] funciton)
scriptSettings.maxIterNum = 1000;

% create new datapoints by resampling the existing ones
scriptSettings.dataResampling = false;

% use random starting parameters
scriptSettings.randomStart = false;

% set the number of experiments to be run with each set of parameters
scriptSettings.numFitCases = 3;

% specify a range of fitting context values to try (e.g., err. tolerance)
scriptSettings.fitContext = [0.5 1];

% when plotting statistics, ignore results of very poor fits
%scriptSettings.removeBadFits = false;

% display plots of various statistics about the fits. These will be saved
% whether or not this option is enabled
scriptSettings.displayStatPlots = false;

% do stuff
addpath(scriptSettings.fitterCode); 
cyton_fitter(scriptSettings);
%{
% Tests the similarity in measurements produced by computed by given
% simulator and modeller functions
%
% INPUTS:
%	- simulator: function handle for simulator
%	- modeller: function handle for modeller
%	- (optional): function handle for metric comparing two function y-value
%	  sets
%
% OUTPUTS: diff: difference value calculated by the metric
%
% SIDE EFFECTS: prints whether the test passes or fails
%
% AUTHOR: Damian Pavlyshyn (pavlyshyn.d@wehi.edu.au)
%}

function [modDiff, model, simAll, modelFitParams, simFitParams] = ...
	paramAutoTest(simulator, modeller, varargin)
	global idxPar;
	global modelParams;
	global userSettings; % get rid of this
	global idxSet; % get rid of this
	
	%%%%%%%%%%%%%%%%%%%%%% MODEL SIMILARITY TESTING %%%%%%%%%%%%%%%%%%%%%%%
	
	% TBD - this should be grouped with the metric function and passed as
	% an argument
	errTolerance = 0.02; % Just an intuitive value, nothing empirical
	
	if nargin >= 2;
		metric = @constScaleMetric;
	else
		metric = varargin{1};
	end
	
	ctx = ctxGet();
	model = modeller(ctx, 1);
	mLivePred = model{ctx.measuredData.idx.live};
	mDeadPred = model{ctx.measuredData.idx.dead};
	mDropPred = model{ctx.measuredData.idx.drop};
	
	% TBD - arguments specific to cell_sim
	simAll = simulator(1, 0, modelParams, userSettings, idxPar, idxSet);
	mLiveSim = simAll{1};
	mDeadSim = simAll{2};
	mDropSim = simAll{3};

	diffLive = metric(sum(mLivePred(2:end,:)), sum(mLiveSim(2:end,:)));
	diffDead = metric(sum(mDeadPred(2:end,:)), sum(mDeadSim(2:end,:)));
	diffDrop = metric(sum(mDropPred(2:end,:)), sum(mDropSim(2:end,:)));
	
	modDiff = mean([diffLive, diffDead, diffDrop]);
	
	if abs(modDiff) < errTolerance
		fprintf('Pass model test\n');
	else
		fprintf('Fail model test\n');
	end
	
	%%%%%%%%%%%%%%%%%%%% PARAMETER SIMILARITY TESTING %%%%%%%%%%%%%%%%%%%%%
	model = wrapData(model);
	simAll = wrapData(simAll);
	
	modelFitParams = fitParameters(model, userSettings, modelParams, ... 
		idxSet, idxPar, 0);
	simFitParams = fitParameters(simAll, userSettings, modelParams, ... 
		idxSet, idxPar, 0);
	
	% The following comparison standard is specific to the format of the
	% params vector. If this format is changed, the comparison standards
	% must be changed as well
	
	modelParPass = compareParams(modelFitParams, modelParams, idxPar);
	simParPass = compareParams(simFitParams, modelParams, idxPar);
	
	if modelParPass == 1;
		fprintf('Pass modelled parameters\n');
	else
		fprintf('Fail modelled parameters\n');
	end
	
	if simParPass == 1;
		fprintf('Pass simulated parameters\n');
	else
		fprintf('Fail simulated parameters\n');
	end
end


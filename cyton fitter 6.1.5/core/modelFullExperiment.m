%{
% Models an experiment, providing noisy readings at given timepoints
%
% INPUTS:
%	- ctx: context struct. Should contain modelParams, measuredData,
%	  idxSet, idxPar, userSettings
%	- curConc: index of concentration of interest
%	- repeats: number of repeats to be simiulated for each timepoint
%	- times (optional): a vector of the timepoints that the simulated
%	  measurements are made. If no value is provided, the function will use
%	  the timepoits in ctx.measuredData
%
% OUTPUTS: expData: model structure
%
% ASSUMPTIONS:
%	- there is at least one reading in ctx.measuredData
%
% AUTHOR: Damian Pavlyshyn (pavlyshyn.d@wehi.edu.au)
%}

function expData = modelFullExperiment( ctx, curConc, repeats, varargin )
	measuredData	= ctx.measuredData;
	kVar = 1.2; % This value generates an appropriate amount of noise
	
	if nargin >= 4
		times = varargin{1};
	else
		neIdx = find(~cellfun(@isempty, measuredData.data), 1);
		times = unique(measuredData.data{neIdx}(1,:));
	end
	
	%ctx.userSettings(ctx.idxSet.maxEvalTime) = times(end);
	model = computeModel(ctx, curConc);
	
	expModel = cell(1, measuredData.idx.last);
	for ii = 1:measuredData.idx.last
		expModel{ii} = getAtTimes(model, times, repeats, ii);
	end
	
	expData = wrapData(expModel);
	
	expData = addNoise(expData, kVar);
end


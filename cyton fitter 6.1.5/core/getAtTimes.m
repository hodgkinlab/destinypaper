%{
% Extracts values of model at times provided
%
% INPUTS:
%	- model: model with dense timepoints
%	- times: vector of relevant times
%	- repeats: number of repeated simulated experiments for each timepoint
%	- state: state of model (usually live = 1, dead = 2, dropped = 3)
%
% OUTPUTS
%	- briefModel: numbers of live, dead and droppes cells at the times in
%	  times provided in valid model format
%
% AUTHOR: Damian Pavlyshyn (pavlyshyn.d@wehi.edu.au)
%}

function briefModel = getAtTimes( model, times, repeats, state )

	briefModel = zeros(size(model{state}, 1), repeats*numel(times));
	
	for ii=1:numel(times);
		briefModel(:, repeats*(ii-1)+1 : repeats*ii) = ...
			repmat(findClosest(model, times(ii), state),1,repeats);
	end

end

function vClosest = findClosest(model, t, state)
	times = model{state}(1,:);
	[~, minPos] = min(abs(times - t));
	vClosest = model{state}(:, minPos);
end


%{
% Generates random parameters that are uniformly distributed with limits
% provided in [paramLims]
%}
function outParams = generateParVariable(paramLims, numConc)
if (numConc ~= size(paramLims.lb, 2))
	if (size(paramLims.lb, 2) == 1)
		warning('Single parameter guess set loaded. Used for all concentrations');
		paramLims.lb = repmat(paramLims.lb, [1, numConc]);
		paramLims.ub = repmat(paramLims.ub, [1, numConc]);
	else
		error('Number of parameter guess sets incompatible with number of concentrations');
	end
end
randoms = rand(size(paramLims.lb));
outParams = paramLims.lb + randoms.*(paramLims.ub - paramLims.lb);
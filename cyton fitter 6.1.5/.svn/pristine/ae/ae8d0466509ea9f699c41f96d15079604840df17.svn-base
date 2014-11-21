%{
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013 ~ 2014
%}
function cost = computeObjFun(ctx, x, computeCost, ...
	sourceIdx, fixedMap, lockedMap, lockedVal)
nConc = ctx.szParams(2);
ctx.modelParams = NaN(ctx.szParams);
ctx.modelParams(sourceIdx) = x;
ctx.modelParams(lockedMap) = lockedVal;
fixedVal = repmat(ctx.modelParams(fixedMap(:,end), 1), 1, (nConc - 1));
ctx.modelParams(fixedMap) = fixedVal;
cost = computeCost(ctx);
end
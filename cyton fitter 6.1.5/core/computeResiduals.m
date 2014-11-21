%{
% compute weighted sum of squared residuals
%
% ctx.measuredData;
% ctx.appContext -- parameters of fitting process
% ctx.modelParams;
% ctx.idxPar;
% ctx.varCoeffs -- model of variances
% ctx.computeFunc -- function for computing model predictions
%
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013
%}
function wssr = computeResiduals(ctx)
nConc = size(ctx.modelParams, 2);
wssr = 0;

if (ctx.appContext.bLiveOnly)
	nTypes = 1;
else
	nTypes = ctx.measuredData.idx.last;
end
for iConc = 1:nConc
	predictedData = ctx.computeFunc(ctx, iConc);
	wssr = wssr + computeResidualsConc( ...
		iConc, nTypes, predictedData, ctx);
end
end
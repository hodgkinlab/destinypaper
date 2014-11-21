%{
% ctx.measuredData;
% ctx.appContext -- parameters of fitting process
% ctx.modelParams;
% ctx.idxPar;
% ctx.varCoeffs -- model of variances
% ctx.maxVals -- maximum measurements per time point
% ctx.computeFunc -- function for computing model predictions
%
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013 ~ 2014
%}
function ll = computeNegLogLike(ctx)
ll = 0;
nConc = size(ctx.modelParams, 2);
varCoeffs = ctx.measuredData.varCoeffs;
maxVals = ctx.measuredData.maxVals;
idx = ctx.measuredData.idx;

if (ctx.appContext.bLiveOnly)
	nTypes = 1;
else
	nTypes = idx.last;
end
for iType = 1:nTypes
	allObsData = ctx.measuredData.data{iType};
	if (isempty(allObsData))
		continue;
	end
	for iConc = 1:nConc
		pow = varCoeffs(iType, iConc);
		
		predData = ctx.computeFunc(ctx, iConc);
		predData = predData{iType};
		
		obsData = squeeze(allObsData(:,:,iConc));
		obsData = obsData(:,~isnan(obsData(1,:)));
		
		lastRow = size(obsData, 1);
		predData(lastRow,:) = sum(predData(lastRow:end,:), 1);
		
		predTimes = predData(1,:);
		repMeasTimes = obsData(1,:);
		measTimes = unique(repMeasTimes);
		numTimes = numel(measTimes);
		
		for iRow = 2:lastRow
			curMeans = interp1(predTimes, predData(iRow,:), measTimes);
			for iTime = 1:numTimes
				selector = (measTimes(iTime) == repMeasTimes);
				points = obsData(iRow,selector);
				
				% this could be computed outside of all loops
				%currTol = (ctx.appContext.errorTolerance) ...
				%	*maxVals(iTime, iConc, iType)/100;
				%addUps = currTol^2;
				
				estMu = curMeans(iTime);
				%estUps = estMu .^ pow;
				%estUps = estUps + addUps;
				estUps = exp(-3.53).*estMu.^1.79 + ctx.intercept;
                ssr = nansum( (points - estMu).^2 );
				n = sum(~isnan(points));
				
				% truncated gaussian, note that log(2*pi) = 1.8379
				S = 0.5 + 0.5*erf( estMu/sqrt(2*estUps) );
				ll = ll - n*1.8379 - n*log(estUps) - ssr/estUps - 2*log(S);
			end
		end
	end
end
ll = -ll/2;
end
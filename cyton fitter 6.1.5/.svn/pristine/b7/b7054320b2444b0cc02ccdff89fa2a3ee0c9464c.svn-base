%{
% Compute AIC with a correction for finite sample sizes (AICc)
% This is computed for the current data and parameter settings,
% and takes into accout all concentrations
%
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013 ~ 2014
%}
function AICc = computeAICc(logLike)
global allHandles;
global modelParams;
global measuredData;
global appContext;
global fromGUI;
global idxPar;

% compute the number of free parameters
if (fromGUI)
    [vLocked, vFixed] = getLockedFixed(allHandles, idxPar);
else
    vLocked = appContext.vLockParam;
    vFixed = appContext.vFixParam;
end

fixNotLock = vFixed & (~vLocked);
nFixNotLock = sum(fixNotLock);
nLocked = sum(vLocked);
nParam = size(modelParams, 1);
nConc = size(modelParams, 2);
nFree1 = nParam - nLocked - nFixNotLock;
k = nFree1*nConc + nFixNotLock;

% compute the total number of samples
n = 0;
if (appContext.bLiveOnly)
	nTypes = 1;
else
	nTypes = measuredData.idx.last;
end
for iType = 1:nTypes
	allObsData = measuredData.data{iType};
	if (~isempty(allObsData))
		for iConc = 1:nConc
			obsData = squeeze(allObsData(:,:,iConc));
			obsData = obsData(2:end,:);
			sampleMap = ~isnan(obsData);
			n = n + sum(sampleMap(:));
		end
	end
end

AICc = 2*k - 2*logLike + (2*k*(k + 1))/(n - k - 1);
%fprintf('AICc = %0.3f\n', AICc);
end
%{
% plain gaussian model: estimate variance
function v = varPlainGauss(errClass, ~)
v = errClass.rss / errClass.num;
end

% plain gaussian model: estimate log-likelihood
function logLike = logLikePlainGauss(~, vars, nums, RSSs)
logLike = nansum( -nums.*log(sqrt(2.*pi.*vars)) - RSSs./(2.*vars) );
end

% truncated gaussian model: estimate variance
function v = varTruncGauss(errClass, points)
m = errClass.mean;
s0 = std([points, m]);

pdfTrunc = @(x, s) normpdf(x, m, s) ./ (1 - normcdf(0, m, s));
sEst = mle(points, 'pdf', pdfTrunc, 'start', s0, 'lower', realmin);

%pdfTrunc = @(s) -sum( log( normpdf(points, m, s) ./ (1 - normcdf(0, m, s)) ) );
%sEst = fmincon(pdfTrunc, s0, [], [], [], [], realmin, Inf);

v = sEst^2;
end

% plain gaussian model: estimate log-likelihood
function logLike = logLikePlainTrunc(means, vars, nums, RSSs)
logLike = nansum( -nums.*log(sqrt(2.*pi.*vars)) - RSSs./(2.*vars) ...
	- nums.*log(0.5 + 0.5.*erf(means ./ sqrt(2.*vars))) );
end

% lognormal model: estimate variance
function v = varLognormal(errClass, points)
v = 2*( log(errClass.mean) - mean(log(points)) );
if (v <= 0)
	v = NaN;
end
end
%}
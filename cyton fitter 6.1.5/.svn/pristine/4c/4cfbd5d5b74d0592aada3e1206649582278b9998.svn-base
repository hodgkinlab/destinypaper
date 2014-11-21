%{
% Non-linear least squares fit to data
%
% Locking a parameter means that the parameter's value (for
% any concentration) must not change during optimization.
%
% Fixing a parameter means that the parameter's values must
% remain the same across concentrations. Fixed parameters are
% expected to have same values across concentrations
% before optimization starts.
%
% Called in fitter_multi_gui by pushbutton_fit_Callback
%
% INPUTS:
%	- measuredData: cell number data in format provided by loadMeasuredData
%	  and wrapData
%	- appContext: settings struct
%	- modelParams: matrix of parameter values in format provided by
%	  loadParameters and generateParams
%	- idxPar: struct of parameter indices
%	- (optional) vLocked: vector of locked parameter indices
%	- (optional) vFixed: vector of fixed parameter indices
%	- if called without optional args, will read from ./boxSettings.txt
%
% OUTPUTS: fitted parameters
%}
function [newModelParams, output] = nllsqFit( ...
	measuredData, appContext, ...
	modelParams, paramBounds, ...
	idxPar, dDisp, vLocked, vFixed)

if (isempty(measuredData.data{measuredData.idx.live}))
	return
end
if (measuredData.maxTime > appContext.maxEvalTime)
	sMsg ...
		= ['Maximum time in data is larger than ', ...
		'maximum time for modelling.Doing nothing.'];
	msgbox(sMsg, 'Attention', 'warn', 'modal');
	return
end

ctx.measuredData	= measuredData;
ctx.appContext		= appContext;
ctx.idxPar			= idxPar;
ctx.szParams		= size(modelParams);

lb = paramBounds.lb;
ub = paramBounds.ub;

nConc = size(modelParams, 2);
vFixed = vFixed & ~vLocked;
fixedMap = logical( repmat(vFixed, 1, nConc) );
fixedMap(:,1) = false;

x0 = modelParams;
sourceIdx = reshape(1:numel(modelParams), size(modelParams));

lockedRows = find(vLocked);
x0(lockedRows,:) = [];
lb(lockedRows,:) = [];
ub(lockedRows,:) = [];
sourceIdx(lockedRows,:) = [];
reducedFixedMap = fixedMap;
reducedFixedMap(lockedRows,:) = [];

x0 = x0(:);
lb = lb(:);
ub = ub(:);
sourceIdx = sourceIdx(:);
reducedFixedMap = reducedFixedMap(:);
x0(reducedFixedMap) = [];
lb(reducedFixedMap) = [];
ub(reducedFixedMap) = [];
sourceIdx(reducedFixedMap) = [];

lockedMap = logical( repmat(vLocked, 1, nConc) );
lockedVal = modelParams(lockedMap);

if dDisp
	sDisp = 'iter';
else
	sDisp = 'off';
end
nIter	= appContext.maxIterNum;
nEval	= appContext.maxIterNum*appContext.maxEvalsIter;
tolFun	= appContext.fitTolFun;
tolX	= appContext.fitTolX;
algName	= 'interior-point';
options = optimset('Maxiter', nIter, 'MaxFunEvals', nEval, ...
	'TolFun', tolFun, 'TolX', tolX, 'Algorithm', algName, ...
	'Display', sDisp, 'UseParallel', 'always');

if (ctx.appContext.bLiveOnly)
	ctx.computeFunc = @computeModelLive;
else
	ctx.computeFunc = @computeModel;
end
ctx.intercept = estimateIntercept(measuredData, ctx.appContext.errorTolerance);
if (ctx.appContext.useLogLikeFit)
	objFun = @(x) computeObjFun(ctx, x, @computeNegLogLike, ...
		sourceIdx, fixedMap, lockedMap, lockedVal);
else
	%ctx.intercept = estimateIntercept(measuredData, ctx.appContext.errorTolerance);
    objFun = @(x) computeObjFun(ctx, x, @computeResiduals, ...
		sourceIdx, fixedMap, lockedMap, lockedVal);
end
[x, ~, ~, output] = fmincon(objFun, x0, [], [], [], [], lb, ub, [], options);

newModelParams = NaN(size(modelParams));
newModelParams(sourceIdx) = x;
newModelParams(lockedMap) = lockedVal;
fixedVal = repmat(newModelParams(fixedMap(:,end), 1), 1, (nConc - 1));
newModelParams(fixedMap) = fixedVal;
end
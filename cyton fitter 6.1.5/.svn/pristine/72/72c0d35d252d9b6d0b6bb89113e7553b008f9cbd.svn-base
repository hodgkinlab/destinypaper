%{
% Reads data from global variables and plots the predicted and observed
% values of the following:
% 1) Time vs. number of live and dropped cells
% 2) Time vs. number of dead cells
% 3) Time vs. number of live cells in a certain division for each division
% 4) Time vs. number of dead cells in a certain division for each division
% 5) Time vs. number of drop cells in a certain division for each division
%
% Called in fitter_mult_gui by pushbutton_plot_Callback
%
% INPUTS: curConc: selected concentration
%
% OUTPUT: fitDist: discrepancy of the fit
%}
function [label, value] = makePlots(curConc, areVisible)
global measuredData;
global appContext;
global modelParams;
global idxPar;

ctx.measuredData	= measuredData;
ctx.appContext		= appContext;
ctx.modelParams		= modelParams;
ctx.idxPar			= idxPar;

if (ctx.appContext.bLiveOnly)
	updateplots(curConc, computeModelLive(ctx, curConc), areVisible);
	ctx.computeFunc = @computeModelLive;
else
	updateplots(curConc, computeModel(ctx, curConc), areVisible);
	ctx.computeFunc = @computeModel;
end
ctx.intercept = estimateIntercept(measuredData, ctx.appContext.errorTolerance);
if (ctx.appContext.useLogLikeFit)
	ll = -computeNegLogLike(ctx);
	value = computeAICc(ll);
	label = 'AICc';
else
	%ctx.intercept = estimateIntercept(measuredData, ctx.appContext.errorTolerance);
	value = log( computeResiduals(ctx) );
	label = 'log(WSSR)';
end
end
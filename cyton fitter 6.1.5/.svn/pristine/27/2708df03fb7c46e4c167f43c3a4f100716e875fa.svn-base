%{
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013
%}
function uiUpdateParamPlots(handles)
global appContext;
global modelParams;
global idxPar;

curConc		= get(handles.listboxConcs, 'Value');
curParams	= modelParams(:,curConc);

timeStep		= appContext.numTimeSteps;
uiLongPercnt	= appContext.uiLognPercnt;
uiMaxTimeAxis	= appContext.uiMaxTimeAxis;
% bLognDest		= appContext.bLognDestiny;
lastDivModel	= appContext.maxEvalDiv;
minDestProb		= appContext.minDestProb;

uDivFirst = curParams(idxPar.uDivFirst);
sDivFirst = curParams(idxPar.sDivFirst);
uDthFirst = curParams(idxPar.uDthFirst);
sDthFirst = curParams(idxPar.sDthFirst);
uDivBlast = curParams(idxPar.uDivBlast);
sDivBlast = curParams(idxPar.sDivBlast);
uDthBlast = curParams(idxPar.uDthBlast);
sDthBlast = curParams(idxPar.sDthBlast);

% distributions for undivided cells
max1 = logninv(uiLongPercnt, uDivFirst, sDivFirst);
max2 = logninv(uiLongPercnt, uDthFirst, sDthFirst);
maxTime = max(max1, max2);
if (isnan(maxTime))
	maxTime = 1;
end
maxTime = min(maxTime, uiMaxTimeAxis);
vTime = linspace(0, maxTime, timeStep)';
vDivFirstPDF = lognpdf(vTime, uDivFirst, sDivFirst);
vDthFirstPDF = lognpdf(vTime, uDthFirst, sDthFirst);
plot(handles.axes_undiv, vTime, [vDivFirstPDF, -vDthFirstPDF]);
xlim(handles.axes_undiv, [0, maxTime]);

% distributions for dividing cells
max1 = logninv(uiLongPercnt, uDivBlast, sDivBlast);
max2 = logninv(uiLongPercnt, uDthBlast, sDthBlast);
maxTime = max(max1, max2);
if (isnan(maxTime))
	maxTime = 1;
end
maxTime = min(maxTime, uiMaxTimeAxis);
vTime = linspace(0, maxTime, timeStep)';
vDivBlastPDF = lognpdf(vTime, uDivBlast, sDivBlast);
vDthBlastPDF = lognpdf(vTime, uDthBlast, sDthBlast);
plot(handles.axes_blast, vTime, [vDivBlastPDF, -vDthBlastPDF]);
xlim(handles.axes_blast, [0, maxTime]);

% progressor fraction
[progFrac, tailDistr] = computeProgFrac( ...
	lastDivModel, minDestProb, curParams(idxPar.gamma0:idxPar.sGamma));
lastDiv = numel(tailDistr) - 1;
bar(handles.axes_gamma, 0:lastDiv, tailDistr);
hold on;
plot(handles.axes_gamma, 0:lastDiv, progFrac(1:(lastDiv + 1)), '-ro');
xlim([0, lastDiv]);
ylim([0, 1]);
hold off;
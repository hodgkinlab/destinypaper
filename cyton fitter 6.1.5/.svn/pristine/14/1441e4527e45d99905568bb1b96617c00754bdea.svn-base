%{
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013
%}
function uiSetUserSettings(handles)
global appContext;
set(handles.edit_Tsteps,	'String', num2str(appContext.numTimeSteps));
set(handles.edit_Tmax,		'String', num2str(appContext.maxEvalTime));
set(handles.edit_Totgen,	'String', num2str(appContext.maxEvalDiv));
set(handles.edit_max_it,	'String', num2str(appContext.maxIterNum));
set(handles.editErrTol,		'String', num2str(appContext.errorTolerance));
set(handles.checkLogLikeFit,'Value', appContext.useLogLikeFit);
%set(handles.checkLiveOnly,	'Value', appContext.bLiveOnly);
if (appContext.useLogLikeFit)
	set(handles.textFitDist, 'String', 'AICc');
	set(handles.textFitPar, 'String', '%, error tol.');
else
	set(handles.textFitDist, 'String', 'log(WSSR)');
	set(handles.textFitPar, 'String', 'min weight');
end
end
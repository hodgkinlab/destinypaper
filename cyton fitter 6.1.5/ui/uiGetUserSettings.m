%{
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013
%}
function uiGetUserSettings(handles)
global appContext;
appContext.numTimeSteps = str2double(get(handles.edit_Tsteps, 'String'));
appContext.maxEvalTime	= str2double(get(handles.edit_Tmax, 'String'));
appContext.maxEvalDiv	= str2double(get(handles.edit_Totgen, 'String'));
appContext.maxIterNum	= str2double(get(handles.edit_max_it, 'String'));
appContext.errorTolerance = str2double(get(handles.editErrTol, 'String'));
appContext.useLogLikeFit = get(handles.checkLogLikeFit, 'Value');
%appContext.bLiveOnly	= get(handles.checkLiveOnly, 'Value');
end
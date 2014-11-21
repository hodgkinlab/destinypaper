%{
% Runs nllsqFit on data contained in various global variables
%
% Should not be run from GUI, since it taked locked and fixed parameters
% from appContext rather than from checkbox handles.
%}

function output = runFitter()
global modelParams
global paramBounds
global measuredData
global appContext
global idxPar

vLocked = appContext.vLockParam;
vFixed = appContext.vFixParam;

[modelParams, output] = nllsqFit(...
    measuredData, appContext, modelParams, paramBounds, ...
	idxPar, 1, vLocked, vFixed);

end


%{
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013
%
% FITTER_MULTI_GUI M-file for fitter_multi_gui.fig
%      FITTER_MULTI_GUI, by itself, creates a new FITTER_MULTI_GUI or raises the existing
%      singleton*.
%
%      H = FITTER_MULTI_GUI returns the handle to a new FITTER_MULTI_GUI or the handle to
%      the existing singleton*.
%
%      FITTER_MULTI_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FITTER_MULTI_GUI.M with the given input arguments.
%
%      FITTER_MULTI_GUI('Property','Value',...) creates a new FITTER_MULTI_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before branching_gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fitter_multi_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Edit the above text to modify the response to help fitter_multi_gui
%
% Last Modified by GUIDE v2.5 15-Jan-2014 12:42:19
%}
function varargout = fitter_multi_gui(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
	'gui_Singleton',  gui_Singleton, ...
	'gui_OpeningFcn', @fitter_multi_gui_OpeningFcn, ...
	'gui_OutputFcn',  @fitter_multi_gui_OutputFcn, ...
	'gui_LayoutFcn',  [] , ...
	'gui_Callback',   []);
if nargin && ischar(varargin{1})
	gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
	[varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
	gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
end


%%%%%%%%%%  initialization/output  %%%%%%%%%%
%{
% Executes just before fitter_multi_gui is made visible
%
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fitter_multi_gui (see VARARGIN)
%}
function fitter_multi_gui_OpeningFcn(hObject, ~, handles)
global checkboxHandles;
global allHandles;
global appContext;
global idxPar;
global fromGUI;

fromGUI = 1;

addpath('core', 'cmi', 'ui');

% If called from wrong directory will inform user of that problem
try
	initialise();
catch err
	if (strcmp(err.identifier,'MATLAB:UndefinedFunction') &&...
			~any(strfind(pwd, 'code')-numel(pwd)-numel('code')+1))
		error('cyton:incorrect_directory',...
			[err.message, '\n''fitter_multi_gui.m'' not called from /trunk/code']);
	end
	rethrow(err);
end

%{
if (exist('matlabpool', 'file') == 2)
	nWorkers = feature('numCores');
	nActive = matlabpool('size');
	if ((nWorkers > 1) && (nWorkers > nActive))
		if (nActive > 0)
			matlabpool('close');
		end
		fprintf('opening a pool with %d workers\n', nWorkers);
		matlabpool('open', nWorkers);
	end
end
%}

%appContext.softwareVersion = '6.1.0';
set(hObject, 'Name', ...
	sprintf('Cyton fitter, v.%s', appContext.softwareVersion));
handles.output = hObject;
guidata(hObject, handles);

% start with a contracted main window
set(hObject, 'Units', 'pixels');
set(handles.btnExpand, 'UserData', 1);
btnExpand_Callback(handles.btnExpand);

%{
measuredData.idx		= initDataOrder();
measuredData.data		= cell(1, measuredData.idx.last);
measuredData.sDataType	= {'live', 'dead', 'drop'};
measuredData.vConc		= [];
measuredData.maxTime	= [];

modelParams = [];
idxPar = initParamsOrder();
setDefaultModelParams();

appContext.sSettingsFile = 'settings.mat';
loadAppContext();
%}

set(handles.listboxConcs, 'String', '?');
set(handles.listboxConcs, 'Value', 1);

uiSetUserSettings(handles);
updategui(handles);

% callbacks for model parameter controls
if (1)
	set(handles.edit_div_mu_undiv,		'UserData', idxPar.uDivFirst);
	set(handles.edit_div_sigma_undiv,	'UserData', idxPar.sDivFirst);
	set(handles.edit_death_mu_undiv,	'UserData', idxPar.uDthFirst);
	set(handles.edit_death_sigma_undiv, 'UserData', idxPar.sDthFirst);
	set(handles.edit_div_mu_blast,		'UserData', idxPar.uDivBlast);
	set(handles.edit_div_sigma_blast,	'UserData', idxPar.sDivBlast);
	set(handles.edit_death_mu_blast,	'UserData', idxPar.uDthBlast);
	set(handles.edit_death_sigma_blast,	'UserData', idxPar.sDthBlast);
	set(handles.edit_gamma_0,			'UserData', idxPar.gamma0);
	set(handles.edit_mu_gamma,			'UserData', idxPar.uGamma);
	set(handles.edit_sigma_gamma,		'UserData', idxPar.sGamma);
	set(handles.edit_scale,				'UserData', idxPar.scale);
	set(handles.editNumZombie,			'UserData', idxPar.numZombie);
	set(handles.editMechDecay,			'UserData', idxPar.mechDecay);
	
	set(handles.edit_div_mu_undiv,		'Callback', @modelParamsCallback);
	set(handles.edit_div_sigma_undiv,	'Callback', @modelParamsCallback);
	set(handles.edit_death_mu_undiv,	'Callback', @modelParamsCallback);
	set(handles.edit_death_sigma_undiv, 'Callback', @modelParamsCallback);
	set(handles.edit_div_mu_blast,		'Callback', @modelParamsCallback);
	set(handles.edit_div_sigma_blast,	'Callback', @modelParamsCallback);
	set(handles.edit_death_mu_blast,	'Callback', @modelParamsCallback);
	set(handles.edit_death_sigma_blast, 'Callback', @modelParamsCallback);
	set(handles.edit_gamma_0,			'Callback', @modelParamsCallback);
	set(handles.edit_mu_gamma,			'Callback', @modelParamsCallback);
	set(handles.edit_sigma_gamma,		'Callback', @modelParamsCallback);
	set(handles.edit_scale,				'Callback', @modelParamsCallback);
	set(handles.editNumZombie,			'Callback', @modelParamsCallback);
	set(handles.editMechDecay,			'Callback', @modelParamsCallback);
end

% load checkbox settings
if(1)
	vLock = appContext.vLockParam;
	vFix = appContext.vFixParam;
	
	set(handles.checkbox_mu_div_undiv,		'Value', vLock(idxPar.uDivFirst));
	set(handles.checkbox_sigma_div_undiv,	'Value', vLock(idxPar.sDivFirst));
	set(handles.checkbox_mu_death_undiv,	'Value', vLock(idxPar.uDthFirst));
	set(handles.checkbox_sigma_death_undiv, 'Value', vLock(idxPar.sDthFirst));
	set(handles.checkbox_mu_div_blast,		'Value', vLock(idxPar.uDivBlast));
	set(handles.checkbox_sigma_div_blast,	'Value', vLock(idxPar.sDivBlast));
	set(handles.checkbox_mu_death_blast,	'Value', vLock(idxPar.uDthBlast));
	set(handles.checkbox_sigma_death_blast,	'Value', vLock(idxPar.sDthBlast));
	set(handles.checkbox_gamma_0,			'Value', vLock(idxPar.gamma0));
	set(handles.checkbox_gamma_mu,			'Value', vLock(idxPar.uGamma));
	set(handles.checkbox_gamma_sigma,		'Value', vLock(idxPar.sGamma));
	set(handles.checkbox_scale,				'Value', vLock(idxPar.scale));
	
	set(handles.checkbox_fix_1,			'Value', vFix(idxPar.uDivFirst));
	set(handles.checkbox_fix_2,			'Value', vFix(idxPar.sDivFirst));
	set(handles.checkbox_fix_3,			'Value', vFix(idxPar.uDthFirst));
	set(handles.checkbox_fix_4,			'Value', vFix(idxPar.sDthFirst));
	set(handles.checkbox_fix_5,			'Value', vFix(idxPar.uDivBlast));
	set(handles.checkbox_fix_6,			'Value', vFix(idxPar.sDivBlast));
	set(handles.checkbox_fix_7,			'Value', vFix(idxPar.uDthBlast));
	set(handles.checkbox_fix_8,			'Value', vFix(idxPar.sDthBlast));
	set(handles.checkbox_fix_9,			'Value', vFix(idxPar.gamma0));
	set(handles.checkbox_fix_10,		'Value', vFix(idxPar.uGamma));
	set(handles.checkbox_fix_11,		'Value', vFix(idxPar.sGamma));
	set(handles.checkbox_fix_12,		'Value', vFix(idxPar.scale));
end

% callbacks for fixing parameter values across concentrations
if (1)
	allHandles = handles;
	
	checkboxHandles = cell(1, idxPar.scale);
	checkboxHandles{idxPar.uDivFirst}	= handles.checkbox_fix_1;
	checkboxHandles{idxPar.sDivFirst}	= handles.checkbox_fix_2;
	checkboxHandles{idxPar.uDthFirst}	= handles.checkbox_fix_3;
	checkboxHandles{idxPar.sDthFirst}	= handles.checkbox_fix_4;
	checkboxHandles{idxPar.uDivBlast}	= handles.checkbox_fix_5;
	checkboxHandles{idxPar.sDivBlast}	= handles.checkbox_fix_6;
	checkboxHandles{idxPar.uDthBlast}	= handles.checkbox_fix_7;
	checkboxHandles{idxPar.sDthBlast}	= handles.checkbox_fix_8;
	checkboxHandles{idxPar.gamma0}		= handles.checkbox_fix_9;
	checkboxHandles{idxPar.uGamma}		= handles.checkbox_fix_10;
	checkboxHandles{idxPar.sGamma}		= handles.checkbox_fix_11;
	checkboxHandles{idxPar.scale}		= handles.checkbox_fix_12;
	for i = 1:idxPar.scale
		set(checkboxHandles{i}, 'UserData', i);
		set(checkboxHandles{i}, 'Callback', @fixCheckBoxCallback);
	end
end

% callbacks for user setting controls
if (1)
	set(handles.edit_Tsteps,	'UserData', 'numTimeSteps');
	set(handles.edit_Tmax,		'UserData', 'maxEvalTime');
	set(handles.edit_Totgen,	'UserData', 'maxEvalDiv');
	set(handles.edit_max_it,	'UserData', 'maxIterNum');
	set(handles.editErrTol,		'UserData', 'errorTolerance');
	set(handles.checkLogLikeFit,'UserData', 'useLogLikeFit');
	%set(handles.checkLiveOnly,	'UserData', 'bLiveOnly');
	
	set(handles.edit_Tsteps,	'Callback', @userSettingsCallback);
	set(handles.edit_Tmax,		'Callback', @userSettingsCallback);
	set(handles.edit_Totgen,	'Callback', @userSettingsCallback);
	set(handles.edit_max_it,	'Callback', @userSettingsCallback);
	set(handles.editErrTol,		'Callback', @userSettingsCallback);
	set(handles.checkLogLikeFit,'Callback', @userSettingsCallback);
	set(handles.checkLiveOnly,	'Callback', @userSettingsCallback);
end
if (~isempty(appContext.windowPos))
	appContext.windowPos(3) = 982;
	appContext.windowPos(4) = 520;
	set(hObject, 'Position', appContext.windowPos);
end
end

%{
% === Outputs from this function are returned to the command line.
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%}
function varargout = fitter_multi_gui_OutputFcn(~, ~, handles)
varargout{1} = handles.output; % default command line output
end

% clean up
function f_CloseRequestFcn(hObject, ~, handles) %#ok<DEFNU>
global measuredData;
global appContext;
global fromGUI;
global idxPar;

uiGetUserSettings(handles);
[vLocked, vFixed] = getLockedFixed(handles, idxPar);
appContext.vLockParam = vLocked;
appContext.vFixParam = vFixed;

% save figure positions
nLastFig = 2 + measuredData.idx.last;
for iFig = 1:nLastFig
	if (ishandle(iFig))
		appContext.arrFigPos{iFig} = get(iFig, 'Position');
	end
end
appContext.windowPos = get(hObject, 'Position');
save(appContext.sSettingsFile, 'appContext');

% perhaps we'd like to remember the number of workers used before us,
% this feature can be added in future
if (exist('matlabpool', 'file') == 2)
	nWorkers = matlabpool('size');
	if (nWorkers > 1)
		fprintf('closing a pool with %d workers\n', nWorkers);
		matlabpool('close');
	end
end
delete(hObject); % close main window
close all; % close other figures

fromGUI = [];
end


%%%%%%%%%%  controls for parameters and settings  %%%%%%%%%%
% callbacks for model parameter controls
function modelParamsCallback(hObject, ~)
global checkboxHandles;
global allHandles;
global modelParams;
global paramBounds;
global idxPar;

curIdx = get(hObject, 'UserData');
curVal = str2double(get(hObject, 'String'));
lowerBound = paramBounds.lb(curIdx);
upperBound = paramBounds.ub(curIdx);
if ((curIdx == idxPar.uDivFirst) || (curIdx == idxPar.uDthFirst) ...
		|| (curIdx == idxPar.uDivBlast) || (curIdx == idxPar.uDthBlast))
	curVal = log(curVal);
end
if ((curVal < lowerBound) || (curVal > upperBound))
	sMsg = 'Entered value is outside feasible bounds.';
	msgbox(sMsg, 'Attention', 'warn', 'modal');
	curConc = get(allHandles.listboxConcs, 'Value');
	curVal = modelParams(curIdx,curConc);
	if ((curIdx == idxPar.uDivFirst) || (curIdx == idxPar.uDthFirst) ...
			|| (curIdx == idxPar.uDivBlast) || (curIdx == idxPar.uDthBlast))
		curVal = exp(curVal);
	end
	set(hObject, 'String', num2str(curVal));
	return
end
if ((curIdx == idxPar.numZombie) || (curIdx == idxPar.mechDecay))
	bFixAcrosConc = true;
else
	curHandle = checkboxHandles{curIdx};
	bFixAcrosConc = get(curHandle, 'value');
end
if (bFixAcrosConc)
	modelParams(curIdx,:) = curVal;
else
	curConc = get(allHandles.listboxConcs, 'Value');
	modelParams(curIdx,curConc) = curVal;
end
uiUpdateParamPlots(allHandles);
end

%{
% fix parameter value across concentrations
% to the value for the active concentration
%}
function fixCheckBoxCallback(hObject, ~)
global allHandles;
global modelParams;
curIdx = get(hObject, 'UserData');
curConc = get(allHandles.listboxConcs, 'Value');
curVal = modelParams(curIdx,curConc);
modelParams(curIdx,:) = curVal;
end

% callbacks for user setting controls
function userSettingsCallback(hObject, ~)
global appContext;
global allHandles;
global measuredData;
global modelParams;
global idxPar;

sFieldName = get(hObject, 'UserData');
if (strcmp(sFieldName, 'useLogLikeFit'))
	curVal = get(hObject, 'Value');
	appContext.useLogLikeFit = curVal;
	
	ctx.measuredData	= measuredData;
	ctx.appContext		= appContext;
	ctx.modelParams		= modelParams;
	ctx.idxPar			= idxPar;
	if (ctx.appContext.bLiveOnly)
		ctx.computeFunc = @computeModelLive;
	else
		ctx.computeFunc = @computeModel;
	end
	
	if (~isempty(measuredData.data{1}))
		ctx.intercept = estimateIntercept(measuredData, ctx.appContext.errorTolerance);
	end
	if (curVal == 1)
		if (~isfield(measuredData, 'varCoeffs'))
			AICc = NaN;
		else
			ll = -computeNegLogLike(ctx);
			AICc = computeAICc(ll);
		end
		set(allHandles.textFitDist, 'String', 'AICc');
		set(allHandles.editFitDist, 'String', sprintf('%0.2f', AICc));
		set(allHandles.textFitPar, 'String', '%, error tol.');
	else
		if (isempty(measuredData.data{1}))
			logWSSR = NaN;
        else
            %ctx.intercept = estimateIntercept(measuredData, ctx.appContext.errorTolerance);
			logWSSR = log( computeResiduals(ctx) );
		end
		set(allHandles.textFitDist, 'String', 'log(WSSR)');
		set(allHandles.editFitDist, 'String', sprintf('%0.2f', logWSSR));
		set(allHandles.textFitPar, 'String', 'min weight');
	end
elseif (strcmp(sFieldName, 'bLiveOnly'))
	curVal = get(hObject, 'Value');
	appContext.bLiveOnly = curVal;
else
	curVal = str2double(get(hObject, 'String'));
	appContext.(sFieldName) = curVal;
end
end

% select active concentration
function listboxConcsCallback(~, ~, handles) %#ok<DEFNU>
updategui(handles);
btnPlotCallback([], [], handles);
end


%%%%%%%%%%  loading/saving parameters and data  %%%%%%%%%%
% load model parameters (possibly for multiple concentrations)
function pushbutton_load_parameters_Callback(~, ~, handles) %#ok<DEFNU>
global idxPar;
global appContext;

[vLocked, vFixed] = getLockedFixed(handles, idxPar);
appContext.vLockParam = vLocked;
appContext.vFixParam = vFixed;

sRecentPath = getRecentPath();
[sFileName, sDirName] = uigetfile( ...
	{'*.xls', 'Excel spreadsheets (*.xls)'; '*.*', 'All files (*.*)'}, ...
	'loading model parameters', sRecentPath);

sFullName = sprintf('%s%s', sDirName, sFileName);

if (sFileName ~= 0)
	setRecentPath(sDirName);
	nConc = numel(get(handles.listboxConcs, 'String'));
	if (nConc > 'x' - 'a' + 1)
		sMsg ...
			= ['Loading/saving parameters function ', ...
			'only supports up to 24 concentrations. ', ...
			'The rest of concentrations will not be loaded.'];
		msgbox(sMsg, 'Attention', 'warn', 'modal');
	end
	loadParameters(sFullName)
	updategui(handles);
	setLockedFixed( ...
		handles, idxPar, appContext.vLockParam, appContext.vFixParam);
end
end

% save model parameters (possibly for multiple concentrations)
function pushbutton_save_parameters_Callback(~, ~, ~) %#ok<DEFNU>
global modelParams;
sRecentPath = getRecentPath();
[sFileName, sDirName] = uiputfile( ...
	{'*.xls', 'Excel spreadsheets (*.xls)'; '*.*', 'All files (*.*)'}, ...
	'saving model parameters', sRecentPath);
sFullName = sprintf('%s%s', sDirName, sFileName);
if (saveParameters(sFullName, modelParams, 1))
	setRecentPath(sDirName);
end
end

% load measured data
function btnLoadMeasuredDataCallback(~, ~, handles) %#ok<DEFNU>
global measuredData;
global appContext;

set(handles.textConc, 'String', '... please wait ...');
sRecentPath = getRecentPath();
[sFileName, sDirName] = uigetfile( ...
	{'*.xls*', 'Excel spreadsheets'; '*.*', 'All files (*.*)'}, ...
	'loading measured data', sRecentPath);
if (sFileName == 0)
	set(handles.textConc, 'String', 'concentrations');
	return
end
setRecentPath(sDirName);

sFullName = sprintf('%s%s', sDirName, sFileName);

loadMeasuredData(sFullName);
set(handles.textConc, 'String', 'concentrations');

set(handles.listboxConcs, 'Value', 1);
set(handles.listboxConcs, 'String', strread(num2str(measuredData.vConc'),'%s')); %#ok<FPARK>

appContext.maxEvalTime = measuredData.maxTime;
appContext.numTimeSteps = appContext.timeStepCoeff*measuredData.maxTime;
appContext.maxEvalDiv = ceil(measuredData.maxTime/appContext.minDivTime);
set(handles.edit_Tmax, 'String', num2str(appContext.maxEvalTime));
set(handles.edit_Tsteps, 'String', num2str(appContext.numTimeSteps));
set(handles.edit_Totgen, 'String', num2str(appContext.maxEvalDiv));
end

% save predicted data (i.e., generated according to the model)
function btnSavePred_Callback(~, ~, handles) %#ok<DEFNU>
global measuredData;
global appContext;
global modelParams;
global idxPar;

currOS = getenv('OS');
if ( isempty(strfind(currOS, 'Windows')) )
	msgbox('this feature works in Windows only');
	return;
end

if (isempty(measuredData.data{1}))
	nDivs = 8; % default
else
	a = measuredData.data{1};
	a = squeeze( a(:,:,1) );
	nDivs = size(a, 1) - 1; % from 0 to last+
end
sRecentPath = getRecentPath();
[sFileName, sDirName] = uiputfile( ...
	{'*.xlsx', 'Excel spreadsheets (*.xlsx)'; '*.*', 'All files (*.*)'}, ...
	'export predicted data', sRecentPath);
if (sFileName == 0)
	return
end
setRecentPath(sDirName);
sFullName = sprintf('%s%s', sDirName, sFileName);

nSheets = measuredData.idx.last;
nConc = size(modelParams, 2);
nTime = appContext.numTimeSteps;
% nDivs = appContext.maxEvalDiv;
% first row is time, first column is concentration
mData = NaN(nConc*(nDivs + 1), nTime + 1);
outData = cell(1, nSheets);
for iData = 1:nSheets
	outData{iData} = mData;
end

ctx.measuredData	= measuredData;
ctx.appContext		= appContext;
ctx.modelParams		= modelParams;
ctx.idxPar			= idxPar;

iStart = 1;
iStop = nDivs + 1;
for iConc = 1:nConc
	predictedData = computeModel(ctx, iConc);
	for iData = 1:nSheets
		mData = outData{iData};
		curr = predictedData{iData};
		curr(nDivs + 1,:) = sum(curr((nDivs + 1):end,:));
		curr = curr(1:(nDivs + 1),:);
		% uncomment this to produce cohorts
		% curr = curr ./ repmat([1, 2.^(0:(nDivs - 1))]', 1, size(curr, 2));
		mData(iStart:iStop,2:end) = curr(1:(nDivs + 1),:);
		outData{iData} = mData;
	end
	iStart = iStart + nDivs + 1;
	iStop = iStop + nDivs + 1;
end

if (exist(sFullName, 'file'))
	delete(sFullName);
end

vConc = str2double(get(handles.listboxConcs, 'String'));
vFirstCol = NaN(nConc*(nDivs + 1), 1);
vFirstCol(1:(nDivs + 1):end) = vConc;
for iData = 1:nSheets
	sSheet = measuredData.sDataType{iData};
	mData = outData{iData};
	mData(:,1) = vFirstCol;
	xlswrite(sFullName, mData', sSheet);
end

objExcel = actxserver('Excel.Application');
objExcel.Workbooks.Open(sFullName);
try
	objExcel.ActiveWorkbook.Worksheets.Item('Sheet1').Delete;
	objExcel.ActiveWorkbook.Worksheets.Item('Sheet2').Delete;
	objExcel.ActiveWorkbook.Worksheets.Item('Sheet3').Delete;
catch %#ok<CTCH>
	fprintf('attempted to delete Excel sheet that doesn''t exist');
end
objExcel.ActiveWorkbook.Save;
objExcel.ActiveWorkbook.Close;
objExcel.Quit;
objExcel.delete;
end


%%%%%%%%%%  actions  %%%%%%%%%%
% plot model predictions, evaluate quality
function btnPlotCallback(~, ~, handles)
curConc = get(handles.listboxConcs, 'Value');
[label, value] = makePlots(curConc, 1);
set(handles.textFitDist, 'String', label);
set(handles.editFitDist, 'String', sprintf('%0.2f', value));
end

%{
% fit model to data
%
% Locking a parameter means that the parameter's value (for
% any concentration) must not change during optimization.
%
% Fixing a parameter means that the parameter's values must
% remain the same across concentrations. Fixed parameters are
% expected to have same values across concentrations
% before optimization starts.
%}
function btnFitCallback(~, ~, handles) %#ok<DEFNU>
global measuredData;
global appContext;
global modelParams;
global paramBounds;
global idxPar;

[vLocked, vFixed] = getLockedFixed(handles, idxPar);
paramsBefore = modelParams;
modelParams = nllsqFit( ...
	measuredData, appContext, ...
	modelParams, paramBounds, ...
	idxPar, 1, vLocked, vFixed);
btnPlotCallback([], [], handles);
updategui(handles);

% save parameters before and after the fit, and save fitting context
fid = fopen('fit-info.txt', 'wt');
printParamInfo(fid, handles);
fclose(fid);
fileNames = {'par-before', 'par-after', 'fit-settings'};
%timeStamp = datestr(now, 'mmm-dd-yy_HH-MM-SS');
fileExts = {'xls', 'xls', 'mat'};

f1 = @(fullFileName, params) saveParameters(fullFileName, params, 1);
f2 = @(fullFileName, ~) saveParameters(fullFileName, modelParams, 1);
funcHandles = {f1, f2, @f3};
for i = 1:3
	fullFileName = sprintf('%s.%s', fileNames{i}, fileExts{i});
	%{
	while (exist(fullFileName, 'file') == 2)
		answer = questdlg( ...
			['[', fullFileName, '] exists, overwrite?'], fileNames{i}, ...
			'Yes', 'No, try again', 'Cancel saving', 'No, try again');
		if (strcmp(answer, 'Yes'))
			break;
		elseif (strcmp(answer, 'Cancel saving'))
			return
		end
	end
	%}
	f = funcHandles{i};
	f(fullFileName, paramsBefore);
end
end

function f3(fullFileName, ~)
global appContext;
global allHandles;
global measuredData;
global idxPar;

uiGetUserSettings(allHandles);
[vLocked, vFixed] = getLockedFixed(allHandles, idxPar);
appContext.vLockParam = vLocked;
appContext.vFixParam = vFixed;

% save figure positions
nLastFig = 2 + measuredData.idx.last;
for iFig = 1:nLastFig
	if (ishandle(iFig))
		appContext.arrFigPos{iFig} = get(iFig, 'Position');
	end
end
%appContext.windowPos = get(hObject, 'Position');
save(fullFileName, 'appContext');
end

% expanding/contracting the main window
function btnExpand_Callback(hObject, ~, ~)
v = get(gcf, 'Position');
bExpanded = get(hObject, 'UserData');

if (bExpanded)
	v(3) = 982;
	set(hObject, 'String', 'show more');
else
	v(3) = 1240;
	set(hObject, 'String', 'show less');
end
set(hObject, 'UserData', ~bExpanded);
set(gcf, 'Position', v);
end

% having some fun
function pushbuttonFun_Callback(~, ~, ~) %#ok<DEFNU>
msgbox('Come on! Did you really think this would work?', ...
	'hi there', 'modal');
end

function pushbuttonExportParams_Callback(~, ~, handles) %#ok<DEFNU>
printParamInfo(1, handles);
end

function btnSaveFitCallback(~, ~, ~) %#ok<DEFNU>
saveToDir = uigetdir(getRecentPath());
if (saveToDir ~= 0)
	%setRecentPath(saveToDir);
	fileNames = {'fit-info', 'par-before', 'par-after', 'fit-settings'};
	timeStamp = datestr(now, 'yyyy-mm-dd_HH-MM-SS');
	fileExts = {'txt', 'xls', 'xls', 'mat'};
	for i = 1:numel(fileNames)
		srcFile = sprintf('%s.%s', fileNames{i}, fileExts{i});
		dstFile = sprintf( ...
			'%s_%s.%s', fileNames{i}, timeStamp, fileExts{i});
		fullDstFile = fullfile(saveToDir, dstFile);
		[status, message] = copyfile(srcFile, fullDstFile, 'f');
		if (~status)
			msgbox(message, 'alert!', 'error');
		end
	end
end
end

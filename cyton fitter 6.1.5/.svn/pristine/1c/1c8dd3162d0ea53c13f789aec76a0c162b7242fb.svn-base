%{
% Converts parameter data from .xsl/.xlsx spreadsheet to struct readable
% by other functions
%
% Called in fitter_multi_gui by pushbutton_load_parameters_Callback
%
% INPUTS: (string) file path including directory path, filename and
% extension
%
% OUTPUTS: none
%
% SIDE EFFECTS: modifies some of the global variables
%}
function loadParameters(sFilePath)
global modelParams;
global paramBounds;
global appContext;
global idxPar;

[~, sVersion] = xlsread(sFilePath, 'A1:A1');
if (strcmp(sVersion, 'Cyton ver. 5.1 or higher'))
	mLoadParams = xlsread(sFilePath, 'A2:X15');
	nLoadConc = size(mLoadParams, 2);
	vIdxMeans = [ ...
		idxPar.uDivFirst, idxPar.uDthFirst, ...
		idxPar.uDivBlast, idxPar.uDthBlast];
	mLoadParams(vIdxMeans,:) = log(mLoadParams(vIdxMeans,:));
else
	% old style parameters
	mLoadParams = xlsread(sFilePath);
	nLoadConc = size(mLoadParams, 2);
	vIdxMeans = [ ...
		idxPar.uDivFirst, idxPar.uDthFirst, ...
		idxPar.uDivBlast, idxPar.uDthBlast];
	vIdxSDevs = [idxPar.sGamma, ...
		idxPar.sDivFirst, idxPar.sDthFirst, ...
		idxPar.sDivBlast, idxPar.sDthBlast];
	vLogMeans = mLoadParams(vIdxMeans,:);
	vLogMeans = vLogMeans(:);
	vLogSDevs = mLoadParams(vIdxSDevs,:);
	vLogSDevs = vLogSDevs(:);
	
	vNrmMeans = log(vLogMeans.^2 ./ sqrt(vLogSDevs.^2 + vLogMeans.^2));
	vNrmSDevs = sqrt(log((vLogSDevs./vLogMeans).^2 + 1));
	
	mLoadParams(vIdxMeans,:) = reshape(vNrmMeans, 5, nLoadConc);
	mLoadParams(vIdxSDevs,:) = reshape(vNrmSDevs, 5, nLoadConc);
end

nConc = size(modelParams, 2);
if (nConc ~= nLoadConc)
	nLoadConc = min(nConc, nLoadConc);
	sMsg ...
		= ['Number of parameter sets in the file ', ...
		'differ from the number of treatments. ', ...
		'Loaded as many parameters as could / was necessary.'];
	warning(sMsg);
	if (~appContext.commandLine)
		msgbox(sMsg, 'Attention', 'warn', 'modal');
	end
end
modelParams(:,1:nLoadConc) = mLoadParams(1:14,1:nLoadConc);

% load parameter boundaries
nums = xlsread(sFilePath, 2);
if (isempty(nums))
	mLower = repmat(paramBounds.lb(:,1), 1, nConc);
	mUpper = repmat(paramBounds.ub(:,1), 1, nConc);
else
	numCols = size(nums, 2);
	mLower = nums(:,1:2:numCols);
	mUpper = nums(:,2:2:numCols);
	
	if ( ~isequal(size(mLower), size(mUpper)) ...
			|| ~isequal(size(mLower), size(modelParams)) )
		sMsg = ...
			'something is wrong with your boundaries, not loading them';
		warning(sMsg);
		if (~appContext.commandLine)
			msgbox(sMsg, 'Attention', 'warn', 'modal');
		end
		mLower = repmat(paramBounds.lb, 1, nConc);
		mUpper = repmat(paramBounds.ub, 1, nConc);
	else
		vIdxMeans = [ ...
			idxPar.uDivFirst, idxPar.uDthFirst, ...
			idxPar.uDivBlast, idxPar.uDthBlast];
		mLower(vIdxMeans,:) = log(mLower(vIdxMeans,:));
		mUpper(vIdxMeans,:) = log(mUpper(vIdxMeans,:));
	end
end
paramBounds.lb = mLower;
paramBounds.ub = mUpper;

mAdjust = (modelParams < mLower);
modelParams(mAdjust) = mLower(mAdjust);
bWarn = any(mAdjust(:));
mAdjust = (modelParams > mUpper);
modelParams(mAdjust) = mUpper(mAdjust);
bWarn = bWarn || any(mAdjust(:));
if (bWarn)
	sMsg = ['Some of the loaded parameters ', ...
		'are outside feasible bounds. Such ', ...
		'parameters were set to the boundary values.'];
	warning(sMsg);
	if (~appContext.commandLine)
		msgbox(sMsg, 'Attention', 'warn', 'modal');
	end
end

% load locked and fixed marks
lockedOrig = appContext.vLockParam;
fixedOrig = appContext.vFixParam;
try
	nLockFix = idxPar.last;
	locked = false(nLockFix, 1);
	fixed = false(nLockFix, 1);
	[~, txt] = xlsread(sFilePath, 2);
	if (isempty(txt))
		rethrow('a');
	end
	for i = 2:numel(txt)
		label = txt{i};
		if (numel(label) >= 1)
			if (label(1) == 'l')
				locked(i - 1) = true;
			elseif (label(1) == 'f')
				fixed(i - 1) = true;
			end
		end
	end
	locked(idxPar.numZombie) = true;
	fixed(idxPar.mechDecay) = true;
catch
	locked = lockedOrig;
	fixed = fixedOrig;
end
appContext.vLockParam = locked;
appContext.vFixParam = fixed;
end
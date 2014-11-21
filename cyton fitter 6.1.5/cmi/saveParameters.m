%{
% save model parameters to file
%
% INPUTS:
% (string) file path including directory path, filename and extension;
% (param struct) model parameters to save
% (boolean) flag indicating permission to overwrite a file
%
% OUTPUTS: (boolean) indicates whether the data was saved
%
% SIDE EFFECTS: creates/overwrites the file pointed as input
%}
function saved = saveParameters(fullFileName, params, allowOverwrite)
global allHandles;
global idxPar;
global measuredData;

saved = false;
if (fullFileName == 0)
	return
end
if (exist(fullFileName, 'file') == 2)
	if (~allowOverwrite)
		warning('specified param. file exists but cannot be overwritten\n');
		return
	end
	delete(fullFileName);
end

vIdxMeans = [ ...
	idxPar.uDivFirst, idxPar.uDthFirst, ...
	idxPar.uDivBlast, idxPar.uDthBlast];
mOutParams = params;
mOutParams(vIdxMeans,:) = exp(params(vIdxMeans,:));

nConc = 1; % Paramaters can be saved when no data has been loaded
if (~isempty(allHandles))
	nConc = numel(get(allHandles.listboxConcs, 'String'));
else
	if (~isempty(measuredData.vConc))
		nConc = numel(measuredData.vConc);
	end
end

if (nConc > 'x' - 'a' + 1)
	sMsg ...
		= ['Loading/saving parameters function ', ...
		'only supports up to 24 concentrations. ', ...
		'The rest of concentrations will not be saved.'];
	msgbox(sMsg, 'Attention', 'warn', 'modal');
end

xlswrite(fullFileName, {'Cyton ver. 5.1 or higher'}, 'A1:A1');
column = 'A' + size(mOutParams, 2) - 1;
row = size(mOutParams, 1) + 1;
range = sprintf('A2:%c%d', column, row);
xlswrite(fullFileName, mOutParams, range);

saved = true;
end
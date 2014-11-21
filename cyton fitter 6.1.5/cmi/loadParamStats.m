%{
% Loads parameter data from a csv in the format created by saveParamStats
%
% If called with makeParamStruct == 1, will create a struct with all the
% information contained in the paramStats file, including error tolerance
% values and file paths of each parameter set inside their test directory
%
% If called with makeParamStruct == 0, will create an array with just the
% parameter values. This type of output can be passed directly to functions
% like plotParamStats
%}

function richParamData = loadParamStats( fullFileName, makeParamStruct )

%global idxPar

fullParData = importdata(fullFileName);

% remove error tolerance values and concentrations
parData = fullParData.data(3:end, :);

errTol = fullParData.data(1,:);
%[~, ind] = find(errTol==errTol(1,1),2);

if (makeParamStruct)
	
	richParamData = struct();
	
	%numErrVals = ind(2)-1;
	
	%parData = reshape(parData, idxPar.last, numErrVals, []);
	
    %richParamData.errTols = errTol(1:numErrVals);
	richParamData.errTols = fullParData.data(1,:);
    
    richParamData.concs = fullParData.data(2,:);
    
	richParamData.data = parData;
	
	richParamData.initParamPaths = fullParData.colheaders;
	
else
	richParamData = parData;
end

end


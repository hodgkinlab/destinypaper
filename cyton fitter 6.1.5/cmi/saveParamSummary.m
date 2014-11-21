function saveParamSummary( dataStruct, fullFileName )

fullData = dataStruct.data;
concs = unique(dataStruct.concs);
numConcs = numel(concs);

rowHeaders = {
    'Strategy';
    'Error tolerance';
    'Concentration';
    'median time to first division';
    'sd of time to first division';
	'median time to first death';
    'sd of time to first death';
    'median time to subsequent division';
    'sd of time to subsequent division';
    'median time to subsequent death';
    'sd of time to subsequent death';
    'gamma0';
    'mean destiny';
    'sd of destiny';
    'number of initial cells';
    'numZombie';
    'mechDecay'};
xlswrite(fullFileName, rowHeaders, 'Sheet1', 'A1');

currCol = 0;

dataMat = zeros(size(fullData, 1)+2, size(fullData, 2));

for i=1:numConcs
    newCols = fullData(:,dataStruct.concs == concs(i));
    errTols = dataStruct.errTols(dataStruct.concs == concs(i));
    newCols = [errTols;concs(i).*ones([1, size(newCols, 2)]);newCols];
    dataMat(:, currCol+1:currCol+size(newCols, 2)) = newCols;
    currCol = currCol + size(newCols, 2);
end
xlswrite(fullFileName, dataMat, 'Sheet1', 'B2');
end


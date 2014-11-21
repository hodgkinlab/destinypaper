function sortCell = getPercentiles(dataStruct, fullFileName)

fullData = dataStruct.data;
concs = unique(dataStruct.concs);
numConcs = numel(concs);

data = zeros(size(fullData, 1), size(fullData, 2)/numConcs, numConcs);

for i=1:numConcs;
    data(:,:,i) = fullData(:,dataStruct.concs == concs(i));
end

sortCell = squeeze(mat2cell(data, ones(1,size(data, 1)), size(data, 2), ones(1,size(data, 3))));

for i=1:size(sortCell,1)
    for j=1:size(sortCell,2)
        statsVec = zeros(1, 5);
        statsVec(1) = mean(sortCell{i,j});
        statsVec(2) = std(sortCell{i,j});
        statsVec(3) = statsVec(2)/statsVec(1);
        if (isnan(statsVec(3)))
            statsVec(3) = 0;
        end
        statsVec(4:5) = prctile(sortCell{i,j}, [2.5, 97.5]);
        sortCell{i, j} = statsVec;
    end
end


xlswrite(fullFileName, dataStruct.errTols(1).*ones(1, numConcs*5), 'Sheet1', 'B1');

repConcs = repmat(concs', [1, 5])';
xlswrite(fullFileName, repConcs(:)', 'Sheet1', 'B2');

dataHeaders = repmat({'Mean', 'SD', 'CV', '2.5 percentile', '97.5 percentile'}, numConcs);
xlswrite(fullFileName, dataHeaders, 'Sheet1', 'B3');

xlswrite(fullFileName, cell2mat(sortCell), 'Sheet1', 'B4');

rowHeaders = {'Error tolerance';
    'Concentration';
    '';
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
end
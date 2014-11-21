%{
% Saves fitting statistics generated duting autofitting to path
%}

function saveFitStats( fitStats, path )

file = fopen([path, '/fitStats.csv'], 'w');

reformFitStats = transpose(fitStats);
reformFitStats = cellfun(@num2str, reformFitStats, 'UniformOutput', 0);

fprintf(file, '%s, %s, %s, %s, %s\n', reformFitStats{:,:});

fclose(file);

end


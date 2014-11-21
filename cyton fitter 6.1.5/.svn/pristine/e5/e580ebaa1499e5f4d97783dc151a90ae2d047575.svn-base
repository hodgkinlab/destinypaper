%{
% Loads fitStats files as produced by saveFitStats
%}

function fitStatsData = loadFitStats( fullFileName )

% load fitStats as strings
file = fopen(fullFileName);
fitStatsData = textscan(file, '%s%s%s%s%s', 'Delimiter', ',', 'CollectOutput', 1);
fclose(file);

fitStatsData = fitStatsData{1};

% convert the numeric data to their approptiate types
for i=2:size(fitStatsData, 1)
	for j=3:5
		fitStatsData{i,j} = str2num(fitStatsData{i,j});
	end
end

end


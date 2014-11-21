%{
% Averages cell count data over repeats
%
% INPUT:
%	- rawData: cell count data read from .xls file
%
% OUTPUT: meanData: data averaged over repeats in same format as rawData
%}
function meanData = getMeanData( rawData,ii )

times = rawData.data{ii}(1,:,:);
mT = rawData.data{ii}(:,:,1);

repeats = find(diff(times)~=0, 1);
dims = size(mT);

mT = reshape(mT, dims(1), repeats, dims(2)/repeats);
mT = mean(mT, 2);
mT = squeeze(mT);
	
meanData = mT;
end


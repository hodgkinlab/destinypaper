%{
% translate data from a form provided by loadMeasuredData to a form
% provided by computeModel
%
% INPUT: measuredData: data to be translated
%
% OUTPUT: modelTypeData: reformatted data
%
% ASSUMPTIONS: the number of repeated experiments is constant over all
% times in each cell measurement type
%
%}

function modelTypeData = translateData( measuredData )

modelTypeData = cell(1,measuredData.idx.last);

for iType=1:measuredData.idx.last
	mData = measuredData.data{iType};
	if (~isempty(mData))
		times = mData(1,:);
		repeats = find(diff(times) ~= 0, 1);
		datasSize = [size(mData), 1];
		mData = reshape(mData, datasSize(1), repeats, ...
			datasSize(2)/repeats, datasSize(3));
		meanMData = mean(mData, 2);
		modelTypeData{iType} = squeeze(meanMData);
	end
	
end

end


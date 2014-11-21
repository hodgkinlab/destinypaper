%{
% Adds Gaussian noise to modelled cell count data that will result in a
% given expected RSS
%
% This function will sometimes give negative counts but this is not
% detrimental to its purpose
%
% INPUTS:
%	- pureData: complete measured data struct. While this will work with
%	  actual measured data, it should be noiseless modelled data
%	- k: size of measurement divided by sample
%
% OUTPUTS:
%	- noisyData: complete measured data struct containing noisy data. All
%	  other fields of pureData are unchanged
%
% AUTHOR: Damian Pavlyshyn (pavlyshyn.d@wehi.edu.au)
%}

function noisyData = addNoise( pureData, k )

noisyData = pureData;
	for ii=find(~cellfun(@isempty, pureData.data));
		sigma_N = sqrt(log(k));
		mNoise = exp(normrnd(0, sigma_N ,size(noisyData.data{ii})));
		mNoise(1,:) = ones(1, size(noisyData.data{ii},2));
		
		noisyData.data{ii} = noisyData.data{ii}.*mNoise;
	end
end


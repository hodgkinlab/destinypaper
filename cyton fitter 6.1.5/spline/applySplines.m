%{
% Fits splines to each generation of cells in a sample of measured data,
% outputting a structure that can be handled as measuredData
%
% INPUTS:
%	- measuredData: sparse, actual experiment measurements
%	- steps: number of timepoints in resulting spline data
%	- alg: interpolation algorithm; implemented algorithms are:
%		- 'hermite' (default): cubic hermite spline
%		- 'natural': natural cubic spline
%		- 'constrained': natural cubic spline with enforced points of
%		  zero population
%		- 'akima': Akima interpolation
%	- smooth (default 0): alter data to create smoothing spline (only
%	  intended for natural cubic spline interpolation
%
% OUTPUT: splineData: dense spline in measuredData format
%
%}

function splineData = applySplines( measuredData, steps, alg, smooth )

% error handling
if (nargin < 3)
	alg = 'hermite';
end

if (nargin < 4)
	smooth = 0;
end

if ((nargin >= 4) && smooth && ~strcmp(alg, 'cubic'))
	warning(['Smoothing called without cubic spline interpolation',...
		char(10), 'Set algorithm to ''natural''']);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

modelData = translateData(measuredData);
splineData = cell(1, measuredData.idx.last);

for iType=1:measuredData.idx.last
	mData = modelData{iType};
	if ~isempty(mData)
		
		% create a matrix that will accomodate the spline
		dSize = [size(mData), 1];
		oldTimes = mData(1, :, 1);
		newData = zeros(dSize(1), steps, dSize(3));
		newTimes = linspace(oldTimes(1), oldTimes(end), steps);
		
		% insert times into newData
		newData(1, :, :) = repmat(newTimes, [1, 1, dSize(3)]);
		
		% calculate the spline for each division
		for ii = 2:dSize(1)
			
			% for each concentration
			for jj = 1:dSize(3)
				
				if (smooth)
					mData(ii, :, jj) = splineSmooth(oldTimes, ...
						mData(ii, :, jj), 10);
				end
				
				if (strcmp(alg, 'hermite'))
					newData(ii, :, jj) = pchip(oldTimes, ...
						mData(ii, :, jj), ...
						linspace(oldTimes(1), oldTimes(end), steps));
					
				elseif (strcmp(alg, 'akima'))
					newData(ii, :, jj) = akimai(oldTimes, ...
						mData(ii, :, jj), ...
						linspace(oldTimes(1), oldTimes(end), steps));
					
				elseif (strcmp(alg, 'natural'))
					newData(ii, :, jj) = spline(oldTimes, ...
						[0 mData(ii, :, jj) 0], ...
						linspace(oldTimes(1), oldTimes(end), steps));
					
				elseif (strcmp(alg, 'constrained'))
					newData(ii, :, jj) = getSpline(oldTimes, ...
						mData(ii, :, jj),steps);
					
				else
					error(['Invalid interpolation algorithm',char(10),...
						'Valid algorithms are ''hermite'', ''akima'', ',...
						'''natural'', ''constrained''']);
				end
			end
		end
		
		splineData{iType} = newData;
	end
end

splineData = wrapData(splineData);

end


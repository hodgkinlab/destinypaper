%{
% Compare predictions with measurements for a given concentration
%
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013 ~ 2014
%}
function rssConc = computeResidualsConc( ...
	curConc, nTypes, predictedData, ctx)
rssConc = 0;
measuredData = ctx.measuredData;

for iType = 1:nTypes
	mData = measuredData.data{iType};
	if (~isempty(mData))
		mData = mData(:,:,curConc);
		mData = mData(:,~isnan(mData(1,:)));
		mPred = predictedData{iType};
		
		vMeasTime = mData(1,:);
		vPredTime = mPred(1,:);
		nDivs = size(mData, 1) - 1;
		
		for iDiv = 2:nDivs
			vMeas = mData(iDiv,:);
			vPred = mPred(iDiv,:);
			vPred = interp1(vPredTime, vPred, vMeasTime);
			denom = vPred + ctx.intercept;
			rssConc = rssConc + nansum( (vPred - vMeas).^2 ./ denom );
		end
		iDiv = size(mData, 1);
		vMeas = mData(iDiv,:);
		if (iDiv == size(mPred, 1))
			vPred = mPred(iDiv,:);
		else
			vPred = sum(mPred(iDiv:end,:));
		end
		vPred = interp1(vPredTime, vPred, vMeasTime);
		denom = vPred + ctx.intercept;
		rssConc = rssConc + nansum( (vPred - vMeas).^2 ./ denom );
	end
end
end
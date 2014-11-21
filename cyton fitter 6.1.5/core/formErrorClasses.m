%{
% Estimates parameters mu and sigma for truncated normals,
% note that mu and sigma are mean and st.dev. for associated normals
%
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013 ~ 2014
%}
function errClasses = formErrorClasses(measuredData, iType, iConc)
errClasses = [];
allObsData = measuredData.data{iType};
if (isempty(allObsData))
	return
end

obsData = squeeze(allObsData(:,:,iConc));
obsData = obsData(:,~isnan(obsData(1,:)));

repMeasTimes = obsData(1,:);
measTimes = unique(repMeasTimes);
numTimes = numel(measTimes);

lastRow = size(obsData, 1);
for iRow = 2:lastRow
	for iTime = 1:numTimes
		selector = (measTimes(iTime) == repMeasTimes);
		points = obsData(iRow,selector);
		errClass.mean = mean(points);
		
		if (numel(unique(points)) >= 3)
			errClass.var = var(points);
			%{
			if ( errClass.mean < 3*sqrt(errClass.var) )
				m0 = errClass.mean;
				s0 = sqrt(errClass.var);
				wrapper = @(x, s) pdfTrunc(x, m0, s);
				s = mle(points, 'pdf', wrapper, 'start', s0);
				errClass.var = s^2;
			end
			%}
		else
			errClass.var = NaN; % unreliable class
		end
		errClass.num = numel(points);
		errClass.rss = sum((points - errClass.mean).^2);
		errClasses = [errClasses, errClass]; %#ok<AGROW>
	end
end
end
%{
function p = pdfTrunc(x, m, s)
if ((m <= 0) || (s <= 0))
	p = zeros(size(x)) + 1e-10;
	return;
end
p = normpdf(x, m, s) ./ (1 - normcdf(0, m, s));
end
%}
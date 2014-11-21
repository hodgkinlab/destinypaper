%{
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013 ~ 2014
%}
function intercept = estimateIntercept(measuredData, level)
nTypes = measuredData.idx.last;
nConc = numel(measuredData.vConc);
allVars = [];
for iType = 1:nTypes
	if (~isempty(measuredData.data{iType}))
		for iConc = 1:nConc
			errClass = formErrorClasses(measuredData, iType, iConc);
			vars = [errClass.var];
			allVars = [allVars, vars];  %#ok<AGROW>
		end
	end
end
intercept = prctile(allVars, level);
disp(num2str(intercept));
end
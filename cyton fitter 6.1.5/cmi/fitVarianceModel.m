%{
% Model measurement variance as a function of measurement mean
%
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013 ~ 2014
%}
function fitVarianceModel()
global measuredData;
global modelParams;

nTypes = measuredData.idx.last;
nConc = size(modelParams, 2);
varCoeffs = NaN(nTypes, nConc);

for iType = 1:nTypes
	for iConc = 1:nConc
		errClass = formErrorClasses(measuredData, iType, iConc);
		varCoeffs(iType, iConc) = fitErrorModel(errClass);
	end
end
measuredData.varCoeffs = varCoeffs;
disp(num2str(varCoeffs));
end

function pow = fitErrorModel(errClasses)
pow = NaN;
if (isempty(errClasses))
	return;
end
means = [errClasses.mean];
vars = [errClasses.var];

selected = ~isnan(vars);
x = means(selected);
y = vars(selected);

A = log(x);
B = log(y);
pow = A(:)\B(:);

% figure('position', [300 300 500 400]);
% loglog(x, y, 'marker', '*', 'lineStyle', 'none');
% xPred = linspace(min(x), max(x), 200);
% hold on; plot(xPred, xPred.^pow, 'color', 'r');
end
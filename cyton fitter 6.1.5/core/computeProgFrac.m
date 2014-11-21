%{
% division destiny controlled by progressor fraction
%
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013 ~ 2014
%}
function [progFrac, tailDistr] = computeProgFrac( ...
	lastDiv, minDestProb, destParams)
pActive = destParams(1);
uGamma = destParams(2);
sGamma = destParams(3);
shape = (uGamma/sGamma)^2;
scale = sGamma*sGamma/uGamma;

d = gaminv(1 - minDestProb, shape, scale);
d = round(d) + 1;
d = min(d, lastDiv);

tailDistr = 1 - gamcdf(1:d, shape, scale);
progFrac = tailDistr ./ [1, tailDistr(1:(end - 1))];
progFrac(d:lastDiv) = progFrac(d);
progFrac(1) = progFrac(1).*pActive;
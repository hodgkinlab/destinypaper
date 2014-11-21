function cohortMean = gammaPar2cohortMean(uGamma, sGamma)
shape = (uGamma/sGamma)^2;
scale = sGamma*sGamma/uGamma;
lastDiv = 500;
F = gamcdf(0:lastDiv, shape, scale);
c = F(2:end) - F(1:(end - 1));
k = 0:(numel(c) - 1);
cohortMean = sum(k.*c);
end
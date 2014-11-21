function y = redist(x,pmf)
%gives a number randomly selected from the probability mass function pmf
step = @(x) (x>=0.0);

N = length(pmf);
cum = zeros(size(pmf));
cum(1) = pmf(1);
for ii =2:N
	cum(ii) = cum(ii-1)+pmf(ii);
end

y = ones(size(x)); %because indices start at 1, not 0;
for ii = 1:N
	y = y+step(x-cum(ii));
end
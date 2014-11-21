%{
% Calculated distance between two functions f, g
%
% Distance is calculated according to the semimetric:
% $$ d(f, g) = int_0^\inf \frac{|f(t)-g(t)|}{|f(t)| + |g(t)|}\.dt $$
%
% Semimetric properties:
%	- Distance ranges between 0 and 1
%	- d(f, g) = 0 iff f = g
%	- d(f, g) = d(g, f)
%	- d(kf, kg) = d(f, g)
%	- triangle inequality does not hold
%	- d(f + A, g + A) != d(f, g)
%
% INPUTS:
%	- X: y-values of f
%	- Y: y-values of g
%
% OUTPUTS: nonnegative real distance
%}

function dist = constScaleMetric( X, Y )

dist = trapz(abs(X-Y))./trapz(abs(X)+abs(Y));

end


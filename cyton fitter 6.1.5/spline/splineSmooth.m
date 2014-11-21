%{
% smooths input data so as to minimise the weighted sum of the linear least
% squares measure of a cubic spline and the roughness of said spline
%
% INPUTS:
%	- times: times at which measurements were made
%	- Y: vector of population sizes corresponding to times
%	- smoothCoeff: smoothing coefficient that determines the weighting of
%	  roughness penalty
%
% OUTPUT: newY: smoothed population counts; the cubic spline must be
% generated separately
%
%}

function newY = splineSmooth( times, Y, smoothCoeff )

tVec = diff(times);
Q = makeQ(tVec);
R = makeR(tVec);
K = Q * inv(R) * Q';
I = eye(length(times));
newY = inv(I + smoothCoeff.*K)*Y';
end

function Q = makeQ( tVec )
n = length(tVec);
Q = zeros(n, n-2);
for ii=1:n-1
	Q(ii, ii) = 1/tVec(ii);
	Q(ii+2, ii) = 1/tVec(ii+1);
	Q(ii+1, ii) = -(Q(ii, ii) + Q(ii+2, ii));
end
end

function R = makeR( tVec )
n = length(tVec);
R = zeros(n, n-2);
for ii=1:n-1
	R(ii, ii) = 1/6*tVec(ii);
	R(ii+2, ii) = 1/6*tVec(ii+1);
	R(ii+1, ii) = 1/3*(R(ii, ii) + R(ii+2, ii));
end
R(1,:) = [];
R(end, :) = [];
end

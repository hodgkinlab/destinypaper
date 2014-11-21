%{
% Takes a matrix of points, copmutes the distance between each pair with
% two metrics, then plots the distances acquired with the two metrics 
% against each other
%
% INPUTS:
%	- cell array with each element representing a single point
%	- two metric functions that take two quantities and return a nonnegative
%	  real
%
% OUTPUTS: matrix containing the two distances between each pair of points
%
% SIDE EFFECTS: generates a scatter plot
%}

function vDist = plotDists( mData, fMetric1, fMetric2 )

t = @(n) n*(n-1)/2;
pos = @(i,j) t(max(i, j)) + min(i, j);

len = size(mData, 1);

vDist = zeros(2, t(len+1));

for ii=1:len
	for jj=1:ii
		vDist(1, pos(ii,jj)) = fMetric1(mData{ii}, mData{jj});
		vDist(2, pos(ii,jj)) = fMetric2(mData{ii}, mData{jj});
	end
end

scatter(vDist(1,:), vDist(2,:));

end


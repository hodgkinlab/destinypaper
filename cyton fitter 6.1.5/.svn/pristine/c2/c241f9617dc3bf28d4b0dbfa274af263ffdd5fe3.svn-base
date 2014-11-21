%{
% Creates bootstrapped data by selecting points from experimental repeats
% contained in global variable measuredData
%
% Must be called in iterOverTimes, do not call unwrapped
%}

function bootStrap( points, iType, iConc, selector )

global measuredData;

singleRep = transpose(points);
reps = size(singleRep);

% creates an index array taking elements from appropriate columns with
% repeats
permSingleRep = singleRep(randi([0, reps(1)-1], reps) + ...
    repmat(1:reps(1):prod(reps), [reps(1), 1]));
measuredData.data{iType}(:, selector, iConc) = transpose(permSingleRep);

end


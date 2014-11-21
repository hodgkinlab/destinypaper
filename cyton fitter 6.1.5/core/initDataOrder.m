%{
% Defines the order of data types
%
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013
%}
function idx = initDataOrder()
idx = [];
idx.live = 0;
idx.dead = 0;
idx.drop = 0;

fields = fieldnames(idx);
for i = 1:numel(fields)
	idx.(fields{i}) = i;
end
idx.last = numel(fields);
end
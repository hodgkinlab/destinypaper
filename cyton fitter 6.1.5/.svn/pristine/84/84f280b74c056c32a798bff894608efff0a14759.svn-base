%{
% Defines the order of parameters in parameter vector
%
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013
%}
function idx = initParamsOrder()
idx = [];
idx.uDivFirst	= 0;
idx.sDivFirst	= 0;
idx.uDthFirst	= 0;
idx.sDthFirst	= 0;
idx.uDivBlast	= 0;
idx.sDivBlast	= 0;
idx.uDthBlast	= 0;
idx.sDthBlast	= 0;
idx.gamma0		= 0;
idx.uGamma		= 0;
idx.sGamma		= 0;
idx.scale		= 0;
idx.numZombie	= 0;
idx.mechDecay	= 0;

fields = fieldnames(idx);
for i = 1:numel(fields)
	idx.(fields{i}) = i;
end
idx.last = numel(fields);
end
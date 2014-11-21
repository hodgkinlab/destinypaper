%{
% Set default lower and upper bounds for model parameters
%
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013 ~ 2014
%}
function setDefaultParamBounds()
global paramBounds;
global idxPar;

vLower = zeros(idxPar.last, 1);
vUpper = zeros(idxPar.last, 1);

% note that interior-point algorithm avoids solutions on the boundaries
vLower(idxPar.uDivFirst)	= 0;
vLower(idxPar.sDivFirst)	= 0;
vLower(idxPar.uDthFirst)	= 0;
vLower(idxPar.sDthFirst)	= 0;
vLower(idxPar.uDivBlast)	= 0;
vLower(idxPar.sDivBlast)	= 0;
vLower(idxPar.uDthBlast)	= 0;
vLower(idxPar.sDthBlast)	= 0;
vLower(idxPar.gamma0)		= 0;
vLower(idxPar.uGamma)		= 0;
vLower(idxPar.sGamma)		= 0;
vLower(idxPar.scale)		= 0;
vLower(idxPar.numZombie)	= 0;
vLower(idxPar.mechDecay)	= 0;

% setting Inf instead of an arbitrary large bound is recommended here:
% http://www.mathworks.com.au/help/optim/ug/when-the-solver-fails.html#btqolk_
vUpper(idxPar.uDivFirst)	= Inf;
vUpper(idxPar.sDivFirst)	= Inf;
vUpper(idxPar.uDthFirst)	= Inf;
vUpper(idxPar.sDthFirst)	= Inf;
vUpper(idxPar.uDivBlast)	= Inf;
vUpper(idxPar.sDivBlast)	= Inf;
vUpper(idxPar.uDthBlast)	= Inf;
vUpper(idxPar.sDthBlast)	= Inf;
vUpper(idxPar.gamma0)		= 1.001; % for interior-point algorithm
vUpper(idxPar.uGamma)		= Inf;
vUpper(idxPar.sGamma)		= Inf;
vUpper(idxPar.scale)		= Inf;
vUpper(idxPar.numZombie)	= Inf;
vUpper(idxPar.mechDecay)	= Inf;

paramBounds = [];
paramBounds.lb = vLower;
paramBounds.ub = vUpper;
end
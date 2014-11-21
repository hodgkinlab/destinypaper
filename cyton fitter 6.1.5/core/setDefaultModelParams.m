%{
% Set default model parameters. This function should contain
% all default choices for model parameters.
%
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013
%}
function setDefaultModelParams()
global modelParams;
global idxPar;

modelParams = zeros(idxPar.last, 1);
modelParams(idxPar.uDivFirst)	= 5;
modelParams(idxPar.sDivFirst)	= 0.5;
modelParams(idxPar.uDthFirst)	= 5;
modelParams(idxPar.sDthFirst)	= 0.5;
modelParams(idxPar.uDivBlast)	= 4;
modelParams(idxPar.sDivBlast)	= 0.4;
modelParams(idxPar.uDthBlast)	= 4;
modelParams(idxPar.sDthBlast)	= 0.4;
modelParams(idxPar.gamma0)		= 1;
modelParams(idxPar.uGamma)		= 1;
modelParams(idxPar.sGamma)		= 1;
modelParams(idxPar.scale)		= 1000;
modelParams(idxPar.numZombie)	= 0;
modelParams(idxPar.mechDecay)	= 10;
end
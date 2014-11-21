function newParams = deviateParams( params, idxPar )

newParams = zeros(idxPar.last,1);
newParams(idxPar.uDivFirst)	= abs(params(idxPar.uDivFirst)	+ normrnd(0, 2));
newParams(idxPar.sDivFirst)	= abs(params(idxPar.sDivFirst)	+ normrnd(0, 0.02));
newParams(idxPar.uDthFirst)	= abs(params(idxPar.uDthFirst)	+ normrnd(0, 2));
newParams(idxPar.sDthFirst)	= abs(params(idxPar.sDthFirst)	+ normrnd(0, 0.02));
newParams(idxPar.uDivBlast)	= abs(params(idxPar.uDivBlast)	+ normrnd(0, 2));
newParams(idxPar.sDivBlast)	= abs(params(idxPar.sDivBlast)	+ normrnd(0, 0.02));
newParams(idxPar.uDthBlast)	= abs(params(idxPar.uDthBlast)	+ normrnd(0, 2));
newParams(idxPar.sDthBlast)	= abs(params(idxPar.sDthBlast)	+ normrnd(0, 0.02));
newParams(idxPar.gamma0)	= params(idxPar.gamma0);
newParams(idxPar.uGamma)	= abs(params(idxPar.uGamma)		+ normrnd(0, 0.2));
newParams(idxPar.sGamma)	= abs(params(idxPar.sGamma)		+ normrnd(0, 0.2));
newParams(idxPar.scale)		= params(idxPar.scale);
newParams(idxPar.numZombie)	= params(idxPar.numZombie);
newParams(idxPar.mechDecay)	= params(idxPar.mechDecay);

end



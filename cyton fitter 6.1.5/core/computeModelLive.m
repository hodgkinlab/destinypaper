%{
% Compute Cyton model for given parameters for live cell counts only
%
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013
%}
function predictedData = computeModelLive(ctx, curConc)
measuredData	= ctx.measuredData;
appContext		= ctx.appContext;
modelParams		= ctx.modelParams;
idxPar			= ctx.idxPar;

nTimeSteps		= appContext.numTimeSteps;
maxTimeStep		= appContext.maxEvalTime;
lastDivModel	= appContext.maxEvalDiv;
minDestProb		= appContext.minDestProb;
curParams		= modelParams(:,curConc);

vTime		= linspace(0, maxTimeStep, nTimeSteps);
dt			= vTime(2) - vTime(1);
mDivRate	= NaN(lastDivModel, nTimeSteps);
mDeathRate	= NaN(lastDivModel, nTimeSteps);
mDivInc		= NaN(lastDivModel, nTimeSteps);
mLiveInc	= NaN(lastDivModel, nTimeSteps);
mDeadInc	= NaN(lastDivModel, nTimeSteps);

vProgFrac = computeProgFrac( ...
	lastDivModel, minDestProb, curParams(idxPar.gamma0:idxPar.sGamma));

uDivFirst = curParams(idxPar.uDivFirst);
sDivFirst = curParams(idxPar.sDivFirst);
uDthFirst = curParams(idxPar.uDthFirst);
sDthFirst = curParams(idxPar.sDthFirst);
uDivBlast = curParams(idxPar.uDivBlast);
sDivBlast = curParams(idxPar.sDivBlast);
uDthBlast = curParams(idxPar.uDthBlast);
sDthBlast = curParams(idxPar.sDthBlast);

mDivRate(1,:) ...
	= (vProgFrac(1)*lognpdf(vTime, uDivFirst, sDivFirst) ...
	.*(1 - logncdf(vTime, uDthFirst, sDthFirst)));
mDeathRate(1,:) ...
	= (lognpdf(vTime, uDthFirst, sDthFirst) ...
	.*(1 - vProgFrac(1)*logncdf(vTime, uDivFirst, sDivFirst)));
for i = 2:lastDivModel
	mDivRate(i,:) ...
		= vProgFrac(i)*lognpdf(vTime, uDivBlast, sDivBlast) ...
		.*(1 - logncdf(vTime, uDthBlast, sDthBlast));
	mDeathRate(i,:) ...
		= lognpdf(vTime, uDthBlast, sDthBlast) ...
		.*(1 - vProgFrac(i)*logncdf(vTime, uDivBlast, sDivBlast));
end
mDivInc(1,:)	= mDivRate(1,:);
mDeadInc(1,:)	= mDeathRate(1,:);
mLiveInc(1,:)	= -mDivInc(1,:) - mDeadInc(1,:);
for i = 2:lastDivModel
	f = conv(2.0*mDivInc(i - 1,:), mDivRate(i,:));
	mDivInc(i,:) = f(1:numel(vTime))*dt;
	f = conv(2.0*mDivInc(i - 1,:), mDeathRate(i,:));
	mDeadInc(i,:) = f(1:numel(vTime))*dt;
	mLiveInc(i,:) = 2.0*mDivInc(i - 1,:) - mDivInc(i,:) - mDeadInc(i,:);
end

mLive = zeros(size(mLiveInc));
mLive(1,1) = 1;
% 4th order
mLive(:,2) = mLive(:,1) + dt*mLiveInc(:,1);
for j = 3:nTimeSteps
	mLive(:,j) = mLive(:,j - 2) + dt/3.0 ...
		*(mLiveInc(:,j - 2) + 4.0*mLiveInc(:,j - 1) + mLiveInc(:,j));
end

mLive = max(mLive, 0);
mLive = mLive.*curParams(idxPar.scale);
mLive = [vTime; mLive];

idx = measuredData.idx;
predictedData = cell(1, idx.last);
predictedData{idx.live} = mLive;
predictedData{idx.dead} = [];
predictedData{idx.drop} = [];
end
%{
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013
%}
function runSimTest()
global appContext;
global modelParams;
global idxPar;
clc; close all;
addpath('core', 'cmi', 'ui');
sParFile = 'L:\akan\cellular calculus\destiny of t cells\EX66 + 103b\EX66 103b par after fit updated v1.xls';

appContext.bLognDestiny = 1;
appContext.maxEvalDiv = 50;
appContext.maxEvalTime = 150;
appContext.minDestProb = 1.0e-9; % used for progressor fraction
idxPar = initParamsOrder();

modelParams = NaN(14,9);
loadParameters(sParFile);
modelParams(idxPar.scale,:) = 2;
measTimes = [0, 50, 150];

nRep = 300;
it = 2;
for i = 1:nRep
	simPop = cell_sim(modelParams(:,5), 0, measTimes);
	mLive = simPop{1};
	
	m0(i) = mLive(2, it);
	m1(i) = mLive(3, it);
	m2(i) = mLive(4, it);
	m3(i) = mLive(5, it);
	m4(i) = mLive(6, it);
	m5(i) = mLive(7, it);
end

[r, p] = corr(m0(:), m1(:));
fprintf('corr m0-m1: r = %0.3f; p = %0.3f\n', r, p);
[r, p] = corr(m0(:), m3(:));
fprintf('corr m0-m3: r = %0.3f; p = %0.3f\n', r, p);
[r, p] = corr(m0(:), m4(:));
fprintf('corr m0-m4: r = %0.3f; p = %0.3f\n', r, p);
[r, p] = corr(m2(:), m3(:));
fprintf('corr m2-m3: r = %0.3f; p = %0.3f\n', r, p);
[r, p] = corr(m3(:), m4(:));
fprintf('corr m3-m4: r = %0.3f; p = %0.3f\n', r, p);
[r, p] = corr(m4(:), m5(:));
fprintf('corr m4-m5: r = %0.3f; p = %0.3f\n', r, p);
[r, p] = corr(m1(:), m5(:));
fprintf('corr m1-m5: r = %0.3f; p = %0.3f\n', r, p);

cov([m0(:), m1(:), m2(:), m3(:), m4(:), m5(:)])

mean(m0)
mean(m1)
mean(m2)
mean(m3)
mean(m4)
mean(m5)

return;

hold on;
plot(vTime, vDeadTot, 'k');
hold on;
plot(vTime, vDropTot, 'r');
hold on;
xlim([0 appContext.maxEvalTime - 1]);
ylim([1 14000]);

figure;
for iDiv = 1:12
	subplot(3, 4, iDiv);
	plot(vTime(:), mLive(:, iDiv));
	hold on;
	plot(vTime(:), mDrop(:, iDiv), 'r');
end

% measuredData	= ctx.measuredData;
ctx.appContext = appContext;
ctx.modelParams = modelParams;
ctx.idxPar = idxPar;
measuredData.idx = initDataOrder();
ctx.measuredData = measuredData;
predictedData = computeModel(ctx, 1);

mLive = predictedData{1}';
mDead = predictedData{2}';
mDrop = predictedData{3}';
mLive = mLive(:,2:end);
mDead = mDead(:,2:end);
mDrop = mDrop(:,2:end);

vLiveTot = sum(mLive, 2);
vDeadTot = sum(mDead, 2);
vDropTot = sum(mDrop, 2);

figure;
semilogy(vTime, vLiveTot);
hold on;
plot(vTime, vDeadTot, 'k');
hold on;
plot(vTime, vDropTot, 'r');
hold on;
xlim([0 appContext.maxEvalTime - 1]);
ylim([1 14000]);

figure;
for iDiv = 1:12
	subplot(3, 4, iDiv);
	plot(vTime(:), mLive(:, iDiv));
	hold on;
	plot(vTime(:), mDrop(:, iDiv), 'r');
end
end
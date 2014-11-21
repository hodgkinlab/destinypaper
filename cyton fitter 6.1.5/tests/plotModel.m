function plotModel( predictedData,figNum )

global measuredData;

idx = measuredData.idx;

mLivePred = predictedData{idx.live};
mDropPred = predictedData{idx.drop};
mDeadPred = predictedData{idx.dead};

%{
subplot(1,3,1);
plot(mLivePred(1,:), sum(mLivePred(2:end,:)), 'b', 'LineWidth', 2);

subplot(1,3,2);
plot(mDeadPred(1,:), sum(mDeadPred(2:end,:)), 'b', 'LineWidth', 2);

subplot(1,3,3);
plot(mDropPred(1,:), sum(mDropPred(2:end,:)), 'b', 'LineWidth', 2);
%}
figure(figNum);
%{
subplot(1,2,1)
plot(...
	mLivePred(1,:), sum(mLivePred(2:end,:)), 'b', ...
	mDeadPred(1,:), sum(mDeadPred(2:end,:)), 'r', ...
	mDropPred(1,:), sum(mDropPred(2:end,:)), 'g')
subplot(1,2,2)
%}
semilogy(...
	mLivePred(1,:), sum(mLivePred(2:end,:)), 'b', ...
	mDropPred(1,:), sum(mDropPred(2:end,:)), 'g')
end


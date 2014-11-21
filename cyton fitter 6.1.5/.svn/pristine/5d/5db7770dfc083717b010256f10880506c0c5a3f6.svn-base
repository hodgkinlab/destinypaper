%{
% Calculates the distance between two models
%
% INPUTS:
%	- model1,model2: two models as calculated by computeModel
%	- metric: finction that calculated distance between two function-output
%	  vectors
%}

function dist = modelComp( model1, model2, metric)

	mLivePred1 = model1{1};
	mDeadPred1 = model1{2};
	mDropPred1 = model1{3};

	mLivePred2 = model2{1};
	mDeadPred2 = model2{2};
	mDropPred2 = model2{3};

	diffLive = metric(sum(mLivePred1(2:end,:)), sum(mLivePred2(2:end,:)));
	diffDead = metric(sum(mDeadPred1(2:end,:)), sum(mDeadPred2(2:end,:)));
	diffDrop = metric(sum(mDropPred1(2:end,:)), sum(mDropPred2(2:end,:)));
	
	dist = mean([diffLive, diffDead, diffDrop]);

end


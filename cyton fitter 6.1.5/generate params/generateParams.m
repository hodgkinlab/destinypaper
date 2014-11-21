function [paramSet, modelSet] = generateParams( numGens )

paramSet = zeros(14, numGens);
modelSet = cell(1, numGens);

for ii =  1:numGens;
	paramSet(:,ii) = randParams;
	ctx = ctxGet(paramSet(:,ii));
	modelSet{ii} = computeModel(ctx, 1);
end

end


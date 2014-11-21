function saveStatPlots( fitStats,  filePath, display  )

% histogram of aic values
AICVec = cell2mat(fitStats(2:end, 4));

h1 = figure();

if (~display)
	set(h1, 'Visible', 'off');
end

hist(AICVec, 20);
title('AICs of fitted parameters');

AICStatStr = sprintf('\\mu = %1.3f \n\\sigma = %2.3f', mean(AICVec), std(AICVec));
annotation('textbox', [0.65, 0.8, 0.2, 0.1], 'String', AICStatStr);

saveas(h1, [filePath,'/stat_fig1'], 'tif')

% histogram of numbers of iterations
IterVec = cell2mat(fitStats(2:end, 5));

h2 = figure();

if (~display)
	set(h2, 'Visible', 'off');
end

hist(IterVec, 20);
title('Iterations before fmincon terminated');

IterStatStr = sprintf('\\mu = %1.3f \n\\sigma = %2.3f', mean(IterVec), std(IterVec));
annotation('textbox', [0.65, 0.8, 0.2, 0.1], 'String', IterStatStr);

saveas(h2, [filePath,'/stat_fig2'], 'tif')

% scatter plot of the previous two vectors
h3 = figure();

if (~display)
	set(h3, 'Visible', 'off');
end

scatter(IterVec, AICVec);
title('Iterations vs. AIC');
xlabel('Iterations');
ylabel('AIC');

saveas(h3, [filePath,'/stat_fig3'], 'tif')
end



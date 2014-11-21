%}
% Plots various information about fit results
%}
function plotFitStats( fitStats )

% histogram of aic values
AICVec = cell2mat(fitStats(2:end, 4));
figure();
hist(AICVec, 20);
title('AICs of fitted parameters');

AICStatStr = sprintf('\\mu = %1.3f \n\\sigma = %2.3f', mean(AICVec), std(AICVec));
annotation('textbox', [0.65, 0.8, 0.2, 0.1], 'String', AICStatStr);

% histogram of numbers of iterations
IterVec = cell2mat(fitStats(2:end, 5));
figure();
hist(IterVec, 20);
title('Iterations before fmincon terminated');

IterStatStr = sprintf('\\mu = %1.3f \n\\sigma = %2.3f', mean(IterVec), std(IterVec));
annotation('textbox', [0.65, 0.8, 0.2, 0.1], 'String', IterStatStr);

% scatter plot of the previous two vectors
figure();
scatter(IterVec, AICVec);
title('Iterations vs. AIC');
xlabel('Iterations');
ylabel('AIC');
end


%}
% Plots various information about fit results
%}
function plotParamStats( paramStats, initStats )

global idxPar;
names = fieldnames(idxPar);

% histogram each relevant parameter
for i=1:11%size(paramStats, 1);
    paramCurr = paramStats(i,:);
    paramInitCurr = initStats(i,:);
    
    figure();
    %{
    NOT USED
    %hist([log(paramCurr)/log(10);log(paramInitCurr)/log(10)]');
    %}
    hist([paramCurr;paramInitCurr]');
    
    title(['Distribution of logarithms of ', names(i)]);
    legend('Fitted parameters','Seed parameters');
    
    % mean and standard deviation of parameters
    paramStatStr = sprintf('\\mu = %1.3f \nMd = %2.3f\n\\sigma = %3.3f', mean(paramCurr), median(paramCurr), std(paramCurr));
    hTextBox = annotation('textbox', [0.7, 0.6, 0.2, 0.15], 'String', paramStatStr);
    
    % textbox white background
    set(hTextBox, 'BackgroundColor', [1, 1, 1]);
end

end
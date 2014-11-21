%{
% Saves plots of fitted data without displaying it
%}

function value = savePlots( filePath, curConc )

if ~exist(filePath, 'dir')
    mkdir(filePath)
end

figure('Visible','off')

[~, value] = makePlots(curConc, 0);

handles = findobj('Type','figure');

for i = 1:numel(handles)
    saveas(handles(i), [filePath,'/fig', int2str(i)], 'tif')
end

end


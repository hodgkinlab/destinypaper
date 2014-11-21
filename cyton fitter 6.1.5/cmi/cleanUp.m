%{
% If using command line interface, should be run at the end of any script
%}
function cleanUp()
    global appContext;
    save(appContext.sSettingsFile, 'appContext');
end
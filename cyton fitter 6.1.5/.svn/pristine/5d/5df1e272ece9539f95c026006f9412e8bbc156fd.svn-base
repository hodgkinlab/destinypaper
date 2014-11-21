%{
% Adjusts the value of a field in the vLockParam or vFixParam fields
% of appContext
% 
% Possible fieldNames are:
%   uDivFirst
%   sDivFirst
%   uDthFirst
%   sDthFirst
%   uDivBlast
%   sDivBlast
%   uDthBlast
%  msDthBlast
%      gamma0
%      uGamma
%      sGamma
%       scale
%   numZombie
%   mechDecay
%        last
%
% fieldState should be either 'lock' or 'fix'
%
% value should be either 1 or 0
%}

function adjustContext( fieldName, fieldState, value )

global appContext
global idxPar

if (strcmp(fieldState, 'lock'))
    ctxRef = 'vLockParam';
elseif (strcmp(fieldState, 'fix'))
    ctxRef = 'vFixParam';
else
    error('fieldState should be set to either ''lock'' or ''fix''')
end

appContext.(ctxRef)(idxPar.(fieldName)) = value;

end


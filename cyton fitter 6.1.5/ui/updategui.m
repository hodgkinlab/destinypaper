%{
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013
%}
function updategui(handles)
global modelParams;
global idxPar;

curConc = get(handles.listboxConcs, 'Value');
curParams = modelParams(:,curConc);

set(handles.edit_div_mu_undiv, ...
	'string', num2str(exp(curParams(idxPar.uDivFirst))));
set(handles.edit_div_sigma_undiv, ...
	'string', num2str(curParams(idxPar.sDivFirst)));
set(handles.edit_death_mu_undiv, ...
	'string', num2str(exp(curParams(idxPar.uDthFirst))));
set(handles.edit_death_sigma_undiv, ...
	'string', num2str(curParams(idxPar.sDthFirst)));
set(handles.edit_div_mu_blast, ...
	'string', num2str(exp(curParams(idxPar.uDivBlast))));
set(handles.edit_div_sigma_blast, ...
	'string', num2str(curParams(idxPar.sDivBlast)));
set(handles.edit_death_mu_blast, ...
	'string', num2str(exp(curParams(idxPar.uDthBlast))));
set(handles.edit_death_sigma_blast, ...
	'string', num2str(curParams(idxPar.sDthBlast)));
set(handles.edit_gamma_0, ...
	'string', num2str(curParams(idxPar.gamma0)));
set(handles.edit_mu_gamma, ...
	'string', num2str(curParams(idxPar.uGamma)));
set(handles.edit_sigma_gamma, ...
	'string', num2str(curParams(idxPar.sGamma)));
set(handles.edit_scale, ...
	'string', num2str(curParams(idxPar.scale)));
set(handles.editNumZombie, ...
	'string', num2str(curParams(idxPar.numZombie)));
set(handles.editMechDecay, ...
	'string', num2str(curParams(idxPar.mechDecay)));

uiUpdateParamPlots(handles);
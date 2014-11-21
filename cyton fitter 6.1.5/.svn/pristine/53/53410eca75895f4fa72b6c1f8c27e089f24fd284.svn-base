%{
% Update locked/fixed checkboxes in GUI according to provided vectors
%
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013 ~ 2014
%}
function setLockedFixed(handles, idxPar, locked, fixed)
set(handles.checkbox_mu_div_undiv,		'Value', locked(idxPar.uDivFirst));
set(handles.checkbox_sigma_div_undiv,	'Value', locked(idxPar.sDivFirst));
set(handles.checkbox_mu_death_undiv,	'Value', locked(idxPar.uDthFirst));
set(handles.checkbox_sigma_death_undiv, 'Value', locked(idxPar.sDthFirst));
set(handles.checkbox_mu_div_blast,		'Value', locked(idxPar.uDivBlast));
set(handles.checkbox_sigma_div_blast,	'Value', locked(idxPar.sDivBlast));
set(handles.checkbox_mu_death_blast,	'Value', locked(idxPar.uDthBlast));
set(handles.checkbox_sigma_death_blast,	'Value', locked(idxPar.sDthBlast));
set(handles.checkbox_gamma_0,			'Value', locked(idxPar.gamma0));
set(handles.checkbox_gamma_mu,			'Value', locked(idxPar.uGamma));
set(handles.checkbox_gamma_sigma,		'Value', locked(idxPar.sGamma));
set(handles.checkbox_scale,				'Value', locked(idxPar.scale));

set(handles.checkbox_fix_1,	'Value', fixed(idxPar.uDivFirst));
set(handles.checkbox_fix_2,	'Value', fixed(idxPar.sDivFirst));
set(handles.checkbox_fix_3,	'Value', fixed(idxPar.uDthFirst));
set(handles.checkbox_fix_4,	'Value', fixed(idxPar.sDthFirst));
set(handles.checkbox_fix_5,	'Value', fixed(idxPar.uDivBlast));
set(handles.checkbox_fix_6,	'Value', fixed(idxPar.sDivBlast));
set(handles.checkbox_fix_7,	'Value', fixed(idxPar.uDthBlast));
set(handles.checkbox_fix_8,	'Value', fixed(idxPar.sDthBlast));
set(handles.checkbox_fix_9,	'Value', fixed(idxPar.gamma0));
set(handles.checkbox_fix_10,'Value', fixed(idxPar.uGamma));
set(handles.checkbox_fix_11,'Value', fixed(idxPar.sGamma));
set(handles.checkbox_fix_12,'Value', fixed(idxPar.scale));
end
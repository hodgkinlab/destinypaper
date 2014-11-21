%{
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013
%}
function [locked, fixed] = getLockedFixed(handles, idxPar)
locked = NaN(idxPar.last, 1);
locked(idxPar.uDivFirst)	= get(handles.checkbox_mu_div_undiv, 'Value');
locked(idxPar.sDivFirst)	= get(handles.checkbox_sigma_div_undiv, 'Value');
locked(idxPar.uDthFirst)	= get(handles.checkbox_mu_death_undiv, 'Value');
locked(idxPar.sDthFirst)	= get(handles.checkbox_sigma_death_undiv, 'Value');
locked(idxPar.uDivBlast)	= get(handles.checkbox_mu_div_blast, 'Value');
locked(idxPar.sDivBlast)	= get(handles.checkbox_sigma_div_blast, 'Value');
locked(idxPar.uDthBlast)	= get(handles.checkbox_mu_death_blast, 'Value');
locked(idxPar.sDthBlast)	= get(handles.checkbox_sigma_death_blast, 'Value');
locked(idxPar.gamma0)		= get(handles.checkbox_gamma_0, 'Value');
locked(idxPar.uGamma)		= get(handles.checkbox_gamma_mu, 'Value');
locked(idxPar.sGamma)		= get(handles.checkbox_gamma_sigma, 'Value');
locked(idxPar.scale)		= get(handles.checkbox_scale, 'Value');
locked(idxPar.numZombie)	= 1;
locked(idxPar.mechDecay)	= 1;

fixed = NaN(idxPar.last, 1);
fixed(idxPar.uDivFirst)	= get(handles.checkbox_fix_1, 'Value');
fixed(idxPar.sDivFirst)	= get(handles.checkbox_fix_2, 'Value');
fixed(idxPar.uDthFirst)	= get(handles.checkbox_fix_3, 'Value');
fixed(idxPar.sDthFirst)	= get(handles.checkbox_fix_4, 'Value');
fixed(idxPar.uDivBlast)	= get(handles.checkbox_fix_5, 'Value');
fixed(idxPar.sDivBlast)	= get(handles.checkbox_fix_6, 'Value');
fixed(idxPar.uDthBlast)	= get(handles.checkbox_fix_7, 'Value');
fixed(idxPar.sDthBlast)	= get(handles.checkbox_fix_8, 'Value');
fixed(idxPar.gamma0)	= get(handles.checkbox_fix_9, 'Value');
fixed(idxPar.uGamma)	= get(handles.checkbox_fix_10, 'Value');
fixed(idxPar.sGamma)	= get(handles.checkbox_fix_11, 'Value');
fixed(idxPar.scale)		= get(handles.checkbox_fix_12, 'Value');
fixed(idxPar.numZombie)	= 1;
fixed(idxPar.mechDecay)	= 1;
end
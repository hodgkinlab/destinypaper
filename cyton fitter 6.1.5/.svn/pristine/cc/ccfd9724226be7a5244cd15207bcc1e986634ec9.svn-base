function printParamInfo(fid, handles)
global modelParams;
global idxPar;

[~, vFixed] = getLockedFixed(handles, idxPar);
numConc = size(modelParams, 2);
fprintf(fid, '===============================================\n');
fprintf(fid, 'division and death times are modelled ');
fprintf(fid, 'using a lognormal distribution\n');
fprintf(fid, 'division destiny is modelled ');
fprintf(fid, 'using a gamma distribution\n');
fprintf(fid, '-----------------------------------------------\n');
for i = 1:numConc
	fprintf(fid, 'conc = %d\n', i);
	curParam = modelParams(:,i);
	if ( (i == 1) || (~vFixed(idxPar.uDivFirst)) )
		[u, v] = lognstat( ...
			curParam(idxPar.uDivFirst), curParam(idxPar.sDivFirst));
		fprintf(fid, 'first div.: mean = %0.1f; st.dev. = %0.1f\n', ...
			u, sqrt(v));
	end
	if ( (i == 1) || (~vFixed(idxPar.uDthFirst)) )
		[u, v] = lognstat( ...
			curParam(idxPar.uDthFirst), curParam(idxPar.sDthFirst));
		fprintf(fid, 'first death: mean = %0.1f; st.dev. = %0.1f\n', ...
			u, sqrt(v));
	end
	if ( (i == 1) || (~vFixed(idxPar.uDivBlast)) )
		[u, v] = lognstat( ...
			curParam(idxPar.uDivBlast), curParam(idxPar.sDivBlast));
		fprintf(fid, 'subseq. div.: mean = %0.1f; st.dev. = %0.1f\n', ...
			u, sqrt(v));
	end
	if ( (i == 1) || (~vFixed(idxPar.uDthBlast)) )
		[u, v] = lognstat( ...
			curParam(idxPar.uDthBlast), curParam(idxPar.sDthBlast));
		fprintf(fid, 'subseq. death: mean = %0.1f; st.dev. = %0.1f\n', ...
			u, sqrt(v));
	end
% 	if ( (i == 1) || (~vFixed(idxPar.gamma0)) )
% 		fprintf(fid, 'prop. prog. = %0.1f\n', curParam(idxPar.gamma0));
% 	end
	if ( (i == 1) || (~vFixed(idxPar.uGamma)) )
		fprintf(fid, 'div. destiny: mean = %0.1f; st.dev. = %0.1f\n', ...
			curParam(idxPar.uGamma),  curParam(idxPar.sGamma));
	end
	fprintf(fid, '\n');
end
fprintf(fid, '\n');

label = get(handles.textFitDist, 'String');
value = get(handles.editFitDist, 'String');
fprintf(fid, '%s: %s\n', label, value);
end
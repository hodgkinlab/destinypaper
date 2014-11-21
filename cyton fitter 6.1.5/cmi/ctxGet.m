function ctx = ctxGet(varargin)
global measuredData
global appContext
global modelParams
global idxPar

ctx.measuredData	= measuredData;
ctx.appContext		= appContext;
ctx.idxPar			= idxPar;

if nargin == 0
	ctx.modelParams	= modelParams;
else
	ctx.modelParams = cell2mat(varargin);
end

end
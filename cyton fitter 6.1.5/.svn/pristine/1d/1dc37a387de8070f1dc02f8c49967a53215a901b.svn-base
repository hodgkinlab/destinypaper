%{
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013
%}
function updateplots(curConc, predictedData, areVisible)
global measuredData;
global appContext;



idx = measuredData.idx;
arrFigPos = appContext.arrFigPos;

mLive = measuredData.data{idx.live};
mDead = measuredData.data{idx.dead};
mDrop = measuredData.data{idx.drop};

mLivePred = predictedData{idx.live};
mDropPred = predictedData{idx.drop};
mDeadPred = predictedData{idx.dead};

lightBlue = [165 162 234]/256;
lightRed = [252 150 150]/256;
grey = [145 145 145]/256;

% live cells, and dropped live cells
if (1)    
    figure(1);
    if (~areVisible)
        set(1, 'visible', 'off')
    end
    cla();
    h1 = subplot(1, 3, 1);
	h2 = subplot(1, 3, 2);
	h3 = subplot(1, 3, 3);
    %if (~areVisible)
     %   set(h1, 'visible', 'off')
     %   set(h2, 'visible', 'off')
     %   set(h3, 'visible', 'off')
    %end
	axes(h1);
	hold off;
	vData = sum(mLivePred(2:end,:));
	semilogy(mLivePred(1,:), max(vData, 0), ...
		'Color', 'b', 'LineWidth', 2);
	axes(h2);
	hold off;
	if (~isempty(mDropPred))
		vData = sum(mDropPred(2:end,:));
		semilogy(mDropPred(1,:), max(vData, 0), 'r', 'LineWidth', 2);
	end
	axes(h3);
	hold off;
	plot(mLivePred(1,:), sum(mLivePred(2:end,:)), ...
		'Color', 'b', 'LineWidth', 2);
	hold on;
	sLegend = {'live cells'};
	if (~isempty(mDropPred))
		plot(mDropPred(1,:), sum(mDropPred(2:end,:)), 'r', 'LineWidth', 2);
		sLegend = [sLegend, 'dropped cells'];
	end
	if (~isempty(mLive))

		mLive = squeeze(mLive(:,:,curConc));
		vTime = mLive(1,:);
		if (size(mLive, 1) == 2)
			vTotal = mLive(2,:);
		else
			vTotal = nansum(mLive(2:end,:));
		end
		axes(h1);
        hold on;
		semilogy(vTime, vTotal, ...
			'Marker', 'o', 'Color', lightBlue, 'LineStyle', 'none');
		axes(h3);
		hold on;
		plot(vTime, vTotal, ...
			'Marker', 'o', 'Color', lightBlue, 'LineStyle', 'none');
		[vUnqTime, ~, vMap] = unique(vTime);
		vUnqTotal = NaN(size(vUnqTime));
		nUnique = numel(vUnqTime);
		for i = 1:nUnique
			vCurr = vTotal(vMap == i);
			vUnqTotal(i) = mean(vCurr);
		end
		axes(h1);
		hold on;
		semilogy(vUnqTime, vUnqTotal, 'r+', 'LineWidth', 1.6);
		axes(h3);
		hold on;
		plot(vUnqTime, vUnqTotal, 'r+', 'LineWidth', 1.6);
		
		sLegend = [sLegend, 'measured live', 'triplicate means'];
	end
	if (~isempty(mDrop))    
        
		mDrop = squeeze(mDrop(:,:,curConc));
		vTime = mDrop(1,:);
		if (size(mDrop, 1) == 2)
			vTotal = mDrop(2,:);
		else
			vTotal = nansum(mDrop(2:end,:));
		end
		axes(h2);
		hold on;
		semilogy(vTime, vTotal, ...
			'Marker', 'd', 'Color', lightRed, 'LineStyle', 'none');
		axes(h3);
		hold on;
		plot(vTime, vTotal, ...
			'Marker', 'd', 'Color', lightRed, 'LineStyle', 'none');
		[vUnqTime, ~, vMap] = unique(vTime);
		vUnqTotal = NaN(size(vUnqTime));
		nUnique = numel(vUnqTime);
		for i = 1:nUnique
			vCurr = vTotal(vMap == i);
			vUnqTotal(i) = mean(vCurr);
		end
		axes(h2);
		hold on;
		semilogy(vUnqTime, vUnqTotal, 'b+', 'LineWidth', 1.2);
		axes(h3);
		hold on;
		plot(vUnqTime, vUnqTotal, 'b+', 'LineWidth', 1.2);
		sLegend = [sLegend, 'measured dropped', 'triplicate means'];
	end
	axes(h3);
	vLimX = xlim();
	vLimY = ylim();
	axes(h1);
	xlim(vLimX);
	ylim([1, vLimY(end)]);
	xlabel('time');
	ylabel('total number of live cells');
	
	axes(h2);
	xlim(vLimX);
	ylim([1, vLimY(end)]);
	xlabel('time');
	ylabel('total number of dropped cells');
	
	axes(h3);
	legend(sLegend, 'location', 'best');
	ylim([0, vLimY(2)]);
	xlabel('time');
	ylabel('total number of cells');
    
    % Unfortunately, even if areVisible == 0, the figure will briefly
    % flash onto the screen. This seems to be a bug in MATLAB
    if (~areVisible)
        set(1, 'visible', 'off')
    end
    
end

% dead cells
if (1)
	figure(2);
	cla();
	if (~isempty(mDeadPred))
		meanPredNums = sum(mDeadPred(2:end,:), 1);
		plot(mDeadPred(1,:), meanPredNums, ...
			'Color', 'k', 'LineWidth', 2);
	end
	if (~isempty(mDead))
		mDead = squeeze(mDead(:,:,curConc));
		vTime = mDead(1,:);
		if (size(mDead, 1) > 2)
			vTotal = nansum(mDead(2:end,:));
		else
			vTotal = mDead(2,:);
		end
		hold on;
		plot(vTime, vTotal, ...
			'Marker', 'o', 'Color', grey, 'LineStyle', 'none');
		[vUnqTime, ~, vMap] = unique(vTime);
		vUnqTotal = NaN(size(vUnqTime));
		nUnique = numel(vUnqTime);
		for i = 1:nUnique
			vCurr = vTotal(vMap == i);
			vUnqTotal(i) = mean(vCurr);
		end
		hold on;
		plot(vUnqTime, vUnqTotal, 'm+', 'LineWidth', 1.6);
	end
	xlabel('time');
	ylabel('total number of dead cells');
	vLims = ylim();
	ylim([0, vLims(2)]);
	%ylim([0.1*min(vUnqTotal + 1), 10*max(vUnqTotal)]);
    
    if (~areVisible)
        set(2, 'visible', 'off')
    end
end


% numbers of cells per division
if (appContext.bLiveOnly)
	nTypes = 1;
	if (ishandle(4))
		close(4);
	end
	if (ishandle(5))
		close(5);
	end
else
	nTypes = idx.last;
end
for iType = 1:nTypes
	mData = measuredData.data{iType};
	mPred = predictedData{iType};
	
	figure(2 + iType);
	cla();
	if (isempty(mData))
		maxDiv = 9;
		n = ceil(sqrt(maxDiv));
		for iDiv = 1:maxDiv
			subplot(n, n, iDiv);
			hold off;
			plot(mPred(1,:), mPred(iDiv + 1,:));
			xlabel('time');
			ylabel(sprintf('num. of %s cells', ...
				measuredData.sDataType{iType}));
		end
	else
		mData = squeeze(mData(:,:,curConc));
		vTime = mData(1,:);
		[vUnqTime, ~, vMap] = unique(vTime);
		vUnqTime = vUnqTime(~isnan(vUnqTime));
		maxDvsn = size(mData, 1) - 1;
		maxTime = numel(vUnqTime);
		
		vDivs = 1:maxDvsn;
		vDivs2 = vDivs + 1;
		
		vPredTime = mPred(1,:);
		mPredLastDivs = mPred((maxDvsn + 1):end,:);
		if (size(mPredLastDivs, 1) == 1)
			vPredLastDivs = mPredLastDivs;
		else
			vPredLastDivs = sum(mPredLastDivs);
		end
		mPred((maxDvsn + 1),:) = vPredLastDivs;
		mPredNew = NaN(maxDvsn + 1, maxTime);
		for iDvsn = vDivs2
			vPred = mPred(iDvsn,:);
			mPredNew(iDvsn,:) = interp1(vPredTime, vPred, vUnqTime);
		end
		
		nCols = ceil(sqrt(maxTime));
		nRows = ceil(maxTime/nCols);
		for iTime = 1:maxTime
			t = vUnqTime(iTime);
			vPred = mPredNew(vDivs2,iTime);
			
			mDataTime = mData(:,(vMap == iTime));
			vMeans = nanmean(mDataTime, 2);
			vMeans = vMeans(vDivs2);
			nReps = size(mDataTime, 2);
			mDataTime = mDataTime(2:end,:);
			mDivs = repmat(vDivs', 1, nReps);
			vX = mDivs(:) - 1;
			vY = mDataTime(:);
			
			subplot(nRows, nCols, iTime);
			hold off;
			plot(vDivs - 1, vPred, 'Marker', '.');
			hold on;
			plot(vX, vY, 'Marker', 'o', ...
				'Color', lightBlue, 'LineStyle', 'none');
			hold on;
			plot(vDivs - 1, vMeans, 'r*', 'LineStyle', 'none');
			hold on;
			title(sprintf('t = %0.1f hours', t));
			vLimY = ylim();
			ylim([0, vLimY(end)]);
			if (iTime == 1)
				xlabel('division');
				ylabel(sprintf('num. of %s cells', ...
					measuredData.sDataType{iType}));
			end
		end
    end
    
    if (~areVisible)
        set(2+iType, 'visible', 'off')
    end
end

nLastFig = 2 + measuredData.idx.last;
for iFig = 1:nLastFig
	if ( ishandle(iFig) && ~isempty(arrFigPos{iFig}) )
		set(iFig, 'Position', arrFigPos{iFig});
	end
end

end
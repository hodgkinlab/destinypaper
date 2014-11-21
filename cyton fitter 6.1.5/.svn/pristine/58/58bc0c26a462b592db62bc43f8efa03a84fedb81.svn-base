%{
% Simulates cyton model.
% Returns the numbers of live, dead and dropped cells
%
% PREREQUSITES:
%   certain global variables are initialized
%   matlabpool is open prior to running
%}
function simPop = cell_sim(params, clonal, measTimes)
global appContext;
global idxPar;

maxDiv = appContext.maxEvalDiv;
maxTime = appContext.maxEvalTime;
nMeas = numel(measTimes);
daughtersPerDiv = 2;

nClones = params(idxPar.scale);
cLive = cell(1, nClones);
cDead = cell(1, nClones);
cDrop = cell(1, nClones);
cLive(1,1:end) = {zeros(nMeas, maxDiv)};
cDead(1,1:end) = {zeros(nMeas, maxDiv)};
cDrop(1,1:end) = {zeros(nMeas, maxDiv)};

gamma = computeProgFrac( ...
	maxDiv, appContext.minDestProb, params(idxPar.gamma0:idxPar.sGamma));

parfor idxClone = 1:nClones %to facillitate sorting we perform a series of single cell simulations 
	pos = 0;
	
	idxMeas = 1;
	num_live = zeros(maxDiv, 1);
	num_dead = zeros(maxDiv, 1);
	num_drop = zeros(maxDiv, 1);
	
	event = repmat(struct('time',[],'type',[],'division',[],'cfse',[],'destiny',[],'early',[]),nMeas,1);
	
	%create the readout events;
	for ii = 1:nMeas
		event(ii).time = measTimes(ii);
		event(ii).type = 2; %this is a readout.
	end
	
	%Create the first event
	event = event_determine(event, 0, params, maxDiv, clonal, gamma);
	if(event(length(event)).early) % the new cell will reach its destiny
		num_drop(1) = num_drop(1)+1;
	end
	
	event_time = [event.time];
	[~,coeffs] = sort(event_time,'ascend');
	event = event(coeffs);
	num_live(1) = 1;
	
	time = event(1).time;
	finger = 1;
	len = Inf;
	
	while(maxTime>time)
		division = event(finger).division;
		type = event(finger).type;
		ev_num = 0;
		if(type == 0)%death
			num_dead(division+1) = num_dead(division+1)+1;
			num_live(division+1) = num_live(division+1)-1;
			if(event(finger).early) % the cell died because it reached its destiny
				num_drop(division+1) = num_drop(division+1)-1;
			end
			if(finger >= len);%we have reached the last event
				time = 4*maxTime; %don't do any more
			end
		elseif(type == 1)%division
			for ii = 1:daughtersPerDiv
				event = event_determine(event,finger,params,maxDiv,clonal, gamma);
				if(event(length(event)).early) % the new cell will reach its destiny
					num_drop(division+2) = num_drop(division+2)+1;
				end
			end
			
			num_live(division+1) = num_live(division+1)-1;
			num_live(division+2) = num_live(division+2)+2;
			ev_num = daughtersPerDiv;
			
		elseif(type == 2) %readout
			cLive{idxClone}(idxMeas,:) = cLive{idxClone}(idxMeas,:) + num_live';
			cDead{idxClone}(idxMeas,:) = cDead{idxClone}(idxMeas,:) + num_dead';
			cDrop{idxClone}(idxMeas,:) = cDrop{idxClone}(idxMeas,:) + num_drop';
			idxMeas = idxMeas + 1;
		end
		
		len = length(event);
		if(len > finger)
			if (event(len).time < event(len - 1).time)
				tmp = event(len);
				event(len) = event(len - 1);
				event(len - 1) = tmp;
			end
			
			% Insert new items into the already sorted vector rather than
			% resorting
			for rep = 1:ev_num
				toBeInserted = event(len);
				
				% Perorm a binary search on the event vector, finding the
				% largest time smaller than the time it be inserted
				lower = finger+1;
				upper = len;
				
				while (lower <= upper)
					pos = floor((lower + upper ) / 2);
					if(event(pos).time < toBeInserted.time)
						lower = pos + 1;
					else
						upper = pos - 1;
					end
				end
				
				event(pos+1:len) = event(pos:len-1);
				event(pos) = toBeInserted;
			end
	
			finger = finger+1;
			time = event(finger).time;
		end
	end
end
%end

simPop{1} = [measTimes;sum(reshape(cell2mat(cLive), nMeas, maxDiv, nClones), 3)'];
simPop{2} = [measTimes;sum(reshape(cell2mat(cDead), nMeas, maxDiv, nClones), 3)'];
simPop{3} = [measTimes;sum(reshape(cell2mat(cDrop), nMeas, maxDiv, nClones), 3)'];
end
function event = event_determine(event,eventno,params,Tot_gen,clonal, gamma)
cfse_m = 0;%logn_m(cfse_mu,cfse_sigma);
cfse_s = 1;%logn_s(cfse_mu,cfse_sigma);

len = length(event);

if(eventno == 0)
    eta = zeros(Tot_gen,1);
    eta(1) = 1-gamma(1);
    for ii = 2:Tot_gen
        eta(ii) = prod(gamma(1:(ii-1)))*(1-gamma(ii));
    end
    destiny = redist(rand(),eta)-1; %this chooses a random number from the distribution eta
    %cells do not divide when they reach their destiny
    time = 0.0;
    division = 0;
    cfse = exp(cfse_m+cfse_s*randn());
else
    destiny = event(eventno).destiny;
    time = event(eventno).time;
    division = event(eventno).division+1;
    cfse = event(eventno).cfse/2;
end


if(division == 0) 
    time1 = params(1);
    time2 = params(2);
    time3 = params(3);
    time4 = params(4);
    if(clonal)
        divprob = destiny > division;
    else
        divprob = gamma(1);
    end
else
    time1 = params(5);
    time2 = params(6);
    time3 = params(7);
    time4 = params(8);
    if(clonal)
        divprob = destiny > division; 
    else
        divprob = gamma(division+1);
    end
    
end

m1 = time1;%log(time1^2/sqrt(time1^2+time2^2));
s1 = time2;%sqrt(log((time2/time1)^2+1));    
m2 = time3;%log(time3^2/sqrt(time3^2+time4^2));
s2 = time4;%sqrt(log((time4/time3)^2+1));

tdiv = time+lognrnd(m1,s1);
tdeath = time+lognrnd(m2,s2);

randdiv =  rand();

% event.early shows whether the cell would die because its death clock
% finished before its division clock or because it reached its destiny
event(len+1).early = randdiv >= divprob;

if(division ~= Tot_gen)
    if(tdiv<tdeath && randdiv < divprob) % division
        event(len+1).time = tdiv;
        event(len+1).type = 1;
        event(len+1).division = division;
        event(len+1).cfse = cfse;
        event(len+1).destiny = destiny;
    else % death
        event(len+1).time = tdeath;
        event(len+1).type = 0;
        event(len+1).division = division;
        event(len+1).cfse = cfse;
        event(len+1).destiny = destiny;
    end
elseif(actual_division == Tot_gen)
    event(len+1).time = tdeath;
    event(len+1).type = 0;
    event(len+1).division = division;
    event(len+1).cfse = cfse;
    event(len+1).destiny = destiny;
end
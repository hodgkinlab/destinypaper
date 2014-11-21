% Simple test for cell_sim that plots the total numer of living, dead and
% predestined cells at the times specified in range

% range     - vector of time points of interest
% params    - parameter vector used by cell_sim
% gen       - max number of cell generations
% clonal    - indicator variable:
%                 1 - clonal
%                 2 - non-clonal
% fig       - number of figure to be plotted

function sim_test(range, params, gen, clonal, fig)

init = @(a)a(1:length(a) - 1);

[live, dead, last] = cell_sim(params, gen, range, clonal, 1);

live_tot = sum(live');
dead_tot = sum(dead');
last_tot = sum(last');

range = init(range);
live_tot = init(live_tot);
dead_tot = init(dead_tot);
last_tot = init(last_tot);

figure(fig);
plot(range, live_tot, 'r', range, dead_tot, 'b', range, last_tot, 'g')
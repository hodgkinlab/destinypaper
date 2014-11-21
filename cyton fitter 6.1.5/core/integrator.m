%{
% Runge–Kutta method (RK4)
%
% correspondence to Andrey Kan: akan@wehi.edu.au
% Hodgkin Lab, Walter and Eliza Hall Institute
% 2013
%}
function [mLive, mDead, mDrop] ...
	= integrator(mLiveInc, mDeadInc, mDropInc, vTime, gamma0)

Tsteps = length(vTime);
dt = vTime(2)-vTime(1);

mLive = zeros(size(mLiveInc));
mDead = zeros(size(mDeadInc));
mDrop = zeros(size(mDropInc));

mLive(1,1) = 1;
mDead(1,1) = 0;
mDrop(1,1) = (1 - gamma0);

% 4th order
mLive(:,2) = mLive(:,1) + dt*mLiveInc(:,1);
mDead(:,2) = mDead(:,1) - dt*mDeadInc(:,1);
mDrop(:,2) = mDrop(:,1) + dt*mDropInc(:,1);

for j = 3:Tsteps
	mLive(:,j) = mLive(:,j - 2) + dt/3.0 ...
		*(mLiveInc(:,j - 2) + 4.0*mLiveInc(:,j - 1) + mLiveInc(:,j));
	mDead(:,j) = mDead(:,j - 2) + dt/3.0 ...
		*(mDeadInc(:,j - 2) + 4.0*mDeadInc(:,j - 1) + mDeadInc(:,j));
	mDrop(:,j) = mDrop(:,j - 2) + dt/3.0 ...
		*(mDropInc(:,j - 2) + 4.0*mDropInc(:,j - 1) + mDropInc(:,j));
end
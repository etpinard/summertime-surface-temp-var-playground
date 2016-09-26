%%% Program that seeks to best way to define to the two regimes of
	% evaporation control (refer to correlations patterns in
	% correlations/{control_E,param_E}).
	%
	%	Plotting is automated using plot_summeravg.m
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%%% 1) The mean evaporative fraction (L*Ebar/Fbar)

cvec = [0:0.05:0.5]; color_handle = [];
bins = [0:0.005:0.5]; yval = 10;

name = 'regime_LE-F';
Z = L*Ebar./Fbar;
mystats(Z)

plot_summeravg;
% ======================================================================


%%% 2) The fraction of non-precipitating radiative forcing used to
	%		 evaporate soil water (L*Ebar/Fbar)

	%% But wait ... how to compute F0bar?	

% ======================================================================


%%% 3) The mean surface layer soil moisture mbar

cvec = [0:2:40]; color_handle = [];
bins = [0:0.5:50]; yval = 0.1;

name = 'regime_mbar';
Z = mbar;
mystats(Z)

plot_summeravg;
% ======================================================================


%%% 4) The mean surface layer soil moisture mbar times the
	 %	 mean radiative forcing (mbar*Fbar)

cvec = [0:3:30]; color_handle = [];
bins = [0:0.1:40]; yval = 0.1;

name = 'regime_Fbarmbar';
Z = Fbar.*mbar./1000;
mystats(Z)

plot_summeravg;
% ======================================================================

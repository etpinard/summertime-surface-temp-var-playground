%%% Program seeking to best define the saturation criterion 
	% for a specifc model. 
	%
	% Its results are then placed inside startup_crit.m
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%% 
%% Make sure to have an unrestircted m_range e.g. [0,1e6]. 
%%	i.e. call startup_crit('none') in startup.m
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%% Plotting and statistics of mfbarbar 

name = 'mfbar_fullrange';
Z = sqmean(mbar+mbbar);
Z1d = make1d(Z);

max(Z1d)
min(Z1d)
nanmean(Z1d)
nanstd(Z1d)

cvec = [0:100:2000]; color_handle = [];
bins = [0:10:4000]; yval = 3e-3;

plot_summeravg;
% ======================================================================

%% Plotting and statistics of mbarbar 

name = 'mbar_fullrange';
Z = sqmean(mbar);
Z1d = make1d(Z);

max(Z1d)
min(Z1d)
nanmean(Z1d)
nanstd(Z1d)

cvec = [0:2.5:50]; color_handle = [];
bins = [0:0.2:110]; yval = 0.3;

plot_summeravg;
% ======================================================================

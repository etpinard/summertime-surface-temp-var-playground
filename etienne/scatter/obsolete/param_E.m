%%% Scatter analysis of the E' parameterization (see regressions/ for
	% details). Investigates the behavior of the residual, E_00'
	%
	% Attempts to restict the range of m' on which the projection takes
	% place.
	%
	% Here, plot_scatter_locs is used to facilitate looping
	% across all the locations listed in locations.m
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m , locations.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%% No annotations, but line guidance for all plots generated here.
note_before = [];
note_eval = [];
opt_line_slope = 1;		% of slope 1
% ======================================================================

%% Plotting E' vs e_m m' + e_F F_0' (with m' first then F_0')

if ~exist('e_m_dry') || ~exist('e_F')
	wet = find(m > m_crit);
	mm_dry = mm;
	mm_dry(wet) = NaN;
	[e_m_dry,E0E0] = regrs(EE,mm_dry);
	e_F = regrs(E0E0,F0F0);
end

X = L*(xmonth(e_m_dry).*mm + xmonth(e_F).*F0F0);
Z = L*EE;
mystats(X)
mystats(Z)

xvals = [-100,100];	yvals = [-100,100];
name = 'param_E-dry';

plot_scatter_locs;
% ======================================================================


%% Plotting E' vs e_m m' + e_F F_0' (with m' first then F_0')

if ~exist('e_m') || ~exist('e_F')
	[e_m,E0E0] = regrs(EE,mm);
	e_F = regrs(E0E0,F0F0);
end

X = L*(xmonth(e_m).*mm + xmonth(e_F).*F0F0);
Z = L*EE;
mystats(X)
mystats(Z)

xvals = [-100,100];	yvals = [-100,100];
name = 'param_E';

plot_scatter_locs;
% ======================================================================


%% Should I do this with F_0' first even with F ??

clear opt_line_slope

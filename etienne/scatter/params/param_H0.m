% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m , locations.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% param_H0.m
%
%	parameterized vs unparameterized H0'
%
% ======================================================================


%% No annotations, but line guidance for all plots generated here.
note_before = [];
note_eval = [];
opt_line_slope = 1;		% of slope 1
% ======================================================================


%% get parameters
if ~exist('kappa') || ~exist('mu') || ~exist('H0H0')
	[kappa,mu,H0H0] = param_damp(HH,TT,mm); end
% ----------------------------------------------------------------------

% parameterized on x-axis, unparameterized on y-axis
X = -xmonth(mu).*mm;
Z = H0H0;
xvals = [-150,150];	yvals = [-150,150];
name = 'param_H0';

plot_scatter_locs;
% ======================================================================

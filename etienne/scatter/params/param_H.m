% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m , locations.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% param_H.m
%
%	parameterized vs unparameterized H'
%
% ======================================================================


%% No annotations, but line guidance for all plots generated here.
note_before = [];
note_eval = [];
opt_line_slope = 1;		% of slope 1
% ======================================================================


%% get parameters
if ~exist('kappa') || ~exist('mu')
	[kappa,mu] = param_damp(HH,TT,mm); end
% ----------------------------------------------------------------------

% parameterized on x-axis, unparameterized on y-axis
X = -xmonth(mu).*mm + xmonth(kappa).*TT;
Z = HH;
xvals = [-150,150];	yvals = [-150,150];
name = 'param_H';

plot_scatter_locs;
% ======================================================================

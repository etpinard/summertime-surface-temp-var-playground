% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m , locations.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% param_xim.m
%
%	parameterized vs unparameterized xim'
%
% ======================================================================


%% No annotations, but line guidance for all plots generated here.
note_before = [];
note_eval = [];
opt_line_slope = 1;		% of slope 1
% ======================================================================


%% get parameters
if ~exist('a') || ~exist('b')
  [a,xim0xim0] = regrs(ximxim,mm);
  [b,xim00xim00] = regrs(xim0xim0,PP); end
% ----------------------------------------------------------------------

% parameterized on x-axis, unparameterized on y-axis [in mm/day]
X = (xmonth(a).*mm + xmonth(b).*PP)*secinday;
Z = ximxim*secinday;
xvals = [-4,4];	yvals = [-4,4];
name = 'param_xim';

plot_scatter_locs;
% ======================================================================

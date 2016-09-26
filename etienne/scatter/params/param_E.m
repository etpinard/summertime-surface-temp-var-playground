% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m , locations.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% param_E.m
%
%	parameterized vs unparameterized E'
%
% ======================================================================


%% No annotations, but line guidance for all plots generated here.
note_before = [];
note_eval = [];
opt_line_slope = 1;		% of slope 1
% ======================================================================


%% get parameters
if ~exist('e_m') || ~exist('e_F')
  [e_m,e_F] = param_evapo(EE,mm,F0F0,mbar,Fbar); end
% ----------------------------------------------------------------------

% parameterized on x-axis, unparameterized on y-axis
X = L*(xmonth(e_m.*Fbar).*mm + xmonth(e_F.*mbar).*F0F0);
Z = L*EE;
xvals = [-100,100];	yvals = [-100,100];
name = 'param_E';

plot_scatter_locs;
% ======================================================================

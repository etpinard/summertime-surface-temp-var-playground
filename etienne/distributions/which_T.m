%%% Program that compares the distributions of the surface air
  % temperature (tas.cdf) and the surface skin temperature (ts.cdf).
	%
	%	Plotting is automated using plot_summeravg.m
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% First extract ts.cdf
if ~exist('Tsk');
  [Tsk,Tskbar,TskTsk,sig_Tsk] = getnewvar('ts',opt_anom_Var);
end
% ======================================================================

% Make "bias" plots with T, the surface air temperature
cvec = [-1:0.1:1]; 
bins = [-1:0.01:1]; yval = 10;
color_handle = @color_corr2;

Z = bias(Tskbar,Tbar);        % 1) bar
name = 'Tskbar-bias';
plot_summeravg

Z = bias(sig_Tsk,sig_T);      % 2) sig
name = 'sig_Tsk-bias';
plot_summeravg

% Smaller than I thought in most regions. Get quite large in India for
% example ...

Z = log10(abs(bias(sig_Tsk,sig_T)));      % 2b) sig_T log10
name = 'sig_Tsk-log10bias';
cvec = [-2:0.5:1]; 
bins = [-5:0.01:1]; yval = 2;
color_handle = []; plot_summeravg         % nice
% ======================================================================

%cvec = [0:0.25:3]; bins = [0:0.1:5]; yval = 1;
%cvec = [-10:2:30]; bins = [-10:0.5:40]; yval = 0.1;


%% Anything else ???

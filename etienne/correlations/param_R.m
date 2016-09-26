%%% Seeking to best parameterization for R. 
	% Also, investigating lagged correlations (possibly important 
	% in the tropical regions as is the case with E).
	% 
	% Uses corr_depind.m for computation.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%%% First the top layer 

% Selecting the dependent variable, var_dep
var_dep = 'R';		

% Selecting the set of possible independent variables, vars_ind
vars_ind = {'P','m','mP'};
vars_ind = {'E'};							% WOW this is interesting!
Nvar_ind = length(vars_ind);

%{
% Compute missing anomaly fields.
if ~exist('mPmP') || ~exist('sig_mP');
	disp(['Computing ... mPmP and sig_mP']);
	[junk1,mPmP,sig_mP] = anomaly(m.*P);			
	clear junk1
end
%}
% ======================================================================

%% Call corr_depind.m for computations
opt_corlag = 0;
corr_depind
% ======================================================================

%% Call corr_depind_plot.m for plotting
opt_monthly = 0;
cvec = [-1:0.1:1]; color_handle = @color_corr3;
bins = [-1:0.01:1]; yval = 3;
corr_depind_plot
% ======================================================================

break

%%% Then the bottom layer 

% Selecting the dependent variable, var_dep
var_dep = 'Rb';		

% Selecting the set of possible independent variables, vars_ind
vars_ind = {'P','mb','mbP'};
Nvar_ind = length(vars_ind);

% Compute missing anomaly fields.
if ~exist('mbPmbP') || ~exist('sig_mbP');
	disp(['Computing ... mbPmbP and sig_mbP']);
	[junk1,mbPmbP,sig_mbP] = anomaly(mb.*P);			
	clear junk1
end
% ======================================================================

%% Call corr_depind.m for computations
corr_depind
% ======================================================================

%% Call corr_depind_plot.m for plotting
opt_monthly = 0;
cvec = [-1:0.1:1]; color_handle = @color_corr2;
bins = [-1:0.01:1]; yval = 3;
corr_depind_plot
% ======================================================================

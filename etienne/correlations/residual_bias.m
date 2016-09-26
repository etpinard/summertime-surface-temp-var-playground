%%% Investigation whether the regression residuals (E_00', H_00' and
	% R_0') are instantaneously correlated with their original variables.
	%
	%	See regressions/ for more info on their regressions (i.e.
	%	projections) used.
	%
	%	I am not sure how to fully interpret these results ...
	% residual_bias.m seems to be a misnomer ...
	% 
	% Uses corr_depind.m for computation.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% Plotting options for all plots ...
opt_monthly = 0;
opt_corlag = 0;
% ======================================================================

%%% 1) E_00' 

% Transitional (dry) to wet soil regime threshold
m_crit = 20;		% in mm

	% first compute it		--- with m first then F_0' or vice-versa
if ~exist('E00E00') || ~exist('sig_E00')
	disp(['Computing ... E00E00 and sig_E00']);

		% remove time entries corresponding to the wet regime
%	wet = find(m > m_crit);
%	mm_dry = mm;
%	mm_dry(wet) = NaN;
%	EdryEdry = EE;
%	EdryEdry(wet) = NaN;
%	sig_Edry = anomaly_sig(EdryEdry);

		% with m first then F0
	[junk,E0E0] = regrs(EE,mm);

	%[junk,E0E0] = regrs(EdryEdry,mm_dry);
	%% Matlab plots correlations of > 1 ??? Why
	%% mystats() is bounded by +/- however

	[junk,E00E00] = regrs(E0E0,F0F0);

		% with F0 first then m		%% DOES NOT make a difference!!!
%	[junk,E0E0] = regrs(EE,F0F0);			% make sure to clear E00E00
%	[junk,E00E00] = regrs(E0E0,mm);		% before

	sig_E00 = anomaly_sig(E00E00);
end

var_dep = 'E';
%var_dep = 'Edry';
vars_ind = {'E00'};
corr_depind
corr_depind_plot
% ======================================================================

%%% 2) H_00' 

	% first compute it	
if ~exist('H00H00') || ~exist('sig_H00')
	disp(['Computing ... H00H00 and sig_H00']);

		% with T first then m  --- to make kappa realistic
	[junk,H0H0] = regrs(HH,TT);
	[junk,H00H00] = regrs(H0H0,mm);

	sig_H00 = anomaly_sig(H00H00);
end

var_dep = 'H';
vars_ind = {'H00'};
Nvar_ind = length(vars_ind);
corr_depind
corr_depind_plot
% ======================================================================

%%% 3) R_0' 

	% first compute it	
if ~exist('R0R0') || ~exist('sig_R0')
	disp(['Computing ... R0R0 and sig_R0']);

		% just one projection with P'
	[junk,R0R0] = regrs(RR,PP);
	sig_R0 = anomaly_sig(R0R0);
end

var_dep = 'R';
vars_ind = {'R0'};
Nvar_ind = length(vars_ind);
corr_depind
corr_depind_plot
% ======================================================================

% Some odd correlations ... 
var_dep = 'm';
vars_ind = {'F0'};
corr_depind; corr_depind_plot

var_dep = 'E00';
vars_ind = {'m','mb','P','T'};
corr_depind; corr_depind_plot

var_dep = 'H00';
vars_ind = {'T','F0','P'};
corr_depind; corr_depind_plot
% ======================================================================

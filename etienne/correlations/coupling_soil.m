%%% Investigating correlations between moisture in the top
	%	and the bottom soil layers. To what level are the two
	% soil layers coupled.
	%
	% Uses corr_lag.m for computation.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%%% Computing instantaneous correlations here!

if ~exist('cor_mmb') || ~exist('Cor_mmb');
	disp(['Computing ... cor_mmb']);
	[cor_mmb,Cor_mmb] = corr_inst(mm,mbmb,sig_m,sig_mb);
end

% Computing lagged correlations m leading
if ~exist('corlag_mmb') || ~exist('Corlag_mmb');
	disp(['Computing ... corlag_mmb']);
	[corlag_mmb,Corlag_mmb,pairs_m] = corr_lag(mm,mbmb,sig_m,sig_mb);
end

% Computing lagged correlations mb leading
if ~exist('corlag_mbm') || ~exist('Corlag_mbm');
	disp(['Computing ... corlag_mbm']);
	[corlag_mbm,Corlag_mbm] = corr_lag(mbmb,mm,sig_mb,sig_m);
end

% ======================================================================

%%% Call corr_depind_plot.m for plotting

var_dep = 'P'; 
vars_ind = {'mb'}; 
opt_corlag = 1;
opt_monthly = 0;
opt_overlay = 0;
corr_depind_plot
% ======================================================================

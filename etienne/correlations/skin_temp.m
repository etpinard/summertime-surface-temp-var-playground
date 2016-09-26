%%% 
%
% miscelleneous correlations involving Tskin.
%
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% options 
opt_corlag = 0;		
opt_monthly = 0;
opt_overlay = 0;		
% ----------------------------------------------------------------------

% extract skin temperature 
if ~exist('TskTsk')
	[Tsk,junk2,TskTsk,sig_Tsk] = getnewvar('ts',opt_anom_Var);
end
% ----------------------------------------------------------------------

% compute DT'
if ~exist('DTDT')
  DT = (Tsk-T);
  [junk1,DTDT,sig_DT] = anomaly(Tsk-T);
end
% ----------------------------------------------------------------------

var_dep = 'Tsk';
%var_dep = 'DT';
vars_ind = {'E','P','F','F0'};

corr_depind
corr_depind_plot
% ======================================================================

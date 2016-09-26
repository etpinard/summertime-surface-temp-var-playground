% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% compobs_corr_T.m
%
% --> plot_compobs_datasets.m <--
%
% Summertime auto-correlations of T.
%
% (10-18) Plots also with T' detrended!
%
% ======================================================================

% plot_4panels and plot_hist2.m required fields, for all plots!

% name_add = '';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;
%opt_overlay = 2;
units = '[-]';

%cvec = [-1:0.2:1]; 
opt_x_cvec = 'none';
cvec = [-0.4:0.1:0.4];  % for diff
opt_x_cvec = 'add_both';
color_handle = @color_corr;

% old
vars_req = {'lon','lat','Corlag_T'}; 
comp_cmd = [ ...
  '[j1,Corlag_T] = corr_autolag(TT,sqrt(Var_T),''sqz1'');' ...
];
obs_cmd = [ ...
  'get_obs_T;' ...
  '[j1,obs_Corlag_T] =' ...
  'corr_autolag(TobTob,sqrt(Var_Tob),''sqz1'');' ...
  ];

% new (with detrend stuff)
vars_req = {'lon','lat','Corlag_T','Corlag_T_detrend','diff_Corlag_T'}; 
comp_cmd = [ ...
  '[j1,Corlag_T] = corr_autolag(TT,sqrt(Var_T),''sqz1'');' ...
  'TT_dtr = dtrnd(TT);' ...
  'Var_T_dtr = anomaly_Var(TT_dtr);' ...
  '[j1,Corlag_T_detrend] = ' ...
    'corr_autolag(TT_dtr,sqrt(Var_T_dtr),''sqz1'');' ...
  'diff_Corlag_T = abs(Corlag_T)-abs(Corlag_T_detrend);';
];
obs_cmd = [ ...
  'get_obs_T;' ...
  '[j1,obs_Corlag_T] =' ...
  'corr_autolag(TobTob,sqrt(Var_Tob),''sqz1'');' ...
  'TobTob_dtr = dtrnd(TobTob);' ...
  'Var_Tob_dtr = anomaly_Var(TobTob_dtr);' ...
  '[j1,obs_Corlag_T_detrend] = ' ...
    'corr_autolag(TobTob_dtr,sqrt(Var_Tob_dtr),''sqz1'');' ...
  'obs_diff_Corlag_T = abs(obs_Corlag_T)-abs(obs_Corlag_T_detrend);';
  ];


% ----------------------------------------------------------------------

%% Call plot_compobs_datasets.m
plot_compobs_datasets;
% ----------------------------------------------------------------------

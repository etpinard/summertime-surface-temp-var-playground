% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% compobs_trends_T.m
%
% --> plot_compobs_datasets.m <--
%
% Evaluates the effects of secular trends in the data.
%
% ======================================================================

% plot_5panels 

% name_add = '';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;
%opt_overlay = 2;
units = '[-]';

cvec = [0,0.01,0.05,0.1,0.25,0.5,1];
opt_x_cvec = 'none';
color_handle = @color_small;

vars_req = {'lon','lat','trends_T'}; 
comp_cmd = [ ...
  'TT_dtr = dtrnd(TT);' ...
  'Var_T_dtr = anomaly_Var(TT_dtr);' ...
  'den = makenan(Var_T,''==0'');' ...
  'trends_T = (1 - sqmean(Var_T_dtr)./sqmean(den));' ...
];
obs_cmd = [ ...
  'get_obs_T;' ...
  'TobTob_dtr = dtrnd(TobTob);' ...
  'Var_Tob_dtr = anomaly_Var(TobTob_dtr);' ...
  'den = makenan(Var_Tob,''==0'');' ...
  'obs_trends_T = (1 - sqmean(Var_Tob_dtr)./sqmean(den));' ...
  ];
% ----------------------------------------------------------------------

%% Call plot_compobs_datasets.m
plot_compobs_datasets;
% ----------------------------------------------------------------------

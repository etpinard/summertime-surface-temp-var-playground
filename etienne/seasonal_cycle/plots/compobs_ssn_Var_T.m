% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% compobs_ssn_Var_T.m
%
% --> plot_compobs_datasets.m <--
%
% Seasonal cycle range of Var(T)
%
% ======================================================================


name_add = '';
out_format = 'png';
out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;
units = '[K^2]';

cvec = [-3:0.5:3]; 
opt_x_cvec = 'add_both';
color_handle = @color_corr;
bins = [-5:0.1:5];
yval = 1.5;

vars_req = {'lon','lat','ssn_VarT','ssn_VarT_13'};

comp_cmd = [ ...
  'ssn_VarT = ssn_rg(Var_T,''july'');' ...
  'ssn_VarT_13 = ssn_rg(Var_T);' ...
  ];

obs_cmd = [ ...
  'obs_T = getobs(''T'',Nlat,Nlon);' ...
  '[obs_Tbar,junk2,obs_Var_T] = anomaly(obs_T,opt_anom_Var);' ...
  'obs_ssn_VarT = ssn_rg(obs_Var_T,''july'');' ...
  'obs_ssn_VarT_13 = ssn_rg(obs_Var_T);' ...
  ];
% ----------------------------------------------------------------------

%% Call plot_compobs_datasets.m
plot_compobs_datasets;
% ----------------------------------------------------------------------

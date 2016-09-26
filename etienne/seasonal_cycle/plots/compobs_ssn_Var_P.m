% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% compobs_ssn_Var_P.m
%
% --> plot_compobs_datasets.m <--
%
% Seasonal cycle range of Var(P)
%
% ======================================================================


name_add = '';
out_format = 'png';
%out_format = 'eps';
opt_frame_col = 1;
opt_overlay = 0;
units = '(mm/day)^2';

cvec = [-5:1:5]; 
opt_x_cvec = 'add_both';
color_handle = @color_myjet;
bins = [-10:0.2:10];
yval = 1.5;

vars_req = {'lon','lat','ssn_VarP_12','ssn_VarP_13'};

comp_cmd = [ ...
  'ssn_VarP_12 = ssn_rg(Var_P)*secinday^2;' ...
  'ssn_VarP_13 = ssn_rg(Var_P,''july'')*secinday^2;' ...
  ];

obs_cmd = [ ...
  'obs_P = getobs(''P'',Nlat,Nlon);' ...
  '[obs_Pbar,junk2,obs_Var_P] = anomaly(obs_P,opt_anom_Var);' ...
  'obs_ssn_VarP_12 = ssn_rg(obs_Var_P)*secinday^2;' ...
  'obs_ssn_VarP_13 = ssn_rg(obs_Var_P,''july'')*secinday^2;' ...
  ];
% ----------------------------------------------------------------------

%% Call plot_compobs_datasets.m
plot_compobs_datasets;
% ----------------------------------------------------------------------

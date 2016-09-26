% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_ssn_Var_F.m
%
% --> plot_comp_datasets.m <--
%
% Seasonal cycle range of surface energy forcing.
%
% ======================================================================


%name_add = '';
out_format = 'png';
%out_format = 'eps';
opt_frame_col = 1;
opt_overlay = 0;
units = '(Wm-2)';
%units = '(Wm-2)^2';

cvec = [-25:2.5:25]; 
opt_x_cvec = 'add_both';
color_handle = @color_myjet;
bins = [-40:0.2:40];
yval = 0.2;

vars_req = {'lon','lat','ssn_VarF_12','ssn_VarF_13' ...
                        'ssn_VarF0_12','ssn_VarF0_13'};

comp_cmd = [ ...
  'ssn_VarF_12 = ssn_rg(sqrt(Var_F));' ...
  'ssn_VarF_13 = ssn_rg(sqrt(Var_F),''july'');' ...
  'ssn_VarF0_12 = ssn_rg(sqrt(Var_F0));' ...
  'ssn_VarF0_13 = ssn_rg(sqrt(Var_F0),''july'');' ...
  ];

%comp_cmd = [ ...
%  'ssn_VarF_12 = ssn_rg(Var_F);' ...
%  'ssn_VarF_13 = ssn_rg(Var_F,''july'');' ...
%  'ssn_VarF0_12 = ssn_rg(Var_F0);' ...
%  'ssn_VarF0_13 = ssn_rg(Var_F0,''july'');' ...
%  ];
% ----------------------------------------------------------------------

%% Call plot_compobs_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------

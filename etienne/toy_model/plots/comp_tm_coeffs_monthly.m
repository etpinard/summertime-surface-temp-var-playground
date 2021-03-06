% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_tm_coeffs_monthly.m
%
% --> plot_comp_datasets.m <--
%
% --> plot_compsc_datasets.m <--
%
%
% Month-to-month version of comp_tm_coeffs.
%
% ======================================================================

%name_add = 'tm';
out_format = 'png';
%out_format = 'eps';
opt_overlay = 0;

comp_cmd = [ ...
  'beta = [];' ...
  'gamma = [];' ...
  'tm_param_full;' ...
  'beta_1=sqz(beta(1,:,:));' ...
  'beta_2=sqz(beta(2,:,:));' ...
  'beta_3=sqz(beta(3,:,:));' ...
  'lambda_1=sqz(lambda(1,:,:));' ...
  'lambda_2=sqz(lambda(2,:,:));' ...
  'lambda_3=sqz(lambda(3,:,:));' ...
  'chi_1=sqz(chi(1,:,:));' ...
  'chi_2=sqz(chi(2,:,:));' ...
  'chi_3=sqz(chi(3,:,:));' ...
  'gamma_1=sqz(gamma(1,:,:));' ...
  'gamma_2=sqz(gamma(2,:,:));' ...
  'gamma_3=sqz(gamma(3,:,:));' ...
  'alpha_1=sqz(alpha(1,:,:));' ...
  'alpha_2=sqz(alpha(2,:,:));' ...
  'alpha_3=sqz(alpha(3,:,:));' ...
  ];

case_cmd = [ ...
  'case {1,2,3};' ...
  'cvec=[-0.1:0.1:0.8]; opt_x_cvec=''add_both''; units=''[-]'';' ...
  'bins=[-0.5:0.01:2]; yval = 3; color_handle=[];'...
  'case {4,5,6};' ...
  'cvec=[0:0.1:0.6]; opt_x_cvec=''add_both''; units=''[-]'';' ...
  'bins=[-0.5:0.01:1.5]; yval = 5; color_handle=[];' ...
  'case {7,8,9};' ...
  'cvec=[-0.75:0.25:0.75]; opt_x_cvec=''add_both''; units=''[-]'';' ...
  'bins=[-5:0.01:5]; yval = 5; color_handle=@color_posneg;' ...
  'case {10,11,12};' ...
  'cvec=[0:4:24]; opt_x_cvec=''add_both''; units=''W m-2 K-1'';' ...
  'bins=[-10:0.5:60]; yval = 0.3; color_handle=[];' ...
  'case {13,14,15};' ...
  'cvec=[-0.4:0.2:1.4]; opt_x_cvec=''add_both''; units=''[-]'';' ...
  'bins=[-2:0.01:2]; yval = 4; color_handle=[];' ...
  ];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
opt_frame_col = 1;
vars_req = {'lon','lat', ...
            'beta_1','beta_2','beta_3', ...
            'lambda_1','lambda_2','lambda_3', ...
            'chi_1','chi_2','chi_3', ...
            'gamma_1','gamma_2','gamma_3', ...
            'alpha_1','alpha_2','alpha_3'};

plot_comp_datasets;
% ----------------------------------------------------------------------

break

%% Call plot_compsc_datasets.m
opt_frame_col = 0;
vars_req = {'mbar','Tbar', ...
            'beta_1','beta_2','beta_3', ...
            'lambda_1','lambda_2','lambda_3', ...
            'chi_1','chi_2','chi_3', ...
            'gamma_1','gamma_2','gamma_3', ...
            'alpha_1','alpha_2','alpha_3'};

plot_compsc_datasets;
% ----------------------------------------------------------------------


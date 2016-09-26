% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_tm_Var_m_bias.m
%
% --> plot_comp_datasets.m <--
%
% Toy model relative error on Var(m) with respect to dataset 
% output Var(m).
%
% (07/03): now plotting the ratio of tm_Var(m) to Var(m)
%
% ======================================================================

clear name_add
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;
units = '[-]';

cvec = [0.0,0.25,0.5,0.8,0.9,1,1.1,1.25,2,4];   
opt_x_cvec = 'above';
color_handle = @color_relerror;
bins = [0,5];
yval = 2.5;

%vars_req = {'lon','lat', ...
%            'tm_Var_m_bias', ...
%            'tm_Var_m_bias_1', ...
%            'tm_Var_m_bias_2', ...
%            'tm_Var_m_bias_3'};
%comp_cmd = [ ...
%  'tm_param_full;' ...
%  'tm_Var_m_bias = sqmean(tm_Var_m./Var_m);' ...
%  'tm_Var_m_bias_1 = sqz(tm_Var_m(1,:,:))./sqz(Var_m(1,:,:));' ...
%  'tm_Var_m_bias_2 = sqz(tm_Var_m(2,:,:))./sqz(Var_m(2,:,:));' ...
%  'tm_Var_m_bias_3 = sqz(tm_Var_m(3,:,:))./sqz(Var_m(3,:,:));' ...
%  ];

vars_req = {'lon','lat','tm_Var_m_bias'};
comp_cmd = [ ...
  'tm_param_full;' ...
  'tm_Var_m_bias = sqmean(tm_Var_m./Var_m);' ...
  ];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------

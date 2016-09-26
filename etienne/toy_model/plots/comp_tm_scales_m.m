% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_tm_scales_m.m
%
% --> plot_comp_datasets.m <--
%
% Cross-datasets comparison of toy model scalings in the soil moisture 
% budget.
%
% ======================================================================

%name_add = 'alt';
clear name_add
out_format = 'both';
opt_overlay = 0;
opt_frame_col = 0;

comp_cmd = [ ...
'beta = [];' ...  % variables, not functions
'gamma = [];' ...
'alpha = [];' ...
'tm_param_full;' ...
'fact_P_m = 1+alpha.*lambda-beta;' ...
'fact_F0_m = lambda/L;' ...
'scale_F0_P_m = fact_F0_m.^2.*Var_F0./(fact_P_m.^2.*Var_P);' ...
];

case_cmd = [ ...
'case {1};' ...
  'cvec=[0,0.1,0.25,0.5,0.8,1,1.25,2,4,10]; opt_x_cvec=''above'';' ... 
  'units=''[-]''; color_handle = @color_scale;' ...
];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
vars_req = {'lon','lat', ...
            'scale_F0_P_m'};

plot_comp_datasets;
% ----------------------------------------------------------------------

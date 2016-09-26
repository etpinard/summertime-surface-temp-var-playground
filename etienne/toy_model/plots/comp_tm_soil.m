% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_tm_soil.m
%
% --> plot_comp_datasets.m <--
%
%
% Cross-datasets comparisons of soil moisture rate nu_s
%
% ======================================================================

%name_add = 'tm';
clear name_add
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;
color_handle = @color_coeffs;

comp_cmd = [ ...
  'tm_param_full;' ...
  'nu_E = nu_E*secinday;' ...
  'nu_I = nu_I*secinday;' ...
  'nu_s = nu_s*secinday;' ...
  ];

case_cmd = [ ...
  'case {1,2,3};' ...
  'cvec=[0:0.2:0.8]; opt_x_cvec=''add_both''; units=''[day-1]'';' ...
  ];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
vars_req = {'lon','lat', ...
            'nu_E','nu_I','nu_s'};

%plot_comp_datasets;
% ----------------------------------------------------------------------

%% Call plot_compsc_datasets.m, with (mbar,Tbar) as coordinates.
vars_req = {'mbar','Tbar', ...
            'nu_E','nu_I','nu_s'};

%plot_compsc_datasets;
% ----------------------------------------------------------------------

%% Call plot_compsc_datasets.m, with (Pbar,Fbar) as coordinates.
name_add = 'PF';
vars_req = {'Pbar','Fbar', ...
            'nu_E','nu_I','nu_s'};

%plot_compsc_datasets;
% ----------------------------------------------------------------------

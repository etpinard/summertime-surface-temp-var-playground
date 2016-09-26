% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_tm_rms_bias.m
%
% --> plot_comp_datasets.m <--
%
% Toy model T' Root-Mean-Square error w.r.t. output T'.
%
% ... and for m'.
%
% ======================================================================

%name_add = '';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;

opt_x_cvec = 'above';
color_handle = @color_Var;

opt_tilde = 1;
vars_req = {'lon','lat', ...
            'tm_rms_T_bias','tm_rms_T_bias_tilde', ...
            'tm_rms_m_bias'};

comp_cmd = [ ...
  'tm_param_full;' ...
  'tm_rms_T_bias = rms(tm_TT,TT);' ...
  'tm_rms_T_bias_tilde = rms(tm_TT_tilde,TT);' ...
  'tm_rms_m_bias = rms(tm_mm,mm);' ...
  ];

case_cmd = [ ...
  'case {1,2};' ...
  'cvec=[0:0.2:1.4]; units=''[K]'';' ...
  'case 3;' ...
  'cvec=[0:0.4:2.8]; units=''[mm]'';' ...
 ];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------

% Pre-(06/17) stuff
%{

vars_req = {'lon','lat', ...
            'VarT_bias_may14','VarT_bias_may16'};
comp_cmd = [ ...
  'tm_param;' ...
  'tm_may14; VarT_bias_may14 = sqmean(bias(tm_Var_T,Var_T));' ...
  'tm_may16; VarT_bias_may16 = sqmean(bias(tm_Var_T,Var_T));' ...
  ];

% just compute tm_Var_T in the tm_$date calls
opt_plot = 0;

% and note that both `tm_may14' and `tm_may16' have the required
% 'clear' statements for looping through the data sets.

%}

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_tm_Var_T_bias.m
%
% --> plot_comp_datasets.m <--
%
% Toy model relative error on Var(T) with respect to dataset 
% output Var(T).
%
% (07/03): now plotting the ratio of tm_Var(T) to Var(T)
%
% ======================================================================

%%% output alternative formulation, or not
opt_tilde = 0;
% ----------------------------------------------------------------------

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

%if ~opt_tilde
%vars_req = {'lon','lat', ...
%            'tm_Var_T_bias', ...
%            'tm_Var_T_bias_1', ...
%            'tm_Var_T_bias_2', ...
%            'tm_Var_T_bias_3'};
%comp_cmd = [ ...
%  'tm_param_full;' ...
%  'tm_Var_T_bias = sqmean(tm_Var_T./Var_T);' ...
%  'tm_Var_T_bias_1 = sqz(tm_Var_T(1,:,:))./sqz(Var_T(1,:,:));' ...
%  'tm_Var_T_bias_2 = sqz(tm_Var_T(2,:,:))./sqz(Var_T(2,:,:));' ...
%  'tm_Var_T_bias_3 = sqz(tm_Var_T(3,:,:))./sqz(Var_T(3,:,:));' ...
%  ];
%else
%vars_req = {'lon','lat', ...
%            'tm_Var_T_bias', ...
%            'tm_Var_T_bias_tilde'};
%comp_cmd = [ ...
%  'tm_param_full;' ...
%  'tm_Var_T_bias = sqmean(tm_Var_T./Var_T);' ...
%  'tm_Var_T_bias_tilde = sqmean(tm_Var_T_tilde./Var_T);' ...
%  ];
%end

vars_req = {'lon','lat', 'tm_Var_T_bias'};
comp_cmd = [ ...
 'tm_param_full;' ...
 'tm_Var_T_bias = sqmean(tm_Var_T./Var_T);'
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

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_scale_Var_LE_Hs.m
%
% --> plot_comp_datasets.m <--
%
% Scales the compensation between E' and Hs' (over drylands).
% 
% We plot the ratio ( Var(LE)+Var(Hs) ) / Var(LE+Hs)
%
% ======================================================================

clear name_add
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 2;

cvec = [0.0,0.1,0.25,0.5,0.8,1,1.25,2,4,10];   
opt_x_cvec = 'above';
color_handle = @color_scale;
units = '[-]';

vars_req = {'lon','lat','scale_Var_LE_Hs'};

comp_cmd = [ ...
  'Var_E = sig_E.^2;' ...
  'Var_Hs = sig_Hs.^2;' ...
  'Var_LE_Hs = anomaly_Var(L*EE+HsHs);' ...
  'scale_Var_LE_Hs = (L^2*Var_E+Var_Hs)./Var_LE_Hs;' ...
];

clear case_cmd
%case_cmd = [ ...
%];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------

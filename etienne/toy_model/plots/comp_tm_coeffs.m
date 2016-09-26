% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_tm_coeffs.m
%
% --> plot_comp_datasets.m <--
% --> plot_compsc_datasets.m <--
%
%
% Cross-datasets comparison of selected toy model coefficients. 
%
% Outputs summer average contour maps, color-coded scatter plots
% with respect to (mbar,Tbar) and (Pbar,Fbar).
%
% For side-by-side scatter and miller map, see `plot_tm_coeffs.m'
%
% ======================================================================

%%% output alternative coeffs, or not
opt_tilde = 1;
% ----------------------------------------------------------------------

%name_add = 'tm';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;
color_handle = @color_coeffs;

comp_cmd = [ ...
  'alpha = [];' ...
  'tm_param_full;' ...
  ];

case_cmd = [ ...
  'case {1,5};' ...
  'cvec=[0:5:25]; opt_x_cvec=''above''; units=''[Wm-2K-1]'';' ...
  'case {2,7};' ...
  'cvec=[0:0.2:0.8]; opt_x_cvec=''above''; units=''[-]'';' ...
  'case {3,6};' ...
  'cvec=[-0.8:0.2:0.8]; opt_x_cvec=''add_both''; units=''[-]'';' ...
  'case 4;' ...
  'cvec=[0:0.2:0.8]; opt_x_cvec=''add_both''; units=''[-]'';' ...
  ];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
if ~opt_tilde
  vars_req = {'lon','lat', ...
              'gamma','lambda','chi','beta'};
else
  vars_req = {'lon','lat', ...
              'gamma','lambda','chi','beta', ...
              'gamma_tilde','chi_tilde','eta'};
end

%plot_comp_datasets;
% ----------------------------------------------------------------------

%break

%% Call plot_compsc_datasets.m, with (mbar,Tbar) as coordinates.
if ~opt_tilde
  vars_req = {'mbar','Tbar', ...
              'gamma','lambda','chi','beta'};
else
  vars_req = {'mbar','Tbar', ...
              'gamma','lambda','chi','beta', ...
              'gamma_tilde','chi_tilde','eta'};
end

%plot_compsc_datasets;
% ----------------------------------------------------------------------

%break

%% Call plot_compsc_datasets.m, with (Pbar,Fbar) as coordinates.
name_add = 'PF';
if ~opt_tilde
  vars_req = {'Pbar','Fbar', ...
              'gamma','lambda','chi','beta'};
else
  vars_req = {'Pbar','Fbar', ...
              'gamma','lambda','chi','beta', ...
              'gamma_tilde','chi_tilde','eta'};
end

plot_compsc_datasets;
% ----------------------------------------------------------------------


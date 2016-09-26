% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_ssn_mbar.m
%
% --> plot_comp_datasets.m <--
%
% Seasonal cycle range of monthly mean soil moisture content. 
%
% Outputs include both 'raw' range and normalized range
% ======================================================================

%name_add = '';
out_format = 'png';
out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;

opt_x_cvec = 'add_both';
color_handle = @color_corr;
% ----------------------------------------------------------------------

%% 1) Raw range, call plot_comp_datasets.m
units = '[mm]';
cvec = [-10:2:10]; 
bins = [-20:0.5:20];
yval = 1;
vars_req = {'lon','lat', ...
            'ssn_mbar_12','ssn_mbar_13'};
comp_cmd = [ ...
  'ssn_mbar_12 = ssn_rg(mbar,''july'');' ...
  'ssn_mbar_13 = ssn_rg(mbar);' ...
  ];
%plot_comp_datasets;
% ----------------------------------------------------------------------

%% 2) Normalized range, call plot_comp_datasets.m
units = '[-]';
cvec = [-0.5:0.1:0.5]; 
bins = [-1.5:0.01:1.5];
yval = 10;
vars_req = {'lon','lat', ...
            'ssn_nrm_mbar','ssn_nrm_mbar_13'};
comp_cmd = [ ...
  'ssn_nrm_mbar = ssn_rg(mbar,''july'',''norm'');' ...
  'ssn_nrm_mbar_13 = ssn_rg(mbar,'''',''norm'');' ...
  ];
plot_comp_datasets;
% ----------------------------------------------------------------------

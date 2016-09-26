% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_trends.m
%
% --> plot_comp_datasets.m <--
%
% Evaluates the effects of secular trends in the data.
%
% ======================================================================

% plot_4panels 

% name_add = '';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;
%opt_overlay = 2;
units = '[-]';

cvec = [0,0.01,0.05,0.1,0.25,0.5,1];
opt_x_cvec = 'none';
color_handle = @color_small;

vars_req = {'lon','lat', ... 
  'trends_m','trends_F'}; 
comp_cmd = [ ...
  'mm_dtr = dtrnd(mm);' ...
  'Var_m_dtr = anomaly_Var(mm_dtr);' ...
  'den = makenan(sig_m.^2,''==0'');' ...
  'trends_m = (1 - sqmean(Var_m_dtr)./sqmean(den));' ...
  'FF_dtr = dtrnd(FF);' ...
  'Var_F_dtr = anomaly_Var(FF_dtr);' ...
  'den = makenan(sig_F.^2,''==0'');' ...
  'trends_F = (1 - sqmean(Var_F_dtr)./sqmean(den));' ...
];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------

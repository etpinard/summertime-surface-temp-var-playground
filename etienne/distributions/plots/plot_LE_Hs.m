% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_LE_Hs.m
%
% plot_3panels.m. 
%
% ======================================================================

% plot_3panels required fields

name = 'LE_Hs';
models_plot = [];
out_format = 'png';
cvec = [0:5:30];
opt_x_cvec = 'above';
color_handle = [];
opt_overlay = 0;
annotate_text = {'LE','Hs','LE+Hs'};
opt_frame_col = 1;
bins = [-0.1,35];
yval = 0.3;

% names of variables to be plotted
vars_plot = {'LSig_E','Sig_Hs','Sig_LE_Hs'};
% ----------------------------------------------------------------------

% compute function to be plotted
[junk1,junk1,tmp] = anomaly(L*E+Hs);
Sig_LE_Hs = sqmean(tmp);

LSig_E = sqmean(L*sig_E);
Sig_Hs = sqmean(sig_Hs);
% ----------------------------------------------------------------------

% Call plot_3panels.m or plot_4panels.m
plot_3panels;
plot_hist2(addsheet(LSig_E,Sig_Hs,Sig_LE_Hs), ...
            bins,[],[model_name,'_',name],yval,out_format);
% ======================================================================

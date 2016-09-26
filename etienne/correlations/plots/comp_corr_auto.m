% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_corr_auto.m
%
% --> plot_comp_datasets.m <--
%
% Summertime auto-correlations in the land-surface system.
%
% ======================================================================

% plot_4panels and plot_hist2.m required fields, for all plots!

% name_add = '';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;
%opt_overlay = 2;
units = '[-]';

%cvec = [-1:0.2:-0.4,0,0.4:0.2:1]; 
cvec = [-1:0.2:1];
opt_x_cvec = 'none';
color_handle = @color_corr;
%bins = [-1,1];
%yval = 4;

opt_corlag = 0;

%vars_req = {'lon','lat', ...
%            'Corlag_T','Corlag_m','Corlag_F','Corlag_P'}; ...
%comp_cmd = [ ...
%  '[j1,Corlag_T] = corr_autolag(TT,sig_T,''sqz1'');' ...
%  '[j1,Corlag_m] = corr_autolag(mm,sig_m,''sqz1'');' ...
%  '[j1,Corlag_F] = corr_autolag(FF,sig_F,''sqz1'');' ...
%  '[j1,Corlag_P] = corr_autolag(PP,sig_P,''sqz1'');' ...
%];
%
%vars_req = {'lon','lat', ...
%            'Corlag_xim'}; ...
%comp_cmd = [ ...
%  '[j1,Corlag_xim] = corr_autolag(ximxim,sig_xim,''sqz1'');' ...
%];

vars_req = {'lon','lat', ...
            'Corlag_F','Corlag_P'}; ...
comp_cmd = [ ...
  '[j1,Corlag_F] = corr_autolag(FF,sig_F,''sqz1'');' ...
  '[j1,Corlag_P] = corr_autolag(PP,sig_P,''sqz1'');' ...
];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------

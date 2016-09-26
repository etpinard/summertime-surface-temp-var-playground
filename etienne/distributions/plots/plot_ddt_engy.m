% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_ddt_engy.m
%
%
% ======================================================================

% plot_3panels required fields

name = 'ddt_engy';
out_format = 'png';
cvec = [0:0.2:1.5];
units = '[-]';
opt_x_cvec = 'above';
color_handle = [];
opt_overlay = 0;
%annotate_text = {'CpT)','snow)','frozen)'};
annotate_text = {'a)','b)','c)'};
opt_frame_col = 1;
bins = [-0.1,1.5];
yval = 100;

% names of variables to be plotted
models_plot = {};
vars_plot = {'scale_CpT','scale_snow','scale_frozen'};
% ----------------------------------------------------------------------

% choose C_p of whole troposphere
C_p = 1e6;
C_p = 1e5;  % which one?

% L_m, latent heat of melting
L_m = 3e5;
% ----------------------------------------------------------------------

% get data
if ~exist('snwsnw') 
  [junk1,junk2,snwsnw] = getnewvar('snw',opt_anom_Var); end

if ~exist('mrfsomrfso') 
  [junk1,junk2,mrfsomrfso] = getnewvar('mrfso',opt_anom_Var); end

% normalization
den = sqrt(sqmean(sig_xiU.^2));

% sfc energy tendency
tmp = ddt(C_p*TT);
scale_CpT = sqrt(sqmean(tmp.*tmp))./den;

% snow (just June to July)
tmp = ddt(L_m*snwsnw);
tmp = sqz(tmp(1,:,:));
scale_snow = sqrt(tmp.*tmp)./den;

% frozen water  (recall mrfso is for the full column)
%frozen = (10/300)*mrfso;     % hadgem has 3m column
%frozen = (10/500)*mrfso;     % ccsm has 5m column
tmp = ddt(L_m*mrfsomrfso);
tmp = sqz(tmp(1,:,:));
scale_frozen = sqrt(tmp.*tmp)./den;
% ----------------------------------------------------------------------

% Call plot_3panels.m
plot_3panels;
plot_hist2(addsheet(scale_CpT,scale_snow,scale_frozen), ...
            bins,[],name,yval);
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_ddt_mois.m
%
% ======================================================================

% plot_3panels required fields

name = 'ddt_mois';
out_format = 'png';
cvec = [0:0.25:2];
opt_x_cvec = 'above';
color_handle = [];
opt_overlay = 0;
%annotate_text = {'CpT)','m)','frozen)'};
annotate_text = {'a)','b)','c)'};
opt_frame_col = 1;
bins = [-0.1,2];
yval = 80;

% names of variables to be plotted
vars_plot = {'scale_m','scale_snow','scale_frozen'};
% ----------------------------------------------------------------------

% get data
if ~exist('snwsnw') 
  [junk1,junk2,snwsnw] = getnewvar('snw',opt_anom_Var); end

if ~exist('mrfsomrfso') 
  [junk1,junk2,mrfsomrfso] = getnewvar('mrfso',opt_anom_Var); end

% normalization
den =  sqrt(sqmean(sig_xim.^2));

% soil mois tendendy
tmp = ddt(mm);
scale_m = sqrt(sqmean(tmp.*tmp))./den;

% snow (just June to July)
tmp = ddt(snwsnw);
tmp = sqz(tmp(1,:,:));
scale_snow = sqrt(tmp.*tmp)./den;

% frozen water  (recall mrfso is for the full column)
%frozen = (10/300)*mrfso;     % hadgem has 3m column
%frozen = (10/500)*mrfso;     % ccsm has 5m column
tmp = ddt(mrfsomrfso);
tmp = sqz(tmp(1,:,:));
scale_frozen = sqrt(tmp.*tmp)./den;
% ----------------------------------------------------------------------

% Call plot_3panels.m
plot_3panels;
plot_hist2(addsheet(scale_m,scale_snow,scale_frozen), ...
            bins,[],name,yval);
% ======================================================================

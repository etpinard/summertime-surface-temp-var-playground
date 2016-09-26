% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_scale_engy.m
%
% plot_3panels.m with 
%
% Now correlations with F
%
% ======================================================================

% plot_3panels required fields

name = 'engy_corr';
out_format = 'png';
cvec = [-1:0.1:1];
opt_x_cvec = [];
color_handle = @color_corr4;
opt_overlay = 0;
%annotate_text = {'\kappaT/F)','LE/F)','H0/F)'};
annotate_text = {'a)','b)','c)'};
opt_frame_col = 1;
bins = [-1,1];

% names of variables to be plotted
vars_plot = {'Cor_FT','Cor_FE','Cor_FH0'};
%vars_plot = {'Cor_FT','Cor_FE','Cor_FHs'};
% ----------------------------------------------------------------------

% first get param residuals
if ~all(ismember({'kappa_H','sig_H0'},who))
  [kappa_H,junk2,H0H0] = param_damp(HH,TT,mm); 
  sig_H0 = anomaly_sig(H0H0); end

if ~exist('HsHs')
  [junk1,junk2,HsHs,sig_Hs] = getnewvar('hfss',opt_anom_Var); end

%% Call corr_depind.m for computations (instantaneous and summer-avg.)
var_dep = 'F';
vars_ind = {'T','E','H0'};
%vars_ind = {'T','E','Hs'};
opt_corlag = 0; 
corr_depind;      % use Cor_* , the summer-avg correlations.
% ----------------------------------------------------------------------

% Call plot_3panels.m
plot_3panels;
plot_hist2(addsheet(Cor_FT,Cor_FE,Cor_FH0),bins,[],name,[]);
%plot_hist2(addsheet(Cor_FT,Cor_FE,Cor_FHs),bins,[],name,[]);
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_scale_engy.m
%
% plot_3panels.m with { sig_(kappaT) , sig_(LE) , sig_(H0) } /sig_F , 
%
% Consistent with 04-w2 notation, kappa = kappa_H + kappa_xiU.
%
% Now correlations with H0
%
% ======================================================================

% plot_3panels required fields

name = 'H0_corr';
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
vars_plot = {'Cor_H0E','Cor_H0m','Cor_H0P'};
vars_plot = {'Cor_HsE','Cor_Hsm','Cor_HsP'};
% ----------------------------------------------------------------------

% first get param residuals
if ~all(ismember({'kappa_H','sig_H0'},who))
  [kappa_H,junk2,H0H0] = param_damp(HH,TT,mm); 
  sig_H0 = anomaly_sig(H0H0); end

if ~exist('HsHs')
  [junk1,junk2,HsHs,sig_Hs] = getnewvar('hfss',opt_anom_Var); end

%% Call corr_depind.m for computations (instantaneous and summer-avg.)
var_dep = 'H0';
var_dep = 'Hs';
vars_ind = {'E','m','P'};
opt_corlag = 0; 
corr_depind;      % use Cor_* , the summer-avg correlations.
% ----------------------------------------------------------------------

% Call plot_3panels.m
plot_3panels;
plot_hist2(addsheet(Cor_H0E,Cor_H0m,Cor_H0P),bins,[],name,[]);
%plot_hist2(addsheet(Cor_HsE,Cor_Hsm,Cor_HsP),bins,[],name,[]);
% ======================================================================

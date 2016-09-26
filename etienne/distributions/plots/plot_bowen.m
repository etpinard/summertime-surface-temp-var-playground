% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_bowen.m
%
% plot_3panels.m with { LEbar/Hsbar , bowen anomalies, sig_Hs/Lsig_E }
%
% Recall Bowen = SH/LH.
%
% ======================================================================

% plot_3panels required fields

name = 'bowen';
out_format = 'png';
cvec = [0:0.25:3.5];
opt_x_cvec = 'above';
color_handle = [];
opt_overlay = 0;
annotate_text = {'mean)','anom)','H0 bias)'};
%annotate_text = {'mean)','anom)','Var ratio)'};
annotate_text = {'a)','b)','c)'};
opt_frame_col = 1;
bins = [-0.1,3.5];

% names of variables to be plotted
%vars_plot = {'bowen_bar','bowen_anom','H0_bias'};
vars_plot = {'bowen_bar','bowen_anom','Var_ratio'};
% ----------------------------------------------------------------------

% get data
if ~exist('Hs')
  [Hs,Hsbar,HsHs,sig_Hs] = getnewvar('hfss',opt_anom_Var); end

if ~exist('H0H0')
  [junk1,junk2,H0H0] = param_damp(HH,TT,mm); 
  sig_H0 = anomaly_sig(H0H0); end

bowen = Hs./(L*E);
[tmp1,junk1,tmp2] = anomaly(bowen);

% bowen_bar
bowen_bar = sqmean(abs(tmp1));
%bowen_bar = sqmean(abs(Hsbar./(L*Ebar)));
bowen_bar = makenan(bowen_bar,'==Inf');

% bowen_anom
bowen_anom = sqmean(tmp2);
%bowen_anom = sqrt(sqmean(sig_Hs.^2./(L^2*sig_E.^2)));
bowen_anom = makenan(bowen_anom,'==Inf');

% Var ratio
Var_ratio = sqrt(sqmean(sig_Hs.^2./(L^2*sig_E.^2)));

% bias
%H0_bias = sqrt(sqmean((H0H0-HsHs).^2));
H0_bias = sqrt(sqmean(sig_H0.^2./(L^2*sig_E.^2)));
% ----------------------------------------------------------------------

% Call plot_3panels.m
plot_3panels;
plot_hist2(addsheet(bowen_bar,bowen_anom,Var_ratio), ...
            bins,[],name,[]);
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% corr_E_FPF0.m
%
% plot_3pnels.m with { corr(E',F') corr(E,P') corr(E,F_0') } 
%                     
%
% ======================================================================

% plot_3panels and plot_hist2.m required fields

name = 'E_F-P-F0';
out_format = 'png';
cvec = [-1:0.1:1];
opt_x_cvec = [];
color_handle = @color_corr4;
opt_overlay = 0;
annotate_text = {'a)','b)','c)'};
opt_frame_col = 1;
bins = [-1,1];

% names of variables to be plotted
vars_plot = {'Cor_EF','Cor_EP','Cor_EF0'};
% ----------------------------------------------------------------------

%% Call corr_depind.m for computations (instantaneous and summer-avg.)
var_dep = 'E';
vars_ind = {'F','P','F0'};
opt_corlag = 0; 
corr_depind;      % use Cor_* , the summer-avg correlations.
% ----------------------------------------------------------------------

% Call plot_3panels.m and plot_hist2.m
plot_3panels;
plot_hist2(addsheet(Cor_EF,Cor_EP,Cor_EF0), ...
            bins,[],name,[]);
% ======================================================================

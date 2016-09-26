% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% corr_E_F0_swlw.m
%
% plot_3pnels.m with { corr(E',F0') corr(E,F_sw0') corr(E,F_lw0') } 
%                     
%
% ======================================================================

% plot_3panels and plot_hist2.m required fields

name = 'E_F0_swlw';
out_format = 'png';
cvec = [-1:0.1:1];
opt_x_cvec = [];
color_handle = @color_corr4;
opt_overlay = 0;
annotate_text = {'E-F0)','E-Fsnet0)','E-Fld0)'};
annotate_text = {'a)','b)','c)'};
opt_frame_col = 1;
bins = [-1,1];

% names of variables to be plotted
vars_plot = {'Cor_EF0','Cor_EFsnet0','Cor_EFld0'};
% ----------------------------------------------------------------------

% get data
if ~exist('Fsnet')
  Fsd = getnewvar('rsds',opt_anom_Var); 
  Fsu = getnewvar('rsus',opt_anom_Var); 
  Fsnet = Fsd-Fsu;
  [junk,FsnetFsnet,sig_Fsnet] = anomaly(Fsnet);
  end

if ~exist('FldFld')
  [junk,junk2,FldFld,sig_Fld] = getnewvar('rlds',opt_anom_Var); end

% regress with P'
if ~exist('Fsnet0Fsnet0')
  [junk,Fsnet0Fsnet0] = regrs(FsnetFsnet,PP);
  sig_Fsnet0 = anomaly_sig(Fsnet0Fsnet0); end

if ~exist('Fld0Fld0')
  [junk,Fld0Fld0] = regrs(FldFld,PP);
  sig_Fld0 = anomaly_sig(Fld0Fld0); end

% check (GOOD!)
%isthesame(Fsnet0Fsnet0+Fld0Fld0,F0F0);

%% Call corr_depind.m for computations (instantaneous and summer-avg.)
var_dep = 'E';
vars_ind = {'F0','Fsnet0','Fld0'};
opt_corlag = 0; 
corr_depind;      % use Cor_* , the summer-avg correlations.
% ----------------------------------------------------------------------

% Call plot_3panels.m and plot_hist2.m
plot_3panels;
plot_hist2(addsheet(Cor_EF0,Cor_EFsnet0,Cor_EFld0), ...
            bins,[],name,[]);
% ======================================================================

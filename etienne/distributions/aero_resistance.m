% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% aero_resistance.m
%
% Approximating the aerodynamic resistance to sensible heat flux 
% using T(2m) - T(skin)
% 
% ======================================================================

% extract the sensible heat flux
if ~exist('Hs')
  [Hs,Hsbar,HsHs,sig_Hs] = getnewvar('hfss',opt_anom_Var); end
% ----------------------------------------------------------------------

% extract the skin temperature
if ~exist('Tsk')
  [Tsk,Tskbar,TskTsk,sig_Tsk] = getnewvar('ts',opt_anom_Var); end
% ----------------------------------------------------------------------

% extract surface wind speed
if strcmp(model_name,'hadgem1') && ~exist('V')
  [V,Vbar,VV,sig_V] = getnewvar('Uas',opt_anom_Var); end
% ----------------------------------------------------------------------

%% aerodynamic resistance (includes wind speed)

tmp = Tsk-T;
den = makenan(tmp,'==0');

C = Hs./den;
[Cbar,CC,sig_C] = anomaly(C);

coefvar_C = sqmean(sig_C./Cbar);
% ----------------------------------------------------------------------

%% drag coefficient (only available for the hadgem1)
if strcmp(model_name,'hadgem1')

  den = makenan(V,'==0');
  Cd = C./den;
  [Cdbar,CdCd,sig_Cd] = anomaly(Cd);

  coefvar_Cd = sqmean(sig_Cd./Cdbar);
  %coefvar_C = sqmean(sig_Cd./Cdbar);

end
% ----------------------------------------------------------------------

if opt_plot

  %% plot it

  Z = Cbar;
  %Z = Cdbar;
  mystats(Z,'Cbar');
  cvec = [-200:50:200];
  color_handle = [];
  bins = [-200:10:200]; 
  yval = 2e-2;
  name = 'Cbar';
  plot_summeravg; 

  Z = sig_C;
  %Z = sig_Cd;
  mystats(Z,'sig_C');
  cvec = [0:50:600];
  color_handle = [];
  bins = [0:20:500]; 
  yval = 2e-2;
  name = 'sig_C';
  plot_summeravg; 

  Z = sig_C./Cbar;
  Z = sig_Cd./Cdbar;
  mystats(Z,'coef. var. of C');
  cvec = [0:0.2:1.4];
  opt_x_cvec = 'add_both';
  color_handle = [];
  bins = [0:0.1:5];
  yval = 2;
  name = 'coefvar_C';
  plot_summeravg; 

end
% ----------------------------------------------------------------------

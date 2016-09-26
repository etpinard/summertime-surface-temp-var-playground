% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% sc_em.m
%
% scatter analysis of e_m using plot_scatter_full.m 
%
% ======================================================================

% get [m^2/J]
if ~exist('e_m')
  e_m = param_evapo(EE,mm,F0F0,mbar,Fbar); end

% axis range for plotting
yrange = [0,1e-5];
% ----------------------------------------------------------------------


% plot e_m=e_m(Fbar), summer-avg.
X = sqmean(Fbar);
Y = sqmean(e_m);
plot_scatter_full(X,Y,[280,700],[],[],'e_m-Fbar');
% ----------------------------------------------------------------------

% plot e_m*Fbar=e_m*Fbar(Fbar), summer-avg.
X = sqmean(Fbar);
Y = sqmean(e_m.*Fbar);
plot_scatter_full(X,Y,[280,700],yrange,[],'e_mFbar-Fbar');
% ----------------------------------------------------------------------

% plot e_m*Fbar=e_m*Fbar(Tbar), summer-avg.
X = sqmean(Tbar);
Y = sqmean(e_m.*Fbar);
plot_scatter_full(X,Y,[260,320],yrange,[],'e_mFbar-Tbar');
% ----------------------------------------------------------------------

% plot e_m*Fbar=e_m*Fbar(mbar), summer-avg.
X = sqmean(mbar);
Y = sqmean(e_m.*Fbar);
plot_scatter_full(X,Y,[],yrange,[],'e_mFbar-mbar');
% ----------------------------------------------------------------------

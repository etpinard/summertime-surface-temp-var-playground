% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% sc_kappa.m
%
% scatter analysis of kappa using plot_scatter_full.m 
%
% ======================================================================

% get kappa [W/m^2/K]
if ~exist('kappa')
  kappa = param_damp(HH,TT,mm); end

% axis range for plotting
yrange = [-10,50];          % beware there are negative kappa
% ----------------------------------------------------------------------

% plot kappa=kappa(Tbar), summer-avg.
X = sqmean(Tbar);
Y = sqmean(kappa);
plot_scatter_full(X,Y,[260,320],yrange,[],'kappa-Tbar');
% ----------------------------------------------------------------------

% plot kappa=kappa(mbar), summer-avg.
X = sqmean(mbar);
Y = sqmean(kappa);
plot_scatter_full(X,Y,[],yrange,[],'kappa-mbar');
% ----------------------------------------------------------------------

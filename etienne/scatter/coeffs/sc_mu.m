% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% sc_mu.m
%
% scatter analysis of mu using plot_scatter_full.m 
%
% ======================================================================

% get [J/kg/s]
if ~exist('mu')
  [kappa,mu] = param_damp(HH,TT,mm); end

% axis range for plotting
yrange = [0,31];           
% ----------------------------------------------------------------------


% plot mu=mu(Tbar), summer-avg.
X = sqmean(Tbar);
Y = sqmean(mu);
plot_scatter_full(X,Y,[260,320],yrange,[],'mu-Tbar');
% ----------------------------------------------------------------------

% plot mu=mu(mbar), summer-avg.
X = sqmean(mbar);
Y = sqmean(mu);
plot_scatter_full(X,Y,[],yrange,[],'mu-mbar');
% ----------------------------------------------------------------------

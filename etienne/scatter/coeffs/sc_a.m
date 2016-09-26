% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% sc_a.m
%
% scatter analysis of a using plot_scatter_full.m 
%
% ======================================================================

% get a [1/s]
if ~exist('a')
  [a,xim0xim0] = regrs(ximxim,mm); end

% axis range for plotting
yrange = [-2e-5,6e-5];           
% ----------------------------------------------------------------------

% plot a=a(Tbar), summer-avg.
X = sqmean(Tbar);
Y = sqmean(a);
plot_scatter_full(X,Y,[260,320],yrange,[],'a-Tbar');
% ----------------------------------------------------------------------

% plot a=a(mbar), summer-avg.
X = sqmean(mbar);
Y = sqmean(a);
plot_scatter_full(X,Y,[],yrange,[],'a-mbar');
% ----------------------------------------------------------------------

% plot a=a(Pbar), summer-avg.
X = sqmean(Pbar);
Y = sqmean(a);
plot_scatter_full(X,Y,[],yrange,[],'a-Pbar');
% ----------------------------------------------------------------------

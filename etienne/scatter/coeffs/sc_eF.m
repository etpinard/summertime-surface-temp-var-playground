% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% sc_eF.m
%
% scatter analysis of e_F using plot_scatter_full.m 
%
% ======================================================================

% get [m^2/J]
if ~exist('e_F')
  [e_m,e_F] = param_evapo(EE,mm,F0F0,mbar,Fbar); end

% axis range for plotting
yrange = [0,0.6e-6];        % beware there are negative e_F
% ----------------------------------------------------------------------


% plot e_F*mbar=e_F*mbar(Fbar), summer-avg.
X = sqmean(Fbar);
Y = sqmean(e_F.*mbar);
plot_scatter_full(X,Y,[280,700],yrange,[],'e_Fmbar-Fbar');
% ----------------------------------------------------------------------

% plot e_F*mbar=e_F*mbar(Tbar), summer-avg.
X = sqmean(Tbar);
Y = sqmean(e_F.*mbar);
plot_scatter_full(X,Y,[260,320],yrange,[],'e_Fmbar-Tbar');
% ----------------------------------------------------------------------

% plot e_F*mbar=e_F*mbar(mbar), summer-avg.
X = sqmean(mbar);
Y = sqmean(e_F.*mbar);
plot_scatter_full(X,Y,[],yrange,[],'e_Fmbar-mbar');
% ----------------------------------------------------------------------

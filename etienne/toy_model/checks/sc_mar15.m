% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% sc_mar15.m
%
% color-coded scatter analysis of toy model errors for March 15
% w.r.t mean state T and m using plot_scatter_ccols.m.
%
% ======================================================================

%% Select ind. variables to loop through
vars_ind = {'err_Var_m','err_Var_T'};
Nvar_ind = length(vars_ind);
% ----------------------------------------------------------------------

%% Compute missing fields
if ~exist('err_Var_m') || ~exist('err_Var_T') 
  opt_plot = 0;
  tm_mar15;
  err_Var_m = bias(tm_Var_m,Var_m); 
  err_Var_T = bias(tm_Var_T,Var_T); end
% ----------------------------------------------------------------------

% for all plots, using resdown.m
X = resdown(sqmean(mbar));          % m on x-axis
Y = resdown(sqmean(Tbar));          % T on y-axis
color_handle = @color_posbias;
cvec = [-1:0.25:3];
opt_x_cvec = 'above';
% ----------------------------------------------------------------------

for i=1:Nvar_ind

  % allocating the $ith vars_ind
  var_ind = char(vars_ind(i));
  eval (['Z = ' var_ind ';']);

  % take a temporal mean and call resdown.m
  Z = resdown(sqmean(Z));

  % output some statistics
  mystats(Z,var_ind)

  % set output name
  name = [var_ind,'-Tm_mar15'];

  % Call plot_scatter_ccols
  plot_scatter_ccols(X,Y,Z,cvec,opt_x_cvec, ...
                           [],[],name,color_handle);

end

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% sc_ccols_sens_Tm.m
%
% color-coded scatter analysis of sensitivity metrics 
% w.r.t mean state T and m using plot_scatter_ccols.m.
%
% ======================================================================

%% Select ind. variables to loop through
vars_ind = {'sig_T_sig_m','sig_T_sig_F'};
Nvar_ind = length(vars_ind);
% ----------------------------------------------------------------------

%% Compute missing fields
if ~exist('sig_T_sig_m') && isinarray('sig_T_sig_m',vars_ind)
  den = makenan(sig_m,'==0'); sig_T_sig_m = sig_T./den; end

if ~exist('sig_T_sig_F') && isinarray('sig_T_sig_F',vars_ind)
  den = makenan(sig_F,'==0'); sig_T_sig_F = sig_T./den; end
% ----------------------------------------------------------------------

% for all plots, using resdown.m
X = resdown(sqmean(mbar));          % m on x-axis
Y = resdown(sqmean(Tbar));          % T on y-axis
color_handle = [];
% ----------------------------------------------------------------------

for i=1:Nvar_ind

  % allocating the $ith vars_ind
  var_ind = char(vars_ind(i));
  eval (['Z = ' var_ind ';']);

  % take a temporal mean and call resdown.m
  Z = resdown(sqmean(Z));

  % output some statistics
  mystats(Z,var_ind)

  % determine color-codes
  switch var_ind

    case 'sig_T_sig_m';   cvec = [0:0.5:3];
    case 'sig_T_sig_F';   cvec = [0:0.05:0.3];
  
  end

  % set output name
  name = [var_ind,'-Tm'];

  % Call plot_scatter_ccols
  plot_scatter_ccols(X,Y,Z,cvec,[-1,50],[260,310],name,color_handle);

end

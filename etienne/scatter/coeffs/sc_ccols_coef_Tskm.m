% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% sc_ccols_coef_Tskm.m
%
% same as sc_ccols_coef_Tm.m but using the skin temperature.
%
% ======================================================================

%% Select ind. variables to loop through
vars_ind = {'kappa_sk','mu_sk'};
Nvar_ind = length(vars_ind);
% ----------------------------------------------------------------------

%% Get skin temperature
if ~exist('TskTsk') || ~exist('Tskbar')
  [junk1,Tskbar,TskTsk] = getnewvar('ts',opt_anom_Var); end
% ----------------------------------------------------------------------

%% Compute missing fields
if ~exist('kappa_sk') && isinarray('kappa_sk',vars_ind)
  [kappa_sk,mu_sk] = param_damp(HH,TskTsk,mm); 
  kappa_sk = makenan(kappa_sk,'<0'); end

if ~exist('mu_sk') && isinarray('mu_sk',vars_ind)
  [kappa_sk,mu_sk] = param_damp(HH,TskTsk,mm); end
% ----------------------------------------------------------------------

% for all plots, using resdown.m
X = resdown(sqmean(mbar));          % m on x-axis
Y = resdown(sqmean(Tskbar));          % T on y-axis
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

    case 'kappa_sk'; cvec = [0:10:50];
    case 'mu_sk';    cvec = [0:2:8];

  end

  % set output name
  name = [var_ind,'-Tskm'];

  % Call plot_scatter_ccols
  plot_scatter_ccols(X,Y,Z,cvec,[-1,50],[260,310],name,color_handle);

end

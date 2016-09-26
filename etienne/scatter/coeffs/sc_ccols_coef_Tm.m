% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% sc_ccols_coef_Tm.m
%
% color-coded scatter analysis of toy model coefficients 
% w.r.t mean state T and m using plot_scatter_ccols.m.
%
% ======================================================================

%% Select ind. variables to loop through
vars_ind = {'kappa','mu','e_mFbar','e_Fmbar','chi'};
Nvar_ind = length(vars_ind);
% ----------------------------------------------------------------------

%% Compute missing fields
if ~exist('kappa') && isinarray('kappa',vars_ind)
  [kappa,mu] = param_damp(HH,TT,mm); kappa = makenan(kappa,'<0'); end

if ~exist('mu') && isinarray('mu',vars_ind)
  [kappa,mu] = param_damp(HH,TT,mm); end

if ~exist('e_mFbar') && isinarray('e_mFbar',vars_ind)
  e_m = param_evapo(EE,mm,F0F0,mbar,Fbar); e_mFbar = e_m.*Fbar; end

if ~exist('e_Fmbar') && isinarray('e_Fmbar',vars_ind)
  [e_m,e_F] = param_evapo(EE,mm,F0F0,mbar,Fbar); e_Fmbar = e_F.*mbar; end

if ~exist('chi') && isinarray('chi',vars_ind)
  if ~exist('e_m')
    e_m = param_evapo(EE,mm,F0F0,mbar,Fbar); end
  [jk1,jk2,jk3,jk4,tau_s] = param_smres(ximxim,mm,PP,e_m.*Fbar); 
  chi = (e_m.*Fbar-mu/L).*tau_s;  % if mu exist ...
  end
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

    case 'kappa'; cvec = [0:10:50];
    case 'mu';    cvec = [0:2:8];
    case 'e_mFbar'; cvec = [0:0.25e-5:0.5e-5];
    case 'e_Fmbar'; cvec = [0:0.1e-6:0.3e-6];
    case 'chi';   cvec = [-1:0.25:1];
  
  end

  % set output name
  name = [var_ind,'-Tm'];

  % Call plot_scatter_ccols
  plot_scatter_ccols(X,Y,Z,cvec,[-1,50],[260,310],name,color_handle);

end

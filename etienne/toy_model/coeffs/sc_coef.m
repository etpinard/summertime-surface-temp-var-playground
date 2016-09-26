% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% sc_coef.m
%
% color-coded scatter analysis of toy model parameters (for March 15).
%
% ======================================================================

%% Select ind. variables to loop through
vars_ind = {'tau_planck','tau_diff','tau','lambda','alpha_L', ...
            'tau_E','tau_H','tau_s','beta_R','beta_infil','beta','chi'};
Nvar_ind = length(vars_ind);
% ----------------------------------------------------------------------

%% Compute missing fields
C_p = 1e5; 
tau_planck = C_p./kappa;	
tau_diff = C_p./gam_T;	
tau = C_p./(kappa+gam_T);
%lambda
alpha_L = alpha/L;
%tau_E
%tau_H
%tau_s
beta_R = r;
beta_infil = b;
beta = beta_R + beta_infil;
chi = (e_m.*Fbar-mu/L).*tau_s;
% maybe add product of chi and (1-beta)
% ----------------------------------------------------------------------

% for all plots, using resdown.m
X = resdown(sqmean(mbar));          % m on x-axis
Y = resdown(sqmean(Tbar));          % T on y-axis
color_handle = [];
opt_x_cvec = 'add_both';
% ----------------------------------------------------------------------

for i=1:Nvar_ind
  
  % allocating the $ith vars_ind
  var_ind = char(vars_ind(i));
  eval (['Z = ' var_ind ';']);
  
  switch i
    case 1; cvec = [0:0.1:0.6]; Z = Z/secinday;
    case 2; cvec = [0:1:6];     Z = Z/secinday;
    case 3; cvec = [0:0.1:0.6]; Z = Z/secinday;
    case 4; cvec = [-0.2:0.1:1]; 
    case 5; cvec = [-0.4:0.2:1.4]; 
    case 6; cvec = [0:5:35];    Z = Z/secinday;
    case 7; cvec = [0:5:35];    Z = Z/secinday;
    case 8; cvec = [0:5:30];    Z = Z/secinday;
    case 9; cvec = [0:0.1:0.8]; 
    case 10; cvec = [0:0.1:0.8]; 
    case 11; cvec = [0:0.1:0.8]; 
    case 12; cvec = [-2:0.5:2]; 
  end

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

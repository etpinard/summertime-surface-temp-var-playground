% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% tm_param_full.m 
%
% Computing toy model parameterizations.
%
%
% 1) Normalized alpha by L 
%
% 2) Param. E' as
%   E' = nu_E*m' + (lambda/L)*F0' , if nu_E >0 
%   E' = lambda/L*F_0' - lambda_P*P' , if nu_E<=0 
% with nu_E [s-1] >=0, lambda and lambda_P [-] >=0 ,
%
% ** Use nu_E >0,=<0 to define the 'dry' and 'wet' soils.
%
% 3) Param. Hs' as
%   Hs' = gamma_Hs*T' + L*nu_Hs*m' ,
% with nu_Hs [s-1] >=0 and gamma_Hs [Wm-2K-1] >=0.
%
% 4) Param. Flu' as 
%   Flu' = gamma_lw*T' ,
% with gamma_lw [Wm-2K-1] >=0 everywhere.
%
% 5) Param. xiU' (~G') as 
%   xiU' = gamma_G*T' ,
% with gamma_G [Wm-2K-1] >=0 everywhere.
%
% 6) Param. R' as 
%   R' = beta_R*P'
% with beta_R [-] and no restriction.
%
% 7) Param. xim' (~I') as
%   xim' = nu_I*m' + beta_I*P'
% with nu_I 
%
% -) Collect coeffecients as 
%   'gamma', 'nu_s', 'lambda', 'lambda_P', 'chi' and 'beta' 
%
% *) Compute toy model TT, mm, Var(T) and Var(m)
%
% Options:
% -opt_tilde: =1 to compute chi_tilde, gamma_tilde, eta
%
% Outputs: 
% - coeffs: nu_E, nu_Hs, nu_s, gamma_Hs, gamma_lw, gamma_G, gamma,
%    alpha, beta_I, beta_R, beta, lambda, lambda_P.
% - indices: dry, wet.
% - residuals: E00E00, Hs00Hs00, Flu0Flu0, xiU0xiU0, R0R0, xim00xim00
% - fields: tm_TT, tm_Var_T, tm_mm, tm_Var_m.
%
% ======================================================================

%% @) Default option
if ~exist('opt_tilde')
  opt_tilde = 0;
end
% ----------------------------------------------------------------------

%% ~) Support for trimmed datasets 
	
tmp_Nyear = size(P,1)/Nmonth;

% 2nd argument for 'xmonth.m'
% e.g. in plot_tm_Var_T_bias_extreme_years.m
% ======================================================================

%% 0) Tell matlab that alpha, gamma, beta are variables, not functions

alpha = [];
gamma = [];
beta = [];
% ======================================================================

%% 1) Re-compute alpha and normalized by L --> regres.m 

disp('Computing ... alpha (normalized by L)');
[alpha,F0F0] = regrs(FF,-PP);
alpha = alpha/L;

% with the indices 'nogood_Px2d' and 'nogood_P' from anomaly_full.m
F0F0(nogood_Px2d) = FF(nogood_Px2d);
alpha(nogood_P) = 0;
% ======================================================================

%% 2) Parameterize E' and define 'dry' and 'wet' regimes

disp('Computing ... nu_E and lambda (july 05)');

% (d.i) regress E' onto m' to get nu_E and E0' (dry)
[nu_E,E0E0_dry] = regrs(EE,mm);			

% (*) find places where nu_E is > 0 and <= 0 ,
%      defining the two evaporation regimes
dry = (nu_E > 0);   
wet = ~dry;   

% (#) restrict nu_E to >0, (i.e. set nu_E=0 over wet)
nu_E = nu_E.*dry;

% (d.ii) regress E0' onto FF' to get lambda and E00' (dry)
[tmp_dry,E00E00_dry] = regrs(E0E0_dry,FF);
lambda_dry = L*tmp_dry;		

% (#) restrict lambda_dry>0 
rest = (lambda_dry > 0);
lambda_dry = lambda_dry.*rest;
E00E00_dry = E00E00_dry.*xmonth(rest,tmp_Nyear) ...
                + E0E0_dry.*xmonth(~rest,tmp_Nyear);

% (w.i) regress E' onto F' to get lambda and E0' (wet)
[tmp_wet,E0E0_wet] = regrs(EE,FF);
lambda_wet = L*tmp_wet;	

% (#) restrict lambda_wet>0
rest = (lambda_wet > 0);
lambda_wet = lambda_wet.*rest;
E0E0_wet = E0E0_wet.*xmonth(rest,tmp_Nyear) ...
             + EE.*xmonth(~rest,tmp_Nyear);
E00E00_wet = E0E0_wet;  % just 1 param (07/05)

% combine lambda dry and wet
lambda = lambda_dry.*dry + lambda_wet.*wet;
clear tmp_dry tmp_wet lambda_dry lambda_wet

% combine E00' dry and wet 
E00E00 = E00E00_dry.*xmonth(dry,tmp_Nyear) ...
           + E00E00_wet.*xmonth(wet,tmp_Nyear);
clear E00E00_dry E00E00_wet
% ======================================================================

%% 3) Parameterize Hs' 

% *** Important: adding a condition on the Hs' paramaterization makes
% 'chi' unphysical. I noticed nu_Hs > nu_E (i.e. chi<0) over some dry
% soils which is unrealistic in our interpretation of Hs' linked
% to m' through E'.

disp('Computing ... gamma_Hs and nu_Hs (june 19)');

% (i) regress Hs' onto T' to get gamma_Hs and Hs0'
[gamma_Hs,Hs0Hs0] = regrs(HsHs,TT); 

% (#) restrict gamma_Hs>0 
rest = (gamma_Hs > 0);
gamma_Hs = gamma_Hs.*rest;
Hs0Hs0 = Hs0Hs0.*xmonth(rest,tmp_Nyear) ...
            + HsHs.*xmonth(~rest,tmp_Nyear);

% (ii) regress Hs0' onto (-m') to get nu_Hs and Hs00'
[tmp,Hs00Hs00] = regrs(Hs0Hs0,-mm);
nu_Hs = tmp/L;		

% (#) restrict nu_Hs to postive values
rest = (nu_Hs > 0);
nu_Hs = nu_Hs.*rest;
Hs00Hs00 = Hs00Hs00.*xmonth(rest,tmp_Nyear) ...
                  + Hs0Hs0.*xmonth(~rest,tmp_Nyear);

if opt_tilde % $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

disp('Computing ... eta and nu_Hs_tilde (july 22)');

% (i) regress Hs' onto (-m') to get nu_Hs_tilde and Hs0'_tilde
[tmp,Hs0Hs0_tilde] = regrs(HsHs,-mm); 
nu_Hs_tilde = tmp/L;		

% (#) restrict nu_Hs_tilde>0 
rest = (nu_Hs_tilde > 0);
nu_Hs_tilde = nu_Hs_tilde.*rest;
Hs0Hs0_tilde = Hs0Hs0_tilde.*xmonth(rest,tmp_Nyear) ...
                + HsHs.*xmonth(~rest,tmp_Nyear);

% (ii) regress Hs0'_tilde onto (F') to get eta and Hs00'_tilde
[eta,Hs00Hs00_tilde] = regrs(Hs0Hs0_tilde,FF);

% (#) restrict nu_Hs to postive values
rest = (eta > 0);
eta = eta.*rest;
Hs00Hs00_tilde = Hs00Hs00_tilde.*xmonth(rest,tmp_Nyear) ...
                  + Hs0Hs0_tilde.*xmonth(~rest,tmp_Nyear);

end % $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

% ======================================================================

%% 4) Parameterize Flu'  

disp('Computing ... gamma_lw');

% regress Flu' onto T' to get gamma_lw and Flu0'
[gamma_lw,Flu0Flu0] = regrs(FluFlu,TT);

% restrict gamma_lw to postive values
rest = (gamma_lw > 0);
gamma_lw = gamma_lw.*rest;
Flu0Flu0 = Flu0Flu0.*xmonth(rest,tmp_Nyear) ...
              + FluFlu.*xmonth(~rest,tmp_Nyear);
% ======================================================================

%% 5) Parameterize xiU' (which is ~ G', heat diffusion through ground) 

disp('Computing ... gamma_G');

% regress xiU' onto T' to get gamma_G and xiU0'
[gamma_G,xiU0xiU0] = regrs(xiUxiU,TT); 

% restrict gamma_G to postive values
rest = (gamma_G > 0);
gamma_G = gamma_G.*rest;
xiU0xiU0 = xiU0xiU0.*xmonth(rest,tmp_Nyear) ...
              + xiUxiU.*xmonth(~rest,tmp_Nyear);
% ======================================================================

%% 6) Parameterize R' 

disp('Computing ... beta_R');

% regress R' onto P' to get beta_R and R0'
[beta_R,R0R0] = regrs(RR,PP);					

% leave negative values (happens in high Arctic), they are physical.
% ======================================================================

%% 7) Parameterize xim' (which is ~ I', infiltration) 

disp('Computing ... nu_I and beta_I');

% regress xim' onto m' to get nu_I and xim0'
[nu_I,xim0xim0] = regrs(ximxim,mm);

% leave negative values, they are physical.

% regress xim0' onto P' to get beta_I and xim00'
[beta_I,xim00xim00] = regrs(xim0xim0,PP);

% leave negative values, they are physical.
% ======================================================================

%% -) Collect coefficients

disp('Collecting coeffs ... gamma, nu_s, beta, chi');

% effective land-atm temperature sensitivity [W m-2 K-1]
gamma = gamma_Hs + gamma_lw + gamma_G;
gamma = makenan(gamma,'==0');   % remove 0 values

% effective rate at which soil moisture is lost [s-1]
nu_s = nu_I + nu_E;
nu_s = makenan(nu_s,'==0');     % remove 0 values

% fraction of P' instantaneously loss to R' and I' [-]
beta = beta_R + beta_I;
beta(nogood_P) = 0;
 
% coupling parameter, the net effect of m' on T' [-]
chi = (nu_E - nu_Hs)./nu_s;

% remove unphysical soil moisture escape rates
nogood = find(abs(nu_s) < 1./(30*secinday));
chi(nogood) = 0;

if opt_tilde

disp('Collecting coeffs ... gamma_tilde, chi_tilde');

% effective land-atm temperature sensitivity [W m-2 K-1]
gamma_tilde = gamma_lw + gamma_G;
gamma_tilde = makenan(gamma_tilde,'==0');   % remove 0 values

% coupling parameter, the net effect of m' on T' [-]
chi_tilde = (nu_E - nu_Hs_tilde)./nu_s;

% remove unphysical soil moisture escape rates
chi_tilde(nogood) = 0;

end
% ======================================================================

%% *) Compute tm_Var(T) and tm_Var(m)

if exist('Var_P') && exist('Var_F0')

% some datasets have 'NaN' values for Var(P) and alpha, set them to 0.
% (07/02) do I still need this?
nan_P = find(Var_P < 0.01/secinday^2);

% TT and Var(T)
disp('Computing ... tm_TT and tm_Var_T');

tm_TT = ...
  1./xmonth(gamma,tmp_Nyear).*( ...
      xmonth(1-lambda.*(1-chi),tmp_Nyear).*F0F0 ...
  - L*xmonth(alpha.*(1-lambda) + ... 
             chi.*(1+alpha.*lambda-beta),tmp_Nyear).*PP );

tm_Var_T = ...
  1./(gamma.^2).*( ...
      (1-lambda.*(1-chi)).^2.*Var_F0 ...
    + L^2*(alpha.*(1-lambda) + ...
           chi.*(1+alpha.*lambda-beta)).^2.*Var_P );

tm_Var_T(nan_P) = ...
  1./(gamma(nan_P).^2).* ...
  ( (1-lambda(nan_P).*(1-chi(nan_P))).^2.*Var_F0(nan_P) );

% mm and Var(m)
disp('Computing ... tm_mm and tm_Var_m');

tm_mm = ...
  1./xmonth(nu_s,tmp_Nyear).*( ...
    xmonth(1+alpha.*lambda-beta,tmp_Nyear).*PP ...
    - xmonth(lambda/L,tmp_Nyear).*F0F0 );

tm_Var_m = ...
  1./(nu_s.^2).* ...
  ( (1+alpha.*lambda-beta).^2.*Var_P + (lambda/L).^2.*Var_F0 );

tm_Var_m(nan_P) = ...
  1./(nu_s(nan_P).^2).*( (lambda(nan_P)/L).^2.*Var_F0(nan_P) );

end

if opt_tilde && exist('Var_P') && exist('Var_F0')

% TT and Var(T)
disp('Computing ... tm_TT_tilde and tm_Var_T_tilde');

tm_TT_tilde = ...
  1./xmonth(gamma_tilde,tmp_Nyear).*( ...
      xmonth(1-lambda.*(1-chi_tilde)-eta,tmp_Nyear).*F0F0 ...
  - L*xmonth(alpha.*(1-lambda-eta) + ... 
             chi_tilde.*(1+alpha.*lambda-beta),tmp_Nyear).*PP );

tm_Var_T_tilde = ...
  1./(gamma_tilde.^2).*( ...
      (1-lambda.*(1-chi_tilde)-eta).^2.*Var_F0 ...
    + L^2*(alpha.*(1-lambda-eta) + ...
           chi_tilde.*(1+alpha.*lambda-beta)).^2.*Var_P );

tm_Var_T_tilde(nan_P) = ...
  1./(gamma_tilde(nan_P).^2).* ...
  ( (1-lambda(nan_P).*(1-chi_tilde(nan_P)) ...
        -eta(nan_P)).^2.*Var_F0(nan_P) );

end

% clear tmp variables
clear nogood tmp_Nyear rest
% ======================================================================

% ======================================================================

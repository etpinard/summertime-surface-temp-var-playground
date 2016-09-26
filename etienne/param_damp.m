function [kappa,mu,H0H0,H00H00,tau_H] = param_damp(HH,TT,mm,opt)
%
% A function that computes the toy model parameterization of the 
% the surface energy damping field (longwave up + sensible heat)
%
% Parameterize H' as
%
%  H' = kappa * T' - mu * m' (1st proj. onto T' , note the minus sign)
%
% where [kappa]=W/K/m^2 and [mu]=J/kg/s .
%
% (NEW!) mu is constrained to be postive definite
%
% Relabel to ease the physical interpretation as
%
% H' = kappa * T' - L * (1/tau_H) * m' , [kappa]=W/m^2/K [tau_H]=seconds
%
% INPUT:				HH      , damping anomalies 
%               TT      , temperature anomalies
%               mm      , soil moisture anomalies
%               opt     , (NEW!) option string.
%                         opt='ortho' for an orthogonal decomp.
%
% OUTPUT:				kappa   , regres. coeff. from proj. onto T'
%               mu      , regres. coeff. from proj. onto m'
%               H0H0    , residual after the first projection
%               H00H00  , residual after 2 the projections 
%               tau_H   , mu with units of time (not in 'orth')
% ======================================================================

  
  % std. output header 
%  disp('Computing ... kappa , mu (tau_H) , H0H0 , H00H00 ');
  
  % load L 
  load('global.mat','L')
  
  % set default opt to 'obl' (oblique)
  if nargin==3 
    opt = 'obl';
  end

  %% Oblique projection scheme, used exclusively until 03/08
  if strcmp(opt,'obl')

    % std. output option
    disp('  using oblique projections');

    % compute kappa and H0H0 
    [kappa,H0H0] = regrs(HH,TT);
     
    % compute mu and H00H00 
    [tmp,H00H00] = regrs(H0H0,mm);			
    mu = -tmp;

    % set negative mu to 0 
    pos = (mu > 0);   
    mu = mu.*pos;
    
    % (NEW!) H00H00 becomes H0H0 where mu<0
    neg = (mu <= 0);
    H00H00 = H00H00.*xmonth(pos) + H0H0.*xmonth(neg);

    % relabeling my in units of time
    tau_H = mu;                               % same dims
    tau_H(pos) = L./mu(pos);
    tau_H(neg) = NaN;                         % if mu<0, set to NaN
    
  %% Try orthogonal projections
  elseif strcmp(opt,'orth')

    % std. output option
    disp('  using orthogonal projections');

    % decompose T' = T_0' - a m'  with T_0' orthog. m'
    [a,T0T0] = regrs(TT,-mm); 

    % project H' onto T_0' ; H' = H_0' + kappa T_0' 
    [kappa,H0H0] = regrs(HH,T0T0);

    % project H_0' onto -m' ; H' = H_00' - mu m' + kappa T_0'
    % where H_00' is orthog to both m' and T_0'
    [mu,H00H00] = regrs(H0H0,-mm);

      % verify the last statement (Yes, it is true)
    %isthesame(nanmean(H00H00.*mm),0)
    %isthesame(nanmean(H00H00.*T0T0),0)

    % relabel --- [mu] and [kappa*a] = J/kg/s
    tauH = L./(mu  - a.*kappa);

  end

end

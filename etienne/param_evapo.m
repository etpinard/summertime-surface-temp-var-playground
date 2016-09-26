function [e_m,e_F,E00E00,lambda,tau_E] ...
                  = param_evapo(EE,mm,F0F0,mbar,Fbar,opt,m)
%
% A function that computes the toy model parameterization of the 
% the evapotranspiration field (total form top and bottom soil layers)
%
% We parameterize E' as
%
%  E' = e_m * Fbar * m' + e_F * mbar * F_0'  (1st proj. onto m')
%
% where e_m and e_F have units of m^2/J and are constrained to be > 0.
%
% In places where e_m < 0, set 
%
%  E' = e_F * mbar * F_0' (NEW! using the full E')
%
% Relabel to ease the physical interpretation as
%
% E' = (1/tau_E) * m' + lambda/L * F_0' , [tau_E]=seconds, [lambda]={} .
%
%
% INPUT:				EE      , evapotranspirtaion anomalies 
%               mm      , soil moisture anomalies
%               F0F0    , forcing residual anomalies
%               mbar    , mean soil moisture
%               Fbar    , mean radiation forcing
%               opt     , (NEW!) option string.
%                         opt='dry' for dry algorithm.
%               m       , if opt='dry' must send the (full) soil
%                         moisture m
%
% OUTPUT:				e_m     , regres. coeff. from proj. onto m'
%               e_F     , regres. coeff. from proj. onto F0'
%               E00E00  , residual after the projections 
%               lambda  , unitless e_F
%               tau_E   , e_m with units of time (not in 'dry')
%               E0E0    , maybe too?
% ===================================================================


  % std. output header 
%  disp('Computing ... e_m (tau_E), e_F (lambda) , E00E00');
  
  % load L 
  load('global.mat','L')
  
  % set default opt to 'full'
  if nargin==5
    opt = 'full';
  end

  %% Full algorithm, using every soil moisture values.
  if strcmp(opt,'full')

    % std. output header 
    disp('  using the full moisture range');

    % compute e_m and E0E0
    [tmp,E0E0] = regrs(EE,mm);			
    e_m = tmp./Fbar;								
    
    % find places where e_m is > 0 and <= 0  
    pos = (e_m > 0);   
    neg = (e_m <= 0);   
    
    % set negative e_m to 0  (should I ?)
    e_m = e_m.*pos;
    
    % if e_m > 0 , compute e_F from E0E0 
    [tmp_pos,E00E00_pos] = regrs(E0E0,F0F0);
    e_F_pos = tmp_pos./mbar;		
    
    % if not , use EE
    [tmp_neg,E00E00_neg] = regrs(EE,F0F0);
    e_F_neg = tmp_neg./mbar;		
    
    % combine e_F
    e_F = e_F_pos.*pos + e_F_neg.*neg;
    clear e_F_pos e_F_neg
    
    % combine the residual 
    E00E00 = E00E00_pos.*xmonth(pos) + E00E00_neg.*xmonth(neg);
    clear E00E00_pos E00E00_neg
    
    % relabeling e_F in unitless form
    lambda = L*e_F.*mbar;
    
    % relabeling e_m in units of time
    tau_E = e_m;                              % same dims
    tau_E(pos) = 1./(e_m(pos).*Fbar(pos));    
    tau_E(neg) = NaN;                         % if e_m<0, set to NaN

  %% Dry algorithm, using only mm' correp. to m < m_crit
  elseif strcmp(opt,'dry')
  
    % load m_crit and Iland
    load('global.mat','m_crit','Iland')

    % std. output header 
    disp('  using the dry algorithm');
  
    % find the m (full variable) values corresp. to the 2 regimes
    wet = find(m > m_crit);
    dry = find(m <= m_crit);
  
    % with mm in dry regime, compute e_m_dry (units m^2/J)
    mm_dry = mm;
    mm_dry(wet) = NaN;                        % !! inconsistent notation
    [tmp,E0E0_dry] = regrs(EE,mm_dry);        % will need to be nansync 
    e_m = tmp./Fbar;                      
    e_m = nansync(e_m,x2d(0*Iland));          % e_m=0 over wet regions
  
    % in dry regime, use E0E0_dry (and F0F0) to comptue e_F_dry (m^2/J)
    [tmp,E00E00_1] = regrs(E0E0_dry,F0F0);         
    e_F_1 = tmp./mbar;                    % both will need to be nansync
    
    % in wet regime, use EE and F0F0 in wet regime to compute e_F_dry
    F0F0_wet = F0F0;
    F0F0_wet(dry) = NaN;
    [tmp,E0E0_wet] = regrs(EE,F0F0_wet);    % Nmonth X Nlat X Nlon
    e_F_2 = tmp./mbar;                      % will need to be nansync
    
    % subbing into e_F_dry and E00E00_dry using nansync.m 
    % w/o the suffices for output
    e_F = nansync(e_F_1,e_F_2);
    E00E00 = nansync(E00E00_1,E0E0_wet);
    
    % relabeling without the "_dry" suffix
    lambda = L*e_F.*mbar;
    %tauE_dry = 1./(e_m_dry.*Fbar);        
  

      %% Find a way to incorporate the follwing ...
      
    % in case e_m_dry <=0 still 
    % note that notauH is NOT affected
    %notauE_dry = find( e_m_dry<=0 | isnan(e_m_dry) );     
  
    % aggregating with tauH
    %tautilde_dry = 1./(1./tauE_dry - 1./tauH);
    %tautilde_dry(notauE_dry) = -tauH(notauE_dry);
    %tautilde_dry(notauH) = tauE_dry(notauH);       
  
    %% corresp. frequency
    %nutilde_dry = 1./tautilde_dry;

  end

end

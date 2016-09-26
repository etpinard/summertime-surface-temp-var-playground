% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% bld_m_R0.m 
%
% Examine the effects of R0 (the runoff residual) in the soil moisture
% budget.
% ======================================================================

%% General plotting options
cvec = [-2:0.25:3]; color_handle = @color_tm3;
bins = [-2:0.1:5]; yval = 3.5;
opt_overlay = 0;
% ----------------------------------------------------------------------

%% Get 'a' and define taus
if ~exist('a')
  [a,xim0xim0] = regrs(ximxim,mm); end
if ~exist('taus')
  den = (a+e_m.*Fbar);
  den = makenan(den,'==0');
  taus = 1./den; end
% ----------------------------------------------------------------------


%% Set R_0' = 0 | Full E' and xim'

bld = xmonth(taus).* ...
       ( (1-xmonth(r)).*PP - xmonth(lambda/L).*F0F0 ...
           - E00E00 - xim0xim0 );
bld_Var = anomaly_Var(bld);

name = 'bld_m_R0=0';
Z = bias(bld_Var,Var_m);
mystats(Z); 
plot_summeravg; %plot_all; 

% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% bld_m_xim.m 
%
% Examine the effects of xim (the residual) in the soil moisture
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


%% Param xim0' = {b*T' or b*P'} | Full E' and R'

vars_ind = {'P','T'};   % variables to project upon xim0'

% loop through vars_ind
for i=1:length(vars_ind)

  % assign var_ind(i) to X and project xim0xim0 onto it
  eval(['XX = ' char(vars_ind(i)) char(vars_ind(i)) ';']);
  b = regrs(xim0xim0,XX);
 
  bld = xmonth(taus).* ...
         ( (1-xmonth(r)).*PP - xmonth(lambda/L).*F0F0 ...
             - E00E00 - R0R0 - xmonth(b).*XX );
  bld_Var = anomaly_Var(bld);

  name = ['bld_m_xim0-' char(vars_ind(i))];
  Z = bias(bld_Var,Var_m);
  mystats(Z); 
  plot_summeravg; %plot_all; 

end

% ======================================================================

%break

%% Param xim' = a*m' | Full E' and R'

bld = xmonth(taus).* ...
       ( (1-xmonth(r)).*PP - xmonth(lambda/L).*F0F0 ...
           - E00E00 - R0R0);
bld_Var = anomaly_Var(bld);

name = 'bld_m_xim0=0';
Z = bias(bld_Var,Var_m);
mystats(Z); 
plot_summeravg; %plot_all; 

% ======================================================================

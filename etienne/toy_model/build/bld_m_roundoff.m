% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% bld_m_roundoff.m 
%
% Check if the sfc engy budget is conserved ...
% This should output nothing more than runoff errors.
% ======================================================================

%% General plotting options
cvec = [-2:0.25:3]; color_handle = @color_tm3;
bins = [-2:0.1:5]; yval = 3.5;
opt_overlay = 0;
% ----------------------------------------------------------------------

%% Get 'a' and define taus
if ~exist('a')
  [a,xim0xim0] = regrs(ximxim,mm); end
den = (a+e_m.*Fbar);
den = makenan(den,'==0');
taus = 1./den;
% ----------------------------------------------------------------------


%% Budget check.

bld = xmonth(taus).* ...
       ( (1-xmonth(r)).*PP - xmonth(lambda/L).*F0F0 ...
           - E00E00 - R0R0 - xim0xim0);
bld_Var = anomaly_Var(bld);

name = 'bld_m_roundoff';
Z = bias(bld_Var,Var_m);
mystats(Z); 
plot_summeravg; %plot_all; 

   %% By including the residual we make NO errors.

% ======================================================================

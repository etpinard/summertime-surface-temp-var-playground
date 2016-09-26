%%% Investigates the importance of the surface albedo in the surface
  % energy budget.
  %
  % Coded from opt_anom_Var='no'
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% plotting option for all plots
opt_monthly = 0;
cvec = [0:0.25:4]; color_handle = @color_ltone;
bins = [0:0.01:4.5]; yval = 3.5;	

%% Extracting both shortwave terms and computing the albedo
if ~exist('Fsd') 
  [Fsd,Fsdbar,FsdFsd,sig_Fsd] = getnewvar('rsds',opt_anom_Var); end
if ~exist('Fsu')
  [Fsu,Fsubar,FsuFsu,sig_Fsu] = getnewvar('rsus',opt_anom_Var); end

A = Fsu./Fsd;
[Abar,AA,sig_A] = anomaly(A);
% ======================================================================

%%% 1) compare (Fbar* A') / (Abar * F')

% estimate for Fbar * A' 
Fbarsig_A = Fbar.*sig_A;

% estimate for Abar * F'
Abarsig_F = Abar.*sig_F;

% call compare and compare_plot
vars_pairs = {'Fbarsig_A','Abarsig_F'};
opt_lock=1;
compare
compare_plot
% ======================================================================

%%% 2) compare (Fsdbar * A') / (Abar * Fsd')

% estimate for Fsdbar * A'
Fsdbarsig_A = Fsdbar.*sig_A;

% estimate for Abar * Fsu'
Abarsig_Fsd = Abar.*sig_Fsd;

% call compare and compare_plot
vars_pairs = {'Fsdbarsig_A','Abarsig_Fsd'};
opt_lock=1;
compare
compare_plot
% ======================================================================

%%% 3) compare (Fsdbar * A') / (Fsd' * (1-Abar) + Fld') 

% need Flw_down
if ~exist('Fld')
  [junk1,junk2,FldFld,sig_Fld] = getnewvar('rlds',opt_anom_Var); end

% estimate for (Fsd(1-Abar) + Fld)
stuff = FsdFsd.*(1-xmonth(Abar)) + FldFld;
sig_stuff = anomaly_sig(stuff);

% call compare and compare_plot
vars_pairs = {'Fsdbarsig_A','sig_stuff'};
opt_lock=1;
compare
compare_plot
% ======================================================================

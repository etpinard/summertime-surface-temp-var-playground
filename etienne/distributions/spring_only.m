%%% Similar to winter_only.m but now for the spring month: MAM for the
  % NH and SON for the SH.
  %
	%	Plotting is automated using plot_summeravg.m (yes, a misnomer...)
  %
  % Eventually, you should make some difference plots with the summer
  % only fields ....
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% Extracting surface air temperature and top-layer soil moisture, 
% trimmed to spring months only ---> using getnewvar with the
% months_only option.
months_only = [3,5];
if ~exist('Tsp');
  [Tsp,Tspbar,TspTsp,sig_Tsp] = ... 
                     getnewvar('tas',opt_anom_Var,months_only);
end
if ~exist('msp');
  [msp,mspbar,mspmsp,sig_msp] = ...
                     getnewvar('mrsos',opt_anom_Var,months_only);
end
% ======================================================================

% anything else ...

% Plotting corr(m(i),m(i+1))
if ~exist('Corlag_m_spring');
  disp(['Computing ... Corlag_m_spring']);
  [junk1,Corlag_m_spring] = corr_autolag(mspmsp,sig_msp);
end
Z = sqz(Corlag_m_spring(1,:,:));    % lag 1-month
above1 = find(Z > 1); Z(above1) = 1;  % cheeky move for grid boxes > 1
name = 'corlag1_m_spring';
cvec = [-1:0.1:1]; 
bins = [-1:0.01:1]; yval = 3;
color_handle = @color_corr3; plot_summeravg

% More than in summer, less than in winter.
% Yep, soil moisture memory cannot be captured in the top 10 cm.
% There must be a mechanism that bring lower layer moisture back to
% the top layer ... where most of the evaporation comes from in most
% (I think) places.

% ======================================================================

% Plotting corr(T,m)
if ~exist('Cor_Tm_spring');
  disp(['Computing ... Cor_Tm_spring']);
  [junk1,Cor_Tm_spring] = corr_inst(TspTsp,mspmsp,sig_Tsp,sig_msp);
end
Z = Cor_Tm_spring;
name = 'cor_Tm_spring';
cvec = [-1:0.1:1]; 
bins = [-1:0.01:1]; yval = 3;
color_handle = @color_corr3; plot_summeravg

% More pronounced than in summer, less than in winter. Good! This is 
% consistent with out interpretation of the land-atm system.

% ======================================================================


% Plotting sig_m
Z = sig_msp;
name = 'sig_m_spring';
cvec = [0:0.5:10]; 
bins = [0:0.1:15]; yval = 0.5;
color_handle = []; plot_summeravg
% ======================================================================

% Plotting sig_T
Z = sig_Tsp;
name = 'sig_T_spring';
cvec = [0:0.5:5];
bins = [0:0.1:8]; yval=1;
color_handle = []; plot_summeravg
% ======================================================================

% Plotting mbar
Z = mspbar;
name = 'mbar_spring';
cvec = [0:5:40]; 
bins = [0:0.5:50]; yval = 0.1;
color_handle = []; plot_summeravg
% ======================================================================

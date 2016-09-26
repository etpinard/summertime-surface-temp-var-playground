%%% Program that computes some selected statistics for winter months
	% DJF in NH and JJA in SH.
  %
	%	Plotting is automated using plot_summeravg.m (yes, a misnomer...)
  %
  % Eventually, you should make some difference plots with the summer
  % only fields.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% Extracting surface air temperature and top-layer soil moisture, 
% trimmed to winter months only ---> using getnewvar with the
% months_only option.
months_only = [-1,1];
if ~exist('Tw');
  [Tw,Twbar,TwTw,sig_Tw] = getnewvar('tas',opt_anom_Var,months_only);
end
if ~exist('mw');
  [mw,mwbar,mwmw,sig_mw] = getnewvar('mrsos',opt_anom_Var,months_only);
end
% ======================================================================

% anything else ...

% Plotting corr(m(i),m(i+1))
if ~exist('Corlag_m_winter');
  disp(['Computing ... Corlag_m_winter']);
  [junk1,Corlag_m_winter] = corr_autolag(mwmw,sig_mw);
end
Z = sqz(Corlag_m_winter(1,:,:));    % lag 1-month
above1 = find(Z > 1); Z(above1) = 1;  % cheeky move for grid boxes > 1
name = 'corlag1_m_winter';
cvec = [-1:0.1:1]; 
bins = [-1:0.01:1]; yval = 3;
color_handle = @color_corr3; plot_summeravg

  % As expected, more pronounced than in summer. But some mid-latitude 
  % regions have still corr's with || < 0.3.

% ======================================================================

% Plotting corr(T,m)
if ~exist('Cor_Tm_winter');
  disp(['Computing ... Cor_Tm_winter']);
  [junk1,Cor_Tm_winter] = corr_inst(TwTw,mwmw,sig_Tw,sig_mw);
end
Z = Cor_Tm_winter;
name = 'cor_Tm_winter';
cvec = [-1:0.1:1]; 
bins = [-1:0.01:1]; yval = 3;
color_handle = @color_corr3; plot_summeravg
  
  % As expected, much weaker than in the summer months

% ======================================================================


% Plotting sig_m
Z = sig_mw;
name = 'sig_m_winter';
cvec = [0:0.5:10]; 
bins = [0:0.1:15]; yval = 0.5;
color_handle = []; plot_summeravg
  
  % An interesting signal too, more variable in continental dry climates

% ======================================================================

% Plotting sig_T
Z = sig_Tw;
name = 'sig_T_winter';
cvec = [0:0.5:5];
bins = [0:0.1:8]; yval=1;
color_handle = []; plot_summeravg

  % An interesting signal, much less at low latitude and west coasts
  % of continents. Higher in some high latitude locations.

% ======================================================================

% Plotting mbar
Z = mwbar;
name = 'mbar_winter';
cvec = [0:5:40]; 
bins = [0:0.5:50]; yval = 0.1;
color_handle = []; plot_summeravg

  % Slightly more moist (less than expected) than in summer

% ======================================================================

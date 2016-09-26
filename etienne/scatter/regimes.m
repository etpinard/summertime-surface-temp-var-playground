%%% Program that seeks to best way to define to the two regimes of
	% evaporation control (refer to correlations patterns in
	% correlations/{control_E,param_E}) using scatter plots over
	% all land grid boxes.
	%
	%	plot_scatter_full.m is used for plotting
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%% corr(E,m) vs. mbbar

X = sqmean(mbbar);													% Nlat X Nlon
[junk,Y] = corr_inst(EE,mm,sig_E,sig_m);		% keep summeravg result
mystats(X)
mystats(Y)

plot_scatter_full(X,Y,[165,2000],[-1,1],[],'cor_Em-mbbar');
% ======================================================================

%% corr(E,F_0) vs. mbbar

X = sqmean(mbbar);														% Nlat X Nlon
[junk,Y] = corr_inst(EE,F0F0,sig_E,sig_F0);		% keep summeravg result
mystats(X)
mystats(Y)

plot_scatter_full(X,Y,[165,2000],[-1,1],[],'cor_EF0-mbbar');
% ======================================================================

%% Would correlations with m_b be any useful?

break

%% corr(E,m) vs. mbar

X = sqmean(mbar);													% Nlat X Nlon
[junk,Y] = corr_inst(EE,mm,sig_E,sig_m);	% keep summeravg result
mystats(X)
mystats(Y)

plot_scatter_full(X,Y,[0,50],[-1,1],[],'cor_Em-mbar');
% ======================================================================

%% corr(E,F_0) vs. mbar

X = sqmean(mbar);														% Nlat X Nlon
[junk,Y] = corr_inst(EE,F0F0,sig_E,sig_F0);	% keep summeravg result
mystats(X)
mystats(Y)

plot_scatter_full(X,Y,[0,50],[-1,1],[],'cor_EF0-mbar');
% ======================================================================

%% corr(E,m) vs. L*sig_E/sig_F

X = sqmean(L*sig_E./sig_F);													% Nlat X Nlon
[junk,Y] = corr_inst(EE,mm,sig_E,sig_m);	% keep summeravg result
mystats(X)
mystats(Y)

plot_scatter_full(X,Y,[0,5],[-1,1],[],'cor_Em-Lsig_Esig_F');
% ======================================================================

%% corr(E,F_0) vs. L*sig_E/sig_F

X = sqmean(L*sig_E./sig_F);													% Nlat X Nlon
[junk,Y] = corr_inst(EE,F0F0,sig_E,sig_F0);	% keep summeravg result
mystats(X)
mystats(Y)

plot_scatter_full(X,Y,[0,5],[-1,1],[],'cor_EF0-Lsig_Esig_F');
% ======================================================================

%% corr(E,m) vs. L*sig_E/sig_F0

X = sqmean(L*sig_E./sig_F0);												% Nlat X Nlon
[junk,Y] = corr_inst(EE,mm,sig_E,sig_m);	% keep summeravg result
mystats(X)
mystats(Y)

plot_scatter_full(X,Y,[0,5.5],[-1,1],[],'cor_Em-Lsig_Esig_F0');
% ======================================================================

%% corr(E,F_0) vs. L*sig_E/sig_F0

X = sqmean(L*sig_E./sig_F0);													% Nlat X Nlon
[junk,Y] = corr_inst(EE,F0F0,sig_E,sig_F0);	% keep summeravg result
mystats(X)
mystats(Y)

plot_scatter_full(X,Y,[0,5.5],[-1,1],[],'cor_EF0-Lsig_Esig_F0');
% ======================================================================

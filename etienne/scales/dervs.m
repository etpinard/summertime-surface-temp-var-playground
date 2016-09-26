%%% Scales analysis of both time derivative terms dU'/dt and dm'/dt
	% 
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

	% specific heat
C_p	= 1e7;
%C_p	= 1e6;
clear scale_min_mag_dTT_*

% use the latent heat flux (L*E) instead of simply E for better
if strcmp(opt_anom_Var,'Var')
	Var_LE = L^2*Var_E;
else
	sig_LE = L*sig_E;
end
% ======================================================================

	% Compute time derivative 
[dTT,imonth] = ddt(TT);
dmm = ddt(m);

	% Compute the time derivative magnitude
%mag_dTT = C_p*sqrt(sqmean(dTT.*dTT));
%mag_dmm = sqrt(sqmean(dmm.*dmm));

mag_dTT = sqrt(sqmean(0.5*TT(imonth,:,:).*dTT));
mag_dmm = sqrt(sqmean(0.5*mm(imonth,:,:).*dmm));
% ======================================================================

Sig_F = sqmean(sig_F);
Sig_LE = sqmean(sig_LE);
Sig_H = sqmean(sig_H);

var_small= {'mag_dTT'};
vars_big = {'Sig_F','Sig_LE','Sig_H'};
Nvar_big = length(vars_big);

compare_min
opt_monthly = 0;
cvec = [0:0.25:4]; color_handle = @color_ltone;
bins = [0:0.01:4.5]; yval = 3.5;	
compare_min_plot
% ======================================================================

Sig_P = sqmean(sig_P);
Sig_E = sqmean(sig_E);
Sig_R = sqmean(sig_R);

var_small= {'mag_dmm'};
vars_big = {'Sig_P','Sig_E','Sig_R'};
Nvar_big = length(vars_big);

compare_min
opt_monthly = 0;
cvec = [0:0.25:4]; color_handle = @color_ltone;
bins = [0:0.01:4.5]; yval = 3.5;	
compare_min_plot
% ======================================================================

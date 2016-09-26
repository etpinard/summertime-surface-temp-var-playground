%%% Program that computes Var(T) and Var(m) from the Toy Model equations
	% of February 6	(with the new parameterization)
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%% February 6, 2013		(New notation + infiltration)
	
%% Relabeling some constants.
	
	% F_0' --> E', P' conversion efficiency (unitless)
lambda = L*e_F.*mbar;

	% evaporation time scale on m' (units: s)
notauE = find(e_m <= 0);			% find e_m < 0 value 
tauE = 1./(e_m.*Fbar);			

	% damping time scale on m' (units: s)
tauH = L./mu;
notauH = find(mu <= 0);			% find mu < 0 

	% effectibe time scale on m' by E' and H' (units: s)
tautilde = 1./(1./tauE - 1./tauH);
tautilde(notauE) = -tauH(notauE);
%tautilde(notauH) = tauE(notauH);		% should I?

	% effective time scale on m' in the moisture budget eq (units: s)
notaurho = find(isnan(taurho));
taus = 1./(1./tauE + 1./taurho);
taus(notauE) = taurho(notauE);
taus(notaurho) = tauE(notaurho);

	% ratio of the time scalce
chi = taus./tautilde;

	%% Maybe I should put the above in startup.m instead.
	%% Wait and see if the definitions change ...
% ======================================================================

%% General plotting options

cvec = [-2:0.25:3]; color_handle = @color_tm3;
bins = [-5:0.1:10]; yval = 1;
% ======================================================================


%% Computing Var(m) from the toy model equations

tm_Var_m = taus.^2.*((1-r).^2.*Var_P + (lambda/L).^2.*Var_F0);

% Plotting the ratio of the toy model Var(m) to the "true" Var(m)
name = 'tm_feb06_m';
%Z = sqrt(tm_Var_m./Var_m);
Z = bias(tm_Var_m,Var_m);
mystats(Z);
plot_summeravg; %plot_all;
% ======================================================================

%% Computing Var(T) from the toy model equations
	
	% evaluate both factors beforehand
chi_F0 = (1 - (1-chi).*lambda);
chi_P = (alpha/L + chi.*(1-r));

tm_Var_T = (1./kappa).^2.*	...
						(chi_F0.^2.*Var_F0 + L^2.*chi_P.^2.*Var_P);

% Plotting the ratio of the toy model Var(T) to the "true" Var(T)
name = 'tm_feb06_T';
%Z = sqrt(tm_Var_T./Var_T);
Z = bias(tm_Var_T,Var_T);
mystats(Z);
plot_summeravg; %plot_all;
% ======================================================================

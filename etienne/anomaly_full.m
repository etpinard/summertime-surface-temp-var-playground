%%% Procedure that computes every parameters needed for the Toy Model.
	% Intended to be ran after startup.m.
	% DO NOT clear variables, this is not function.
	%
	% NEW: opt_anom_var option. If not set, anomaly_full.m runs as
	% before computing sig_X as the anomaly magnitude.
	%
	% (06/24) does not compute H and Rb by default.
% ====================================================================

% Things to improve $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%	
%	-) Make options to not have to compute every anomaly field and 
%		 parameters all the time. As of 02/26, not bad ...
%
% -) Find a way to automate the "Redefining variables" part.
%		 As of 02/26, not bad ...
%
% -) Options for monthly vs. full averaging of parameters. 
%		 Most probably not ...
%
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%% Redefining variables ...

%% Define Fnet, the net radiation forcing at the surface 

if exist('Fsd') && exist('Fsu') && exist('Fld')
	F = Fsd - Fsu + Fld;					% The way Marcia defined it
	clear Fsd Fsu Fld							
end
% ======================================================================

%% Redefine H, as the sum of longwave up and sensitive heat lost

%if exist('Flu') && exist('Hs')
%	H = Flu + Hs;									% as in the Toy Model 
%	%clear Flu Hs
%	%clear Flu 
%end

%% Obsolete as of (06/17).

% ======================================================================

%% Computing m_b (m bottom) and R_b 

if exist('m') && exist('m_f');
	mb = m_f - m;				% soil mositure not included in the top 0.1 m
	clear m_f						% to free up RAM memory (in most situations)
end

%{
if exist('R') && exist('R_f')		% Do I really need this ??
	Rb = R_f - R;				% similarly for runoff
	clear R_f				
end
%}
% ======================================================================

%% Redefing vars 
	
	% renaming vars ...
vars_old = vars;				
	
	% the all vars array
vars_all = {'T', ...				%  2m Temperature
					 	'm', ...        %  0.1m soil moisture content
					 	'mb', ...				%  bottom soil moisture content
					 	'F', ...				%  Net radiation forcing
					 	'P', ...        %  Precip 
					 	'E', ...        %  Evaporation
					 	'Hs', ...				%  Sensible heat flux
						'Flu', ...			%  Surface longwave up
					 	'R', ...        %  0.1m runoff
					 	};

% building the actually vars array 
flag_build = 0;

if strcmp(model_name,'ncep_doe') || strcmp(model_name,'era40')
	flag_build = 1;
elseif exist('opt_vars_load') && ~strcmp(opt_vars_load,'all')
	flag_build = 1;
end

if flag_build
		
	vars = vars_all(1);		% temperature must be in it

	for i=2:length(vars_all)
		var1 = vars_all(i);
		if exist(char(var1)) 
			vars = [vars,var1];
		end
	end

else 

	vars = vars_all;

end

clear var1 flag_build

	% How many variables in the new vars
Nvar = length(vars);
% ======================================================================

%% Computing climatology and anomalies using anomaly.m
 % Note that anomalies values will be referred to as $var$var
 % and standard deviation as sig_$var OR variance as Var_$var
 % e.g mm for anomaly(m) and mean values as $varbar e.g.
 % mbar for m - anomaly(m).

	% first if opt_anom_Var does not exist set to 'no'
if ~exist('opt_anom_Var')
	opt_anom_Var = 'no';
end

for i=1:Nvar;
		
		% allocating 
	eval(['X = ' char(vars(i)) ';']);
	
		% print to screen 
	if strcmp(opt_anom_Var,'Var')

		disp(['Computing ... ',char(vars(i)),'bar, ' ...
					char(vars(i)) char(vars(i)),' and Var_',char(vars(i))]);
	else

		disp(['Computing ... ',char(vars(i)),'bar, ' ...
					char(vars(i)) char(vars(i)),' and sig_',char(vars(i))]);
	end

		% computing with anomaly.m with stand. devs. or variances
	[Xbar,XX,mag_XX] = anomaly(X,opt_anom_Var);	
	
		% copying the variables back
	eval([char(vars(i)) 'bar = Xbar;']);
	eval([char(vars(i)) char(vars(i)) ' = XX;']);

	if strcmp(opt_anom_Var,'Var')
		eval(['Var_' char(vars(i)) '= mag_XX;']);
	else
		eval(['sig_' char(vars(i)) '= mag_XX;']);
	end

end;		

clear X Xbar XX mag_XX
% ======================================================================

%% Decompose FF into two orthogonal forcing functions

if exist('F') && exist('P')
	
	% support for trimmed datasets 
	% e.g. in plot_tm_Var_T_bias_extreme_years.m
	tmp_Nyear = size(P,1)/Nmonth;

	% print to screen and find points where Var_P is 0
	%	(maybe make a tolerence >0 ...)
	if strcmp(opt_anom_Var,'Var')
		disp(['Computing ... alpha, F0F0 and Var_F0']);
		nogood_Px2d = find(xmonth(Var_P,tmp_Nyear)==0);
		nogood_P = find(Var_P==0);
	else
		disp(['Computing ... alpha, F0F0 and sig_F0']);
		nogood_Px2d = find(xmonth(sig_P,tmp_Nyear)==0);
		nogood_P = find(sig_P==0);
	end
	
	% using regrs.m 
	[alpha,F0F0] = regrs(FF,-PP);

	% F0F0 = FF and alpha = 0 , over grid boxes where Var_P is 0
	F0F0(nogood_Px2d) = FF(nogood_Px2d);
	alpha(nogood_P) = 0;
	
	% computing sig_F0 (or Var_F0) using anomaly_sig.m (anomaly_Var.m)
	if strcmp(opt_anom_Var,'Var')
		Var_F0 = anomaly_Var(F0F0);
	else
		sig_F0 = anomaly_sig(F0F0);
	end
	
end

clear tmp_Nyear

	%% recall we defined F' = F_0' - alpha*P'
	%% so that alpha > 0 for most of the world.
% ======================================================================

%% Compute the anomaly budget residuals

if exist('FF') && exist('EE') && exist('HsHs')

	% first the surface energy residual
	if strcmp(opt_anom_Var,'Var')
		disp(['Computing ... xiUxiU and Var_xiU']); 
	else
		disp(['Computing ... xiUxiU and sig_xiU']);
	end

	% (new!) using HsHs and FluFlu
	xiUxiU = FF - L*EE - HsHs - FluFlu;
		
	if strcmp(opt_anom_Var,'Var')
		Var_xiU = anomaly_Var(xiUxiU);
	else
		sig_xiU = anomaly_sig(xiUxiU);
	end

end

if exist('PP') && exist('EE') && exist('RR')

	% second the soil moisture residual
	if strcmp(opt_anom_Var,'Var')
		disp(['Computing ... ximxim and Var_xim']); 
	else
		disp(['Computing ... ximxim and sig_xim']);
	end

	ximxim = PP - EE - RR;
		
	if strcmp(opt_anom_Var,'Var')
		Var_xim = anomaly_Var(ximxim);
	else
		sig_xim = anomaly_sig(ximxim);
	end

end

% ======================================================================

%% 03/11 Old stuff (commented out)
%% Computing kappa by regressing HH to TT
%{
	% print to screen
disp(['Computing ... kappa and H0H0']);

	% using regrs.m
[kappa,H0H0] = regrs(HH,TT);

	%% recall we defined H' = H_0' + kappa*T'
	% kappa > 0 for most of the world
%}
% ======================================================================

%% 02/07: Should I put regrs(E,--) , regrs(H,--) and regrs(R,--) here?

%% Massive changes are comping to the following definitions 
%{

%% Computing toy model parameters

%% Computing e (little "e") 

	%% using m (top 0.1m for now)

% print to screen
disp(['Computing ... e']);

	% little e is simply the ratio
e = Ebar./(mbar.*Fbar);							% Nmonth x Nlat x Nlon

	% or as a function of just (lat,lon)
% e = sqmean(Ebar)./(sqmean(mbar).*sqmean(Fbar))	%% options ... 
% ======================================================================

%% Computing lambda, the fraction of radiation forcing that 
 % warms the near-surface air.

	% does not depend explicitly on soil moisture 

% print to screen
disp(['Computing ... lambda']);

	% lambda = L*e*mbar = L*Ebar/Fbar
lambda = L*Ebar./Fbar;							% Nmonth x Nlat x Nlon
% ======================================================================

%% Computing beta, reciprocal of the fraction E that removes soil
 % moisture. It has the units of L (same as alpha).

% print to screen
disp(['Computing ... beta']);
	
	% does not depend explicitly on soil moisture 

	% beta = 1/(e*mbar) = Fbar/Ebar = L/lambda 
	% (if e is computed with averages)

beta = L./lambda;										 % Nmonth x Nlat x Nlon	
% ======================================================================

%% Computing toy model forcing functions

%% Define an array to keep track of the derived varaibles gam and psi.
vars_derv = {'gam','psi'};

%% Computing gamma, the temperature forcing function

% print to screen
disp(['Computing ... gam']);

	% actually this gamma', 
	% without ambiguity refer to it as gam

	% using xmonth.m
gam = FF.*(1-xmonth(lambda));
% ======================================================================

%% Computing psi, the moisture forcing function

% print to screen
disp(['Computing ... psi']);
	
	% actually this psi', 
	% without ambiguity refer to it as psi

	% before approximations on alpha/beta
tmp = alpha./beta;
tmp = xmonth(tmp);

psi = (1-tmp).*PP - (1./xmonth(beta)).*F0F0;
clear tmp
% ======================================================================

%}

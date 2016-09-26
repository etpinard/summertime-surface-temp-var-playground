function [a,b,xim0xim0,xim00xim00,tau_s] = ...
                                param_smres(ximxim,mm,PP,emFbar)
%
% A function that computes the toy model parameterization of the 
% the soil moisture budget residual (P'-E'-R').
%
% Parameterize xim' as (see bld_m_xim.m) *** FIND better notation!
%
%  xim' = a * m' + b * P'  , [a]=1/s and [b]={}
%
% Combine (e_m Fbar) and (a) to get the m' ajustment time scale
%
%
% INPUT:			  ximxim  , soil moisture budget residual
%               mm      , soil moisture anomalies
%               PP      , precip anomalies
%               emFbar  , (opt.) e_m * Fbar (e_m computed with
%                         param_evapo.m 
%               opt     , option string maybe to the old inflt.m
%                         method.
%
% OUTPUT:				a       , regres. coeff. from proj. onto m'
%               b       , regres. coeff. from proj. onto P'
%               xim0xim0    , residual after the first projection
%               xim00xim00  , residual after 2 the projections 
%               tau_s   , (requires emFbar) m' ajustment time scale
% ======================================================================

  
  % std. output header 
%  disp('Computing ... a (tau_s), b , xim0xim0 , xim00xim00 ');
  

  % first project onto m'  
  [a,xim0xim0] = regrs(ximxim,mm);

  % then project onto P'
  [b,xim00xim00] = regrs(xim0xim0,PP);

  % compute tau_s if emFbar is given
  if nargin==4
  
    den = (a+emFbar);
    den = makenan(den,'==0');   % do not include vanishing den.
    tau_s = 1./den;

  end

  %% *** I could try to restrict a or even tau_s ...

end

%%% keep this ...
%
%function [tau,tau_full,pairs_months] = inflt(mm,Var_m)
%% 
%% Computes the infiltration time scale using the autolag covariance 
%% of top layer soil moisture. 
%%
%% We assume red noise decay 
%%
%%	Cov(m(i),m(j)) = Var(m) exp(DeltaT/tau) and solve for tau.
%%
%% INPUT:	  mm			,	anomalies of m, (Ntime x Nlat x Nlon).
%%						Var_m		, monthly variance of m, (Nmonth x Nlat x Nlon).
%%											maybe make an opt_anom_Var ...
%%
%% NOTE:		This function is fully compatible to model exchanges between
%%					soil layer. Simply, input $1 = mm-mbmb and $2 =
%%					anomaly_Var(mm-mbmb).
%%
%% OUTPUT:		tau					, mean time scale of month 1 to 2 and 2 to 3.
%%						tau_full			, time scale of each month pairs
%%						pairs_months	, month pair array, for reference.
%%
%% ====================================================================
%
%	% load global.mat
%	load('global.mat','Nlat','Nlon','secinday');
%
%	%% Compute the autolag covariance
%	[covlag_m,Covlag_m,pairs_months] = cova_autolag(mm);
%
%	%% Compute the 3 possible time scales from covlag_m
%	tmp_tau = repmat(NaN,[length(pairs_months),Nlat,Nlon]);
%
%	onemonth = 30*secinday;										% 1 month is 30 days
%	Deltat = [onemonth,2*onemonth,onemonth];	% Delta t's
%
%	for i=1:length(pairs_months)
%
%			% allocate at $i 
%		tmp_cov = sqz(covlag_m(i,:,:));
%		tmp_Var = sqz(Var_m(pairs_months(i,1),:,:));
%		
%			% remove negative auto-convariance terms before the log
%		nogood = find(tmp_cov<0);								
%		tmp_cov(nogood) = NaN;
%			
%			% compute denominator 
%		den = log(tmp_Var./tmp_cov);					
%
%		%% NOW keep negative time scale to model exchanges from bottom 
%		%% to top layer.
%			% and remove terms that have cov(i,j) > Var(i) .
%			% yes that's possible and legitimate
%		%nogood = find(den<0);								
%		%den(nogood) = NaN;		% wait are NaNs the best way??
%
%			% and finally tau
%		tmp_tau(i,:,:) = Deltat(i)./den;
%
%	end
%
%	%% outputting
%
%		% full tau array
%	tau_full = tmp_tau;
%
%		% average month 1-2 and 2-3 for tau
%	tau = (sqz(tmp_tau(1,:,:))+sqz(tmp_tau(3,:,:)))/2;
%
%end
%%}

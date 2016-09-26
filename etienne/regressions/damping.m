%%% Seeking the best parameterization for H, the sfc energy damping.
	% Regression with T, m, and P are computed
	% Relative magnitudes of the residuals are compared.
	% 
	%	 Now including the skin temperature.
	%
	% Uses regrs_single.m for computation.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

% Extracting the skin temperature 
if ~exist('TskTsk')
	if strcmp(opt_anom_Var,'Var')
		[junk1,junk2,TskTsk,Var_Tsk] = getnewvar('ts',opt_anom_Var);
	else
		[junk1,junk2,TskTsk,sig_Tsk] = getnewvar('ts',opt_anom_Var);
	end
end

% Also try using the difference
if ~exist('TdifTdif')
	TdifTdif = TskTsk-TT;
	if strcmp(opt_anom_Var,'Var')
		Var_Tdif = anomaly_Var(TdifTdif);
	else
		sig_Tdif = anomaly_sig(TdifTdif);
	end
end

% Selecting the variable to be regressed, var_before
var_before = 'H';		% a string

% Selecting the regressor variables, vars_after
%vars_after = {'T','m','P'};
vars_after = {'T','Tsk','Tdif'};
% ======================================================================

%%% Call regrs_single.m for computations
regrs_single
% ======================================================================

%%% Call regrs_single_plot.m for plotting

opt_monthly = 0;
%cvec = [0:0.2:4]; color_handle = @color_ltone;
%bins = [0:0.1:5]; yval = 1.5;

cvec = [0:0.1:1]; color_handle = [];
bins = [0:0.05:1.5]; yval = 2.5;

regrs_single_plot
% ======================================================================

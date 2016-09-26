%%% Seeking to best parameterization for E. 
	% Also, investigating lagged correlations (possibly important 
	% in the tropical regions).
	% 
	% Uses corr_depind.m for computation.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% Selecting the dependent variable, var_dep
var_dep = 'E';		% a string

% Selecting the set of possible independent variables, vars_ind
%vars_ind = {'F','m','mb','mf','mF','mbF','mfF'};
vars_ind = {'F','F0','m','mb'};
%vars_ind = {'V'};
%vars_ind = {'q'};
vars_ind = {'F'};

%{
% Compute missing anomaly fields.
if ~exist('mFmF') || ~exist('sig_mF');
	disp(['Computing ... mFmF and sig_mF']);
	[junk1,mFmF,sig_mF] = anomaly(m.*F);			
	clear junk1
end
if ~exist('mbFmbF') || ~exist('sig_mbF');
	disp(['Computing ... mbFmbF and sig_mbF']);
	[junk1,mbFmbF,sig_mbF] = anomaly(mb.*F);				
	clear junk1
end
if ~exist('mfFmfF') || ~exist('sig_mfF');
	disp(['Computing ... mfFmfF and sig_mfF']);
	[junk1,mfFmfF,sig_mfF] = anomaly((m+mb).*F);		% in corr_{inst,lag}.m
	clear junk1
end 
%}

% get wind speed (only in hadgem1) --- labeled as V (U is for sfc engy)
if strcmp(model_name,'hadgem1') && ~exist('VV') ... 
	&& isinarray('V',vars_ind)
  [junk1,junk2,VV,sig_V] = getnewvar('Uas',opt_anom_Var); end

% get specific humidity (only in ccsm3) 
if strcmp(model_name,'ccsm3') && ~exist('qq') ...
	&& isinarray('q',vars_ind)
  [junk1,junk2,qq,sig_q] = getnewvar('huss',opt_anom_Var); end
% ======================================================================

%%% Call corr_depind.m for computations
opt_corlag = 0;		% no lagged correlations
%opt_corlag = 1;			% with lagged correlations
corr_depind
% ======================================================================

%%% Call corr_depind_plot.m for plotting
opt_monthly = 0;
opt_overlay = 0;		% yes yes
corr_depind_plot
% ======================================================================

break

%%% Find the places where corr(E,mb) > corr(E,m) or of opposite sign

%notrees = find(Cor_Emb < Cor_Em);
notrees = find(Cor_Emb.*Cor_Em < 0);
tmp = Cor_Emb;
tmp(notrees) = NaN;
Z = tmp;
name = 'cor_Emb-trees';
plot_summeravg;
% ======================================================================

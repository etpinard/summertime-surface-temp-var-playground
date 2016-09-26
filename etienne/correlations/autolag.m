%%% Computing and plotting the auto-correlation of a set of 
	% variables, now including the two budget residuals xiU and xim
	%
	% Uses corr_autolag.m for computation.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


% Selecting the set of variables to auto-correlate, vars_auto
%vars_auto = {'m','mb','T','P','F0','E','H','R'};
vars_auto = {'m','mb','T','P','F0','E','H','R','xiU','xim'};
% ======================================================================

%% Computing the auto-correlations by looping through the set

Nvar_auto = length(vars_auto);

for i=1:Nvar_auto

		% allocating the var_ind index
	var_auto = vars_auto(i);

		% allocating the variable to auto-correlate
	eval(['XX = ' char(var_auto) char(var_auto) ';']);
	eval(['sig_X = sig_' char(var_auto) ';']);

		% computing auto-correlations using corr_autolag.m
	cor_string = ['corlag_'  char(var_auto)];
	Cor_string = ['Corlag_'  char(var_auto)];
	
	if ~exist(cor_string) || ~exist(Cor_string);
		disp(['Computing ... ' cor_string]);
	
		[tmp_cor,tmp_Cor] = corr_autolag(XX,sig_X);

		eval([cor_string '= tmp_cor;']);
		eval([Cor_string '= tmp_Cor;']);

	end

end
% ======================================================================

%% Plotting the results

% Plot summer-averaged auto-correlations 

cvec = [-1:0.1:1]; color_handle = @color_corr3;
bins = [-1:0.01:1]; yval = 3;

for i=1:Nvar_auto			% lagged 1 month
		
		% allocation the var_ind index
	var_auto = vars_auto(i);

	eval(['Z =  Corlag_' char(var_auto) ';']);	
	name = ['corlag1_' char(var_auto)];
	Z = sqz(Z(1,:,:));	

	plot_summeravg			% plot using plot_summeravg.m

end

for i=1:Nvar_auto			% lagged 2 month
		
		% allocation the var_ind index
	var_auto = vars_auto(i);

	eval(['Z =  Corlag_' char(var_auto) ';']);	
	name = ['corlag2_' char(var_auto)];
	z = sqz(Z(2,:,:));	% 2D
	
	plot_summeravg			% plot using plot_summeravg.m

end
% ======================================================================


%% General assessments on memory
%
% P, E, F0 and R have little to no memory 
% m, T and H and some memory
% mb has a lot of memory


% Plot monthly auto-correlations 
	% come up with something better ...

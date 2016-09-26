%%% Procedure which facilitates the computation and the plotting
  % of several correlations simultaneously.
  % 
  % Here, variable looping is based on a dependent (fixed) variable
  % and a set of independent variables. 
  %
  % e.g. To verify if X is linearly related to Y, Z or Y.*Z .
% ======================================================================
%
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%% 
%% Requires: var_dep, vars_ind , opt_corlag
%%   and that the anomaly field (XX) as well as the stand. dev. (sig_X)
%%   of all variables in var_dep or var_ind be defined.
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%% length of vars_ind (Now here!!)
Nvar_ind = length(vars_ind);

%% Allocating the dependent variable (just XX and sig_X are needed)
eval(['XX = ' char(var_dep) char(var_dep) ';']);
eval(['sig_X =  sig_' char(var_dep) ';']);
% ======================================================================

%% Computing correlations by looping through the independent variables

for i=1:Nvar_ind
  
    % allocation the var_ind index
  var_ind = vars_ind(i);

    % allocating (possible) independent variable to correlate with X
  eval(['YY = ' char(var_ind) char(var_ind) ';']);
  eval(['sig_Y =  sig_' char(var_ind) ';']);

    % instantaneous correlations using corr_inst.m
  cor_string = ['cor_' char(var_dep) char(var_ind)];
  Cor_string = ['Cor_' char(var_dep) char(var_ind)];
  
  if ~exist(cor_string) || ~exist(Cor_string);
    disp(['Computing ... ' cor_string ' and ' Cor_string]);
  
    [tmp_cor,tmp_Cor] = corr_inst(XX,YY,sig_X,sig_Y);

    eval([cor_string '= tmp_cor;']);
    eval([Cor_string '= tmp_Cor;']);
  end


    % sometime lagged correlations are not needed
  if opt_corlag

      % lagged correlation with X lagging using corr_lag.m
    cor_string = ['corlag_' char(var_dep) char(var_ind)];
    Cor_string = ['Corlag_' char(var_dep) char(var_ind)];
    
    if ~exist(cor_string) || ~exist(Cor_string);
      disp(['Computing ... ' cor_string ' and ' Cor_string]);

      [tmp_cor,tmp_Cor,pairs_m] = corr_lag(XX,YY,sig_X,sig_Y);

      eval([cor_string '= tmp_cor;']);
      eval([Cor_string '= tmp_Cor;']);
    end
    
      % lagged correlation with Y lagging using corr_lag.m
    cor_string = ['corlag_' char(var_ind) char(var_dep)];
    Cor_string = ['Corlag_' char(var_ind) char(var_dep)];
    
    if ~exist(cor_string) || ~exist(Cor_string);
      disp(['Computing ... ' cor_string ' and ' Cor_string]);

      [tmp_cor,tmp_Cor] = corr_lag(YY,XX,sig_Y,sig_X);

      eval([cor_string '= tmp_cor;']);
      eval([Cor_string '= tmp_Cor;']);
    end

  end

end; clear cor_string Cor_string tmp_cor tmp_Cor XX YY sig_X sig_Y
% ======================================================================

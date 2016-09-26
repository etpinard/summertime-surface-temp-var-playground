% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_scale_engy.m
%
% --> plot_5panels.m <--
%
% Scale analysis of the surface energy budget:
%
% F' = gamma*T' + L*E' + Hs'  (only parameterized for T')
%
% on a 5 panel plot, 1 dataset at a time.
%
% ======================================================================

%%% Plot all data sets or just one
opt_plot_all_datasets = 0;
dataset1 = 'hadgem1';
% ----------------------------------------------------------------------

name = 'scale_engy';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 1;     
units = '[-]';

cvec = [-4,-2,-1.25,-1,-0.8,-0.5,-0.25, ...
        0.0,0.25,0.5,0.8,1,1.25,2,4]; 
opt_x_cvec = 'add_both';
color_handle = @color_scale;

% for plot_5panels
annotate_text = {'gammaT''', ...
  'LE''','<T'',E''>', ...
  'Hs0''','<E'',Hs0''>'};
vars_plot = {'scale_gammaT', ...
  'scale_LE','scale_T_E', ... 
  'scale_Hs0','scale_E_Hs0'};
models_plot = [];
% ----------------------------------------------------------------------

%% Get data and plot it!

% full command to evaluate
full_cmd = [ ...
'gamma = [];' ...
'alpha = [];' ...
'beta = [];' ...
'Var_F = sig_F.^2; Var_T = sig_T.^2;' ...
'Var_E = sig_E.^2; Var_Hs = sig_Hs.^2;' ...
'tm_param_full;' ...
'Var_Hs0 = anomaly_Var(Hs0Hs0);' ...
'Cov_TE = cova_inst(TT,EE);' ...
'Cov_THs0 = cova_inst(TT,Hs0Hs0);' ...
'Cov_EHs0 = cova_inst(EE,Hs0Hs0);' ...
'scale_gammaT = sqmean(gamma.^2.*Var_T./Var_F);' ...
'scale_LE = sqmean(L^2.*Var_E./Var_F);' ...
'scale_Hs0 = sqmean(Var_Hs0./Var_F);' ...
'scale_T_E = sqmean(2*L*gamma.*Cov_TE./Var_F);' ...
'scale_T_Hs0 = sqmean(2*gamma.*Cov_THs0./Var_F);' ...
'scale_E_Hs0 = sqmean(2*L*Cov_EHs0./Var_F);' ...
];

if opt_plot_all_datasets

  % Loop through all the datasets (no computationally efficient)
  vars_req = [];
  models_startup = {'ccsm3','ncep_doe','hadgem1','era40'};
  Nmodel_startup = length(models_startup);

  for i_model=1:Nmodel_startup

    next_model_name = models_startup{i_model};
    startup_other;
    eval(full_cmd);
    plot_5panels;
  
    if strcmp(out_format,'eps')
      out_format = 'png';
      plot_5panels;
      out_format = 'eps';
    end

  end
 
else

  % just $dataset1, optimized with switch_dataset.sh

  % Check if $model_name matches $dataset1
  if ~strcmp(model_name,dataset1)
    
    vars_req = [];
    next_model_name = dataset1;
    startup_other;
    eval(full_cmd);

  else

    % Check if $vars_plot exist, plot with plot_4panels.
    if ~all(ismember(vars_plot,who))  
      eval(full_cmd);
    end

  end

  plot_5panels;
  
  if strcmp(out_format,'eps')
    out_format = 'png';
    plot_5panels;
    out_format = 'eps';
  end

end
% ----------------------------------------------------------------------

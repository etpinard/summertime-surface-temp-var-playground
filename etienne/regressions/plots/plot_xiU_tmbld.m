% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_xiU_tmbld.m
%
% --> plot_2panels.m <--
%
% Toy model calibration errors on Var(T)
% after the 'building' of the xiU' parameterization 
%
% - with T and F'
% 
% on a 2 panel plot, 1 dataset at a time.
%
% ======================================================================

%%% Plot all data sets or just one
opt_plot_all_datasets = 0;
dataset1 = 'hadgem1';
% ----------------------------------------------------------------------

%%% Choose metric: calibration ratio or calibration RMS
name = 'xiU_tmbld';
name = 'xiU_tmbld_rms';
% ----------------------------------------------------------------------

out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;     

opt_x_cvec = 'above';
if strcmp(name,'xiU_tmbld')
  cvec = [0,0.25,0.5,0.8,0.9,1,1.1,1.25,2,4];   
  color_handle = @color_relerror;
  units = '[-]';
else
  cvec = [0:0.05:0.35];   
  color_handle = @color_Var;
  units = '[-]';
end

% for plot_2panels
vars_plot = { ...
  'tmbld_xiU_F','tmbld_xiU_T'};
models_plot = [];
annotate_text = { ...
  'with F''','with T'''};
% ----------------------------------------------------------------------

%% Get data and plot it!

% computation command
regrs_cmd = [ ...
'[a_F,tmp1] = regrs(xiUxiU,FF);' ...
]; % tmbld_xiU_T will use 'tm_param_full' params 

% error commands
cmd_err_F = [ ...
'x = xmonth(1./(gamma_lw)).*(FF' ...
'- L*EE - HsHs' ...
'- xmonth(a_F).*FF' ...
'- Flu0Flu0);' ...
];

cmd_err_T = [ ...
'x = xmonth(1./(gamma_lw+gamma_G)).*(FF' ...
'- L*EE - HsHs' ...
'- Flu0Flu0);' ...
];

% full command to evaluate
if strcmp(name,'xiU_tmbld')
full_cmd = [ ...
  'gamma = [];' ...
  'beta = [];' ...
  'alpha = [];' ...
  'tm_param_full;' ...
  ,regrs_cmd, ...
  cmd_err_F, ...
  'tmbld_xiU_F = sqmean(anomaly_Var(x)./Var_T);' ...
  ,cmd_err_T, ...
  'tmbld_xiU_T = sqmean(anomaly_Var(x)./Var_T);' ...
];
else
full_cmd = [ ...
  'gamma = [];' ...
  'beta = [];' ...
  'alpha = [];' ...
  'tm_param_full;' ...
  ,regrs_cmd, ...
  cmd_err_F, ...
  'den = sqrt(sqmean(Var_T));' ...
  'tmbld_xiU_F = rms(x,TT)./den;' ...
  ,cmd_err_T, ...
  'tmbld_xiU_T = rms(x,TT)./den;' ...
];
end

if opt_plot_all_datasets

  % Loop through all the datasets (no computationally efficient)
  vars_req = [];
  models_startup = {'ccsm3','ncep_doe','hadgem1','era40'};
  Nmodel_startup = length(models_startup);

  for i_model=1:Nmodel_startup

    next_model_name = models_startup{i_model};
    startup_other;
    eval(full_cmd);
    plot_2panels;
  
    if strcmp(out_format,'eps')
      out_format = 'png';
      plot_2panels;
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

  plot_2panels;
  
  if strcmp(out_format,'eps')
    out_format = 'png';
    plot_2panels;
    out_format = 'eps';
  end

end
% ----------------------------------------------------------------------

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_R_tmbld.m
%
% --> plot_2panels.m <--
%
% Toy model calibration errors on Var(m)
% after the 'building' of the R' parameterization 
%
% - with P' and m'
% 
% on a 2 panel plot, 1 dataset at a time.
%
% ======================================================================

%%% Plot all data sets or just one
opt_plot_all_datasets = 0;
dataset1 = 'hadgem1';
% ----------------------------------------------------------------------

%%% Choose metric: calibration ratio or calibration RMS
%name = 'R_tmbld';
name = 'R_tmbld_rms';
% ----------------------------------------------------------------------

out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;     

opt_x_cvec = 'above';
if strcmp(name,'R_tmbld')
  cvec = [0,0.25,0.5,0.8,0.9,1,1.1,1.25,2,4];   
  color_handle = @color_relerror;
  units = '[-]';
else
  cvec = [0:0.05:0.35];   
  color_handle = @color_Var;
  units = '[-]';
end

% for plot_4panels
vars_plot = { ...
  'tmbld_R_m','tmbld_R_P'};
models_plot = [];
annotate_text = { ...
  'with m''','with P'''};
% ----------------------------------------------------------------------

%% Get data and plot it!

% computation command
regrs_cmd = [ ...
'[a_m,tmp1] = regrs(RR,mm);' ...
]; % tmbld_R_P will use 'tm_param_full' params 

% error commands
cmd_err_m = [ ...
'y = xmonth(1./(nu_s+a_m)).*(PP' ...
'- xmonth(lambda/L).*F0F0' ...
'- xmonth(beta_I).*PP' ...
'- E00E00 - xim00xim00);' ...
];

cmd_err_P = [ ...
'y = xmonth(1./nu_s).*(PP' ...
'- xmonth(lambda/L).*FF' ...
'- xmonth(beta_R).*PP - xmonth(beta_I).*PP' ...
'- E00E00 - xim00xim00);' ...
];

% full command to evaluate
if strcmp(name,'R_tmbld')
full_cmd = [ ...
  'gamma = [];' ...
  'beta = [];' ...
  'alpha = [];' ...
  'tm_param_full;' ...
  ,regrs_cmd, ...
  cmd_err_P, ...
  'tmbld_R_P = sqmean(anomaly_Var(y)./Var_m);' ...
  ,cmd_err_m, ...
  'tmbld_R_m = sqmean(anomaly_Var(y)./Var_m);' ...
];
else
full_cmd = [ ...
  'gamma = [];' ...
  'beta = [];' ...
  'alpha = [];' ...
  'tm_param_full;' ...
  ,regrs_cmd, ...
  cmd_err_P, ...
  'den = sqrt(sqmean(Var_m));' ...
  'tmbld_R_P = rms(y,mm)./den;' ...
  ,cmd_err_m, ...
  'tmbld_R_m = rms(y,mm)./den;' ...
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

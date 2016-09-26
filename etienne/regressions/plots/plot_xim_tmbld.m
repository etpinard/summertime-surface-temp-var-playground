% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_xim_tmbld.m
%
% --> plot_2panels.m <--
%
% Toy model calibration errors on Var(m)
% after the 'building' of the xim' parameterization 
%
% - with (m',P') , (P',m') 
% 
% on a 2 panel plot, 1 dataset at a time.
%
% ======================================================================

%%% Plot all data sets or just one
opt_plot_all_datasets = 0;
dataset1 = 'hadgem1';
% ----------------------------------------------------------------------

%%% Choose metric: calibration ratio or calibration RMS
%name = 'xim_tmbld';
name = 'xim_tmbld_rms';
% ----------------------------------------------------------------------

out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;     

opt_x_cvec = 'above';
if strcmp(name,'xim_tmbld')
  cvec = [0,0.25,0.5,0.8,0.9,1,1.1,1.25,2,4];   
  color_handle = @color_relerror;
  units = '[-]';
else
  cvec = [0:0.2:1.4];   
  color_handle = @color_Var;
  units = '[-]';
end

% for plot_2panels
vars_plot = { ...
  'tmbld_xim_mP','tmbld_xim_Pm'};
models_plot = [];
annotate_text = { ...
  'with m'' then P''','with P'' then m'''};
% ----------------------------------------------------------------------

%% Get data and plot it!

% computation command
regrs_cmd = [ ...
'[a_P,tmp1] = regrs(ximxim,PP);' ...
'b_Pm = regrs(tmp1,mm);' ...
]; % tmbld_xim_mP will use 'tm_param_full' params 

% error commands
cmd_err_in_mP = [ ...
'y = xmonth(1./nu_s).*(PP' ...
'- xmonth(lambda/L).*FF' ...
'- RR - xmonth(beta_I).*PP' ...
'- E00E00 );' ...
];

cmd_err_in_Pm = [ ...
'y = xmonth(1./(nu_E+b_Pm)).*(PP' ...
'- xmonth(lambda/L).*FF' ...
'- RR - xmonth(a_P).*PP' ...
'- E00E00 );' ...
];

% full command to evaluate
if strcmp(name,'xim_tmbld')
full_cmd = [ ...
  'gamma = [];' ...
  'beta = [];' ...
  'alpha = [];' ...
  'tm_param_full;' ...
  ,regrs_cmd, ...
   cmd_err_in_mP, ...
  'tmbld_xim_mP = sqmean(anomaly_Var(y)./Var_m);' ...
  ,cmd_err_in_Pm, ...
  'tmbld_xim_Pm = sqmean(anomaly_Var(y)./Var_m);' ...
];
else
full_cmd = [ ...
  'gamma = [];' ...
  'beta = [];' ...
  'alpha = [];' ...
  'tm_param_full;' ...
  ,regrs_cmd, ...
   cmd_err_in_mP, ...
  'den = sqrt(sqmean(Var_m));' ...
  'tmbld_xim_mP = rms(y,mm)./den;' ...
  ,cmd_err_in_Pm, ...
  'tmbld_xim_Pm = rms(y,mm)./den;' ...
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

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_E_tmbld.m
%
% --> plot_2panels.m <--
%
% Toy model calibration errors on Var(T) and Var(m)
% after the 'building' of the E' parameterization 
%
% - on Var(T) and Var(m)
% 
% on a 4 panel plot, 1 dataset at a time.
%
% ======================================================================

%%% Plot all data sets or just one
opt_plot_all_datasets = 0;
dataset1 = 'hadgem1';
% ----------------------------------------------------------------------

%%% Choose metric: calibration ratio or calibration RMS
name = 'E_tmbld';
%name = 'E_tmbld_rms';
% ----------------------------------------------------------------------

out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;     

opt_x_cvec = 'above';
if strcmp(name,'Hs_tmbld')
  cvec = [0,0.25,0.5,0.8,0.9,1,1.1,1.25,2,4];   
  color_handle = @color_relerror;
  units = '[-]';
else
  cvec = [0:0.2:1.4];   
  color_handle = @color_Var;
  units = '[-]';
end

% for plot_4panels
vars_plot = { ...
  'tmbld_E_in_T','tmbld_E_in_m'};
models_plot = [];
annotate_text = { ...
  'T'' eq.','m'' eq.'};
% ----------------------------------------------------------------------

%% Get data and plot it!

% error commands
cmd_err_in_T = [ ...
'x = xmonth(1./gamma).*(FF' ...
'- L*(xmonth(nu_E).*mm+xmonth(lambda/L).*FF)' ...
'- xmonth(-L*nu_Hs).*mm' ...
'- Hs00Hs00 - xiU0xiU0 - Flu0Flu0);' ...
];
cmd_err_in_T = [ ...
'x = xmonth(1./(gamma_lw)).*(FF' ...
'- L*(xmonth(nu_E).*mm+xmonth(lambda/L).*FF)' ...
'- HsHs - xiUxiU' ... 
'- Flu0Flu0);' ...
];

cmd_err_in_m = [ ...
'y = xmonth(1./nu_s).*(PP' ...
'- xmonth(lambda/L).*FF' ...
'- RR' ...
'- xmonth(beta_I).*PP - xim00xim00);' ...
];
%cmd_err_in_m = [ ...   
%'y = xmonth(1./nu_E).*(PP' ...
%'- xmonth(lambda/L).*FF' ...
%'- RR' ...
%'- ximxim);' ...
%]; % blows up!

% full command to evaluate
if strcmp(name,'E_tmbld')
full_cmd = [ ...
  'gamma = [];' ...
  'beta = [];' ...
  'alpha = [];' ...
  'tm_param_full;' ...
   cmd_err_in_T, ...
  'tmbld_E_in_T = sqmean(anomaly_Var(x)./Var_T);' ...
  ,cmd_err_in_m, ...
  'tmbld_E_in_m = sqmean(anomaly_Var(y)./Var_m);' ...
];
else
full_cmd = [ ...
  'gamma = [];' ...
  'beta = [];' ...
  'alpha = [];' ...
  'tm_param_full;' ...
   cmd_err_in_T, ...
  'Den = sqrt(sqmean(Var_T));' ...
  'tmbld_E_in_T = rms(x,TT)./Den;' ...
  ,cmd_err_in_m, ...
  'tmbld_E_in_m = rms(x,TT)./Den;' ...
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
  
end
% ----------------------------------------------------------------------

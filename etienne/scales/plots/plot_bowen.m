% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_bowen.m
%
% --> plot_2panels.m <--
%
% Comparison of the summer mean Bowen ratio and anomaly Bowen ratio
% 
% on a 2 panel plot, 1 dataset at a time.
%
% ======================================================================

%%% Plot all data sets or just one
opt_plot_all_datasets = 1;
dataset1 = 'hadgem1';
% ----------------------------------------------------------------------

name = 'bowen';
out_format = 'png';
out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;     
units = '[-]';

cvec = [0.0,0.1,0.25,0.5,0.8,1,1.25,2,4,10];   
opt_x_cvec = 'add_above';
color_handle = @color_scale;

% for plot_2panels
vars_plot = { ...
  'bowen_mean','bowen_anom'};
models_plot = [];
annotate_text = { ...
  'mean','anom.'};
% ----------------------------------------------------------------------

%% Get data and plot it!

% full command to evaluate
full_cmd = [ ...
  'bowen_mean = sqmean(abs(Hsbar./(L*Ebar)));' ...
  'bowen_anom = sqmean(abs(sig_Hs.^2./(L^2*sig_E.^2)));' ...
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

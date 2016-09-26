% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_corr_land_atm.m
%
% --> plot_6panels.m <--
%
% Summary of summertime correlation of land-atmosphere interaction,
% 1 dataset at a time.
%
% ======================================================================

%%% Plot all data sets or just one
opt_plot_all_datasets = 0;
dataset1 = 'hadgem1';
% ----------------------------------------------------------------------

name = 'Cor_land_atm';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 2;     
units = '[-]';

cvec = [-1:0.2:1];
opt_x_cvec = [];
color_handle = @color_corr;

% for plot_6panels
vars_plot = { ...
  'Cor_TF','Cor_Tm', ...
  'Cor_EF','Cor_Em', ...
  'Cor_HsF','Cor_Hsm'};
models_plot = [];
annotate_text = { ...
  'corr(T,F)','corr(T,m)', ...
  'corr(E,F)','corr(E,m)', ...
  'corr(Hs,F)','corr(Hs,m)'};
% ----------------------------------------------------------------------

%% Get data and plot it!

% computation command
opt_corlag = 0;
vars_ind = {'F','m'};
corr_cmd = [ ...
  'var_dep = ''T'';' ...
  'corr_depind;' ...
  'var_dep = ''E'';' ...
  'corr_depind;' ...
  'var_dep = ''Hs'';' ...
  'corr_depind;' ...
];

if opt_plot_all_datasets

  % Loop through all the datasets (no computationally efficient)
  vars_req = [];
  models_startup = {'ccsm3','ncep_doe','hadgem1','era40'};
  Nmodel_startup = length(models_startup);

  for i_model=1:Nmodel_startup

    next_model_name = models_startup{i_model};
    startup_other;
    clear Cor_*
    eval(corr_cmd);
    plot_6panels;

  end
 
else

  % just $dataset1, optimized with switch_dataset.sh

  % Check if $model_name matches $dataset1
  if ~strcmp(model_name,dataset1)
    
    vars_req = [];
    next_model_name = dataset1;
    startup_other;
    eval(corr_cmd);

  else

    % Check if $vars_plot exist, plot with plot_6panels.
    if ~all(ismember(vars_plot,who))  
      eval(corr_cmd);
    end

  end

  plot_6panels;
  
end
% ----------------------------------------------------------------------

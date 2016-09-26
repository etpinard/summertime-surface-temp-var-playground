% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_E_regrs2.m
%
% --> plot_2panels.m <--
%
% Evaluation of regression performance for E'.
%
% - with (m',F'),(F',m')
% 
% on a 2 panel plot, 1 dataset at a time.
%
% Performance is quantified with the 'fraction of variance explained'
% using `Var_expl.m'.
%
% ======================================================================

%%% Plot all data sets or just one
opt_plot_all_datasets = 0;
dataset1 = 'hadgem1';
% ----------------------------------------------------------------------

name = 'E_regrs2';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;     
units = '[-]';

%cvec = [0:0.1:1];
%cvec = [0,0.4:0.1:1];
cvec = [0,0.3:0.1:1];
opt_x_cvec = [];
color_handle = @color_Var_expl;

% for plot_2panels
vars_plot = { ...
  'Res_E_mF','Res_E_Fm'};
models_plot = [];
annotate_text = { ...
  'with m '' then F''','with F'' then m'''};
% ----------------------------------------------------------------------

%% Get data and plot it!

% computation command
regrs_cmd = [ ...
 '[j1,tmp] = regrs(EE,mm);' ...
 '[j1,tmp] = regrs(tmp,FF);' ...
 'Res_E_mF = Var_expl(tmp,Var_E);' ...
 '[j1,tmp] = regrs(EE,FF);' ...
 '[j1,tmp] = regrs(tmp,FF);' ...
 'Res_E_Fm = Var_expl(tmp,Var_E);' ...
];

if opt_plot_all_datasets

  % Loop through all the datasets (no computationally efficient)
  vars_req = [];
  models_startup = {'ccsm3','ncep_doe','hadgem1','era40'};
  Nmodel_startup = length(models_startup);

  for i_model=1:Nmodel_startup

    next_model_name = models_startup{i_model};
    startup_other;
    eval(regrs_cmd);
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
    eval(regrs_cmd);

  else

    % Check if $vars_plot exist, plot with plot_4panels.
    if ~all(ismember(vars_plot,who))  
      eval(regrs_cmd);
    end

  end

  plot_2panels;
  
end
% ----------------------------------------------------------------------

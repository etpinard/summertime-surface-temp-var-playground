% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_xim_regrs.m
%
% --> plot_4panels.m <--
%
% Evaluation of regression performance for xim'.
%
% - with m',T',P','F'
% 
% on a 4 panel plot, 1 dataset at a time.
%
% Performance is quantified with the 'fraction of variance explained'
% using `Var_expl.m'.
%
% ======================================================================

%%% Plot all data sets or just one
opt_plot_all_datasets = 0;
dataset1 = 'hadgem1';
% ----------------------------------------------------------------------

name = 'xim_regrs';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;     
units = '[-]';

cvec = [0,0.3:0.1:1];
opt_x_cvec = [];
color_handle = @color_Var_expl;

% for plot_4panels
vars_plot = { ...
  'Res_xim_T','Res_xim_F', ... 
  'Res_xim_m','Res_xim_P'};
models_plot = [];
annotate_text = { ...
  'with T''','with F''', ...
  'with m''','with P'''};
% ----------------------------------------------------------------------

%% Get data and plot it!

% computation command
regrs_cmd = [ ...
 '[j1,tmp] = regrs(ximxim,mm);' ...
 'Res_xim_m = Var_expl(tmp,Var_xim);' ...
 '[j1,tmp] = regrs(ximxim,PP);' ...
 'Res_xim_P = Var_expl(tmp,Var_xim);' ...
 '[j1,tmp] = regrs(ximxim,FF);' ...
 'Res_xim_F = Var_expl(tmp,Var_xim);' ...
 '[j1,tmp] = regrs(ximxim,TT);' ...
 'Res_xim_T = Var_expl(tmp,Var_xim);' ...
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
    plot_4panels;
  
    if strcmp(out_format,'eps')
      out_format = 'png';
      plot_4panels;
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

  plot_4panels;
  
  if strcmp(out_format,'eps')
    out_format = 'png';
    plot_4panels;
    out_format = 'eps';
  end

end
% ----------------------------------------------------------------------

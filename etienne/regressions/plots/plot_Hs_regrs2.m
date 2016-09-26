% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_Hs_regrs2.m
%
% --> plot_4panels.m <--
%
% Evaluation of regression performance for Hs'.
%
% - with (m',F') , (F',m') , (m',T') , (T',m')
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

name = 'Hs_regrs2';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;     
units = '[-]';

%cvec = [0:0.1:1];
%cvec = [0,0.4:0.1:1];
cvec = [0,0.3:0.1:1];
opt_x_cvec = [];
color_handle = @color_Var_expl;

% for plot_4panels
vars_plot = { ...
  'Res_Hs_mF','Res_Hs_Fm', ... 
  'Res_Hs_mT','Res_Hs_Tm'};
models_plot = [];
annotate_text = { ...
  'with m'' then F''','with F'' then m''', ...
  'with m'' then T''','with T'' then m'''};
% ----------------------------------------------------------------------

%% Get data and plot it!

% computation command
regrs_cmd = [ ...
 '[j1,tmp1] = regrs(HsHs,mm);' ...
 '[j1,tmp2] = regrs(tmp1,FF);' ...
 'Res_Hs_mF = Var_expl(tmp2,Var_Hs);' ...
 '[j1,tmp2] = regrs(tmp1,TT);' ...
 'Res_Hs_mT = Var_expl(tmp2,Var_Hs);' ...
 '[j1,tmp] = regrs(HsHs,FF);' ...
 '[j1,tmp] = regrs(tmp,mm);' ...
 'Res_Hs_Fm = Var_expl(tmp,Var_Hs);' ...
 '[j1,tmp] = regrs(HsHs,TT);' ...
 '[j1,tmp] = regrs(tmp,mm);' ...
 'Res_Hs_Tm = Var_expl(tmp,Var_Hs);' ...
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
  
end
% ----------------------------------------------------------------------

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_pres.m
%
% --> various <--
%
% Miscellenous presentation-only plots.
%
% ======================================================================

%% for all plots

dataset1 = 'hadgem1';
out_format = 'eps';
opt_frame_col = 0;
% ----------------------------------------------------------------------

% -) hadgem1_Res_E_m_F (3 panel)

name = 'Res_E_m_F';
units = '[-]';

cvec = [0,0.3:0.1:1];
opt_x_cvec = [];
color_handle = @color_Var_expl;

full_cmd = [ ...
 'beta = [];' ...  % variables, not functions
 'gamma = [];' ...
 'alpha = [];' ...
 '[j1,tmp] = regrs(EE,mm);' ...
 'Res_E_m = Var_expl(tmp,Var_E);' ...
 '[j1,tmp] = regrs(EE,FF);' ...
 'Res_E_F = Var_expl(tmp,Var_E);' ...
 'tm_param_full;' ...
 'Res_E = Var_expl(E00E00,Var_E);' ...
];

vars_plot = {'Res_E_m','Res_E_F','Res_E'};
models_plot = [];
annotate_text = {'with m''','with F''','toy model'};

if ~strcmp(model_name,dataset1) % Check if $model_name matches $dataset1
  vars_req = [];
  next_model_name = dataset1;
  startup_other;
  eval(full_cmd);
else
  if ~all(ismember(vars_plot,who))  % Check if $vars_plot exist
    eval(full_cmd);
  end
  plot_3panels;
end
% ----------------------------------------------------------------------

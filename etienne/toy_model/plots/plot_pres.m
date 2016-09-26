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


break

% -) hadgem1_scale_F0_P_T (1 panel)

name = 'scale_F0_P_T';
units = '[-]';

cvec=[0,0.1,0.25,0.5,0.8,1,1.25,2,4,10]; 
opt_x_cvec='above';
color_handle = @color_scale;

full_cmd = [ ...
'beta = [];' ...  % variables, not functions
'gamma = [];' ...
'alpha = [];' ...
'tm_param_full;' ...
'fact_F0 = (1-lambda.*(1-chi));' ...
'fact_P = alpha.*(1-lambda)+chi.*(1+alpha.*lambda-beta);' ...
'scale_F0_P = fact_F0.^2.*Var_F0./(L^2*fact_P.^2.*Var_P);' ...
];

vars_plot = {'scale_F0_P'};

if ~strcmp(model_name,dataset1) % Check if $model_name matches $dataset1
  vars_req = [];
  next_model_name = dataset1;
  startup_other;
  eval(full_cmd);
else
  if ~all(ismember(vars_plot,who))  % Check if $vars_plot exist
    eval(full_cmd);
  end
  plot_map_miller2( ...
    lon,lat,sqmean(scale_F0_P), ...
    cvec,opt_x_cvec,[name,'.',out_format],color_handle,units);
end
% ----------------------------------------------------------------------

break

% -) hadgem1_fact_F0_P (2 panels)

name = 'fact_F0_P';
opt_overlay = 2;
units = '[-]';

cvec = [0:0.2:1]; 
opt_x_cvec = 'add_both';
color_handle = @color_myhot;

full_cmd = [ ...
'beta = [];' ...  % variables, not functions
'gamma = [];' ...
'alpha = [];' ...
'tm_param_full;' ...
'fact_F0 = (1-lambda.*(1-chi));' ...
'fact_P = alpha.*(1-lambda)+chi.*(1+alpha.*lambda-beta);' ...
];

annotate_text = {'c_{F0}','c_P'};
vars_plot = {'fact_F0','fact_P'};
models_plot = [];
  
if ~strcmp(model_name,dataset1) % Check if $model_name matches $dataset1
  vars_req = [];
  next_model_name = dataset1;
  startup_other;
  eval(full_cmd);
else
  if ~all(ismember(vars_plot,who))  % Check if $vars_plot exist
    eval(full_cmd);
  end
  plot_2panels;
end
% ----------------------------------------------------------------------



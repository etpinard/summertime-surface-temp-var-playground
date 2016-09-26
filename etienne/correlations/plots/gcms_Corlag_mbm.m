% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_Corlag_mbm.m
%
% --> plot_2panels.m <-- 
%
% Lagged correlation m_bottom(i) with m(i+1) 
%
% to evaluate upward exchanges of moisture between the bottom and
% surface soil layers.
%
% ======================================================================

% plot_2panels required fields, for all plots!

name = 'gcms_Corlag_mbm';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;
units = '[-]';

cvec = [-1:0.2:1];
opt_x_cvec = 'none';
color_handle = @color_corr;

% for startup_other
vars_req = {'lon','lat','Corlag_mbm'};
models_startup = {'ccsm3','hadgem1'};
comp_cmd = [ ...
  '[j1,Corlag_mbm] = corr_lag(mbmb,mm,sig_mb,sig_m,''sqz1'');' ...
];

% for plot_2panels
vars_plot = {'Corlag_mbm,','Corlag_mbm'};
models_plot = {'ccsm3','hadgem1'};
annotate_text = {'CCSM3.0','HadGEM1'};
% ----------------------------------------------------------------------

%% Get data

% Call startup_other.m to get the (2) gcm datasets 
Nvar_req = length(vars_req);
Nmodel_startup = length(models_startup);

for i_model=1:Nmodel_startup

  % model to load, relabel variables
  i_model_name = char(models_startup(i_model));
  vars_req_str = relabel(vars_req,i_model_name);
  
  % if not all variable in $vars_req exist 
  if ~all(ismember(vars_req_str,who));

    % if $model_name is not loaded, call startup_other
    if ~strcmp(i_model_name,model_name)
      next_model_name = i_model_name;
      startup_other;
    end

    % evaluate `comp_cmd'
    eval(comp_cmd);

    % if last i_model, one more round of relabeling
    if i_model==Nmodel_startup
      for i=1:Nvar_req
        var_req = char(vars_req(i));
        disp(['Relabeling ... ',var_req, ...
              ' --> ',model_name,'_',var_req,';']); 
        cmd=[model_name,'_',var_req,'=',var_req,';'];
        eval(cmd);
      end
    end

  end
end
% ----------------------------------------------------------------------

% ----------------------------------------------------------------------

%% Call plot_2_panels.m
plot_2panels;
% ----------------------------------------------------------------------

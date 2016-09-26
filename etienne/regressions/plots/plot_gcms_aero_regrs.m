% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_gcms_aero_regrs
%
% --> plot_4panels.m <--
%
% Fraction of variance by a projection onto m' for the drag coeff C
% and DelatT (where Hs = C*DeltaT)
%
% Shows only GCMs results. (Tsk is not defined in the era40 and
% ncep is straight up bad).
%
% ======================================================================

name = 'gcms_aero_regrs';
out_format = 'both';
opt_overlay = 0;
opt_frame_col = 0;

cvec = [0,0.3:0.1:1];
opt_x_cvec = [];
color_handle = @color_Var_expl;
units = '[-]';

% for startup_other
vars_req = {'lon','lat','Res_C_m','Res_DeltaT_m'}; 
models_startup = {'ccsm3','hadgem1'};

% regression command
regrs_cmd = [ ...
'Tsk = getnewvar(''ts'');' ...
'DeltaT = Tsk-T;' ...
'[j1,DeltaTDeltaT,Var_DeltaT] = anomaly(DeltaT,opt_anom_Var);' ...
'[j1,tmp] = regrs(DeltaTDeltaT,mm);' ...
'Res_DeltaT_m = Var_expl(tmp,Var_DeltaT);' ...
'den = makenan(DeltaT,''==0'');' ...
'C = Hs./den;' ...
'[j1,CC,Var_C] = anomaly(C,opt_anom_Var);' ...
'[j1,tmp] = regrs(CC,mm);' ...
'Res_C_m = Var_expl(tmp,Var_C);' ...
]; 

% for plot_4panels
vars_plot = { ...
  'Res_C_m','Res_DeltaT_m', ...
  'Res_C_m','Res_DeltaT_m'};
models_plot = { ...
  'ccsm3','ccsm3', ...
  'hadgem1','hadgem1'};
annotate_text = { ...
  'CCSM3.0-C','CCSM3.0-(Tsk-T)', ...
  'HadGEM1-C','HadGEM1-(Tsk-T)'};
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

    % evaluate `regrs_cmd'
    eval(regrs_cmd);

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

%% Call plot_4panels.m
plot_4panels;
% ----------------------------------------------------------------------

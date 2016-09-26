% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_gcms_Hs_regrs_gain_E_Delta
%
% --> plot_4panels.m <--
%
% Performance gain by E' and (Tsk-T)' wrt the m' regression.
%
% Performance is quantified by the 'fraction of variance explained'.
%
% Shows only GCMs results. (Tsk is not defined in the era40 and
% ncep is straight up bad).
%
% ======================================================================

out_format = 'both';
opt_overlay = 0;
opt_frame_col = 0;

cvec = [-0.4:0.1:0.4];
opt_x_cvec = '[]';
color_handle = @color_corr;
units = '[-]';

% for startup_other
vars_req = {'lon','lat','Res_Hs_gain_E','Res_Hs_gain_DeltaT'}; 
models_startup = {'ccsm3','hadgem1'};

% regression command
regrs_cmd = [ ...
'Tsk = getnewvar(''ts'');' ...
'DeltaT = Tsk-T;' ...
'[j1,DeltaTDeltaT,j2] = anomaly(DeltaT,opt_anom_Var);' ...
'[j1,tmp] = regrs(HsHs,mm);' ...
'Res_Hs_m = Var_expl(tmp,Var_Hs);' ...
'[j1,tmp] = regrs(HsHs,EE);' ...
'Res_Hs_E = Var_expl(tmp,Var_Hs);' ...
'[j1,tmp] = regrs(HsHs,DeltaTDeltaT);' ...
'Res_Hs_DeltaT = Var_expl(tmp,Var_Hs);' ...
'Res_Hs_gain_E = Res_Hs_E - Res_Hs_m;' ...
'Res_Hs_gain_DeltaT = Res_Hs_DeltaT - Res_Hs_m;' ...
]; 
%'DeltaT = makenan(DeltaT,''==0'');' ...
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

%% Call plot_comp_datasets for 'Res_Hs_gain_E'
vars_req = {'lon','lat','Res_Hs_gain_E'}; 
comp_cmd = [ ...
'[j1,tmp] = regrs(HsHs,mm);' ...
'Res_Hs_m = Var_expl(tmp,Var_Hs);' ...
'[j1,tmp] = regrs(HsHs,EE);' ...
'Res_Hs_E = Var_expl(tmp,Var_Hs);' ...
'Res_Hs_DeltaT = Var_expl(tmp,Var_Hs);' ...
'Res_Hs_gain_E = Res_Hs_E - Res_Hs_m;' ...
]; 
opt_overlay = 2;
plot_comp_datasets;
% ----------------------------------------------------------------------

%% Call plot_2panels for 'Res_Hs_gain_DeltaT'
name = 'gcms_Hs_regrs_gain_DeltaT';
vars_plot = {'Res_Hs_gain_DeltaT','Res_Hs_gain_DeltaT'}
models_plot = {'ccsm3','hadgem1'};
annotate_text = {'CCSM3.0','HadGEM1'};
opt_overlay = 0;
plot_2panels;
% ----------------------------------------------------------------------

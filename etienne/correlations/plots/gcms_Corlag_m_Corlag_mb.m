% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_corr_auto.m
%
% --> plot_4panels.m <-- ( or plot_6panels)
%
% Summertime moisture autocorrelations in both gcms
%
% ======================================================================

% plot_4panels required fields, for all plots!

name = 'gcms_Corlag_m_Corlag_mb';
name = 'gcms_Corlag_m_Corlag_mb_Corlag_mf';
name = 'gcms_Corlag_mb_Corlag_mf';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;
units = '[-]';

cvec = [-1:0.2:1];
opt_x_cvec = 'none';
color_handle = @color_corr;

% for startup_other
vars_req = {'lon','lat','Corlag_m','Corlag_mb','Corlag_mf'}; ...
models_startup = {'ccsm3','hadgem1'};
comp_cmd = [ ...
  '[j1,Corlag_m] = corr_autolag(mm,sig_m,''sqz1'');' ...
  '[j1,Corlag_mb] = corr_autolag(mbmb,sig_mb,''sqz1'');' ...
  '[junk1,mfmf,sig_mf] = anomaly((m+mb));' ...
  '[j1,Corlag_mf] = corr_autolag(mfmf,sig_mf,''sqz1'');' ...
];

% for plot_4panels
vars_plot = { ...
  'Corlag_m','Corlag_mb', ...
  'Corlag_m','Corlag_mb'};
models_plot = { ...
  'ccsm3','ccsm3', ...
  'hadgem1','hadgem1'};
annotate_text = { ...
  'CCSM3.0-m','CCSM3.0-mb', ...
  'HadGEM1-m','HadGEM1-mb'};

% for plot_6panels
vars_plot = { ...
  'Corlag_m','Corlag_m', ...
  'Corlag_mb','Corlag_mb', ...
  'Corlag_mf','Corlag_mf'};
models_plot = { ...
  'ccsm3','hadgem1', ...
  'ccsm3','hadgem1', ...
  'ccsm3','hadgem1'};
annotate_text = { ...
  'CCSM3.0-m','HadGEM1-m', ...
  'CCSM3.0-mb','HadGEM1-mb', ...
  'CCSM3.0-mf','HadGEM1-mf'};

% for plot_4panels
vars_plot = { ...
  'Corlag_mb','Corlag_mf', ...
  'Corlag_mb','Corlag_mf'};
models_plot = { ...
  'ccsm3','ccsm3', ...
  'hadgem1','hadgem1'};
annotate_text = { ...
  'CCSM3.0-mb','CCSM3.0-mf', ...
  'HadGEM1-mb','HadGEM1-mf'};
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

%% Call plot_4_panels.m
plot_4panels;
%plot_6panels;
% ----------------------------------------------------------------------

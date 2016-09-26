% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% gcms_Cor_Em_Cor_Emb.m
%
% --> plot_4panels.m <-- ( or plot_6panels)
%
% Summertime corr(E',m') , corr(E',mb') ... and corr(E',mf')
%
% ======================================================================

% plot_{4,6}panels required fields, for all plots!

%name = 'gcms_Cor_Em_Cor_Emb';
name = 'gcms_Cor_Em_Cor_Emb_Cor_Emf';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;

cvec = [-1:0.2:1];
opt_x_cvec = 'none';
color_handle = @color_corr;
units = '[-]';

% for startup_other
vars_req = {'lon','lat','Cor_Em','Cor_Emb','Cor_Emf'}; ...
models_startup = {'ccsm3','hadgem1'};
comp_cmd = [ ...
  '[j1,Cor_Em] = corr_inst(EE,mm,sig_E,sig_m);' ...
  '[j1,Cor_Emb] = corr_inst(EE,mbmb,sig_E,sig_mb);' ...
  '[junk1,mfmf,sig_mf] = anomaly((m+mb));' ...
  '[j1,Cor_Emf] = corr_inst(EE,mfmf,sig_E,sig_mf);' ...
];

% for plot_4panels
vars_plot = { ...
  'Cor_Em','Cor_Emb', ...
  'Cor_Em','Cor_Emb'};
models_plot = { ...
  'ccsm3','ccsm3', ...
  'hadgem1','hadgem1'};
annotate_text = { ...
  'CCSM3.0-E.m','CCSM3.0-E.mb', ...
  'HadGEM1-E.m','HadGEM1-E.mb'};

% for plot_6panels
vars_plot = { ...
  'Cor_Em','Cor_Em', ...
  'Cor_Emb','Cor_Emb', ...
  'Cor_Emf','Cor_Emf'};
models_plot = { ...
  'ccsm3','hadgem1', ...
  'ccsm3','hadgem1', ...
  'ccsm3','hadgem1'};
annotate_text = { ...
  'CCSM3.0-E.m','HadGEM1-E.m', ...
  'CCSM3.0-E.mb','HadGEM1-E.mb', ...
  'CCSM3.0-E.mf','HadGEM1-E.mf'};
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
%plot_4panels;
plot_6panels;
% ----------------------------------------------------------------------

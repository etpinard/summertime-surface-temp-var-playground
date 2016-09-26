% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% gcm_budget_res_snow.m
%
% --> plot_4panels.m <--
%
% How important are the snow/frozen water melt terms in xiU' and xim'?
%
% ======================================================================


%% Define constants

L_m = 3e5;  % latent heat of melting of water
%frozen = (10/300)*mrfso;     % hadgem has 3m column
%frozen = (10/500)*mrfso;     % ccsm has 5m column
% ----------------------------------------------------------------------

% for both plots
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;
units = '[-]';

cvec = [0,0.01,0.1,0.2:0.2:0.6]; 
opt_x_cvec = 'above';
color_handle = @color_small;

% for startup_other
vars_req = {'lon','lat', ...
            'scale_snw_xiU','scale_frz_xiU', ...
            'scale_snw_xim','scale_frz_xim'};
models_startup = {'ccsm3','hadgem1'};
comp_cmd = [ ...
  '[junk1,junk2,snwsnw] = getnewvar(''snw'',opt_anom_Var);' ...
  'tmp = isnan(snwsnw);' ...
  'snwsnw(tmp) = 0;' ...
  'snwsnw = snwsnw.*x2d(Iland,90);' ... % put back nan land pts
  '[junk1,junk2,mrfsomrfso] = getnewvar(''mrfso'',opt_anom_Var);' ...
  'den1 = sqmean(Var_xiU);' ...
  'den2 = sqmean(Var_xim);' ...
  'tmp = ddt(snwsnw);' ...
  'tmp = tmp(1:2:60,:,:);' ...  % just june to july
  'scale_snw_xiU = L_m^2*sqmean(tmp.*tmp)./den1;' ...
  'scale_snw_xim = sqmean(tmp.*tmp)./den2;' ...
  'tmp = ddt(mrfsomrfso);' ...
  'tmp = tmp(1:2:60,:,:);' ...
  'scale_frz_xiU = L_m^2*sqmean(tmp.*tmp)./den1;' ...
  'scale_frz_xim = sqmean(tmp.*tmp)./den2;' ...
];
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

%% 1) Snow in surface energy budget
name = 'gcms_scale_snow_xiU';

% for plot_4panels
vars_plot = { ...
  'scale_snw_xiU','scale_frz_xiU', ...
  'scale_snw_xiU','scale_frz_xiU'};
models_plot = { ...
  'ccsm3','ccsm3', ...
  'hadgem1','hadgem1'};
annotate_text = { ...
  'CCSM3.0-snw','CCSM3.0-frz', ...
  'HadGEM1-snw','HadGEM1-frz'};

plot_4panels;
% ----------------------------------------------------------------------

%% 2) Snow in soil mositure budget
name = 'gcms_scale_snow_xim';

% for plot_4panels
vars_plot = { ...
  'scale_snw_xim','scale_frz_xim', ...
  'scale_snw_xim','scale_frz_xim'};
models_plot = { ...
  'ccsm3','ccsm3', ...
  'hadgem1','hadgem1'};
annotate_text = { ...
  'CCSM3.0-snw','CCSM3.0-frz', ...
  'HadGEM1-snw','HadGEM1-frz'};

plot_4panels;
% ----------------------------------------------------------------------


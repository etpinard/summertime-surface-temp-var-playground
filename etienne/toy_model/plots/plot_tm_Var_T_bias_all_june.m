% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_tm_Var_T_bias_all_june.m
%
% plot_3panels.m with opt_plot_mask
%
% of (summer-averaged) Var(T) error ratio w.r.t U. Del observations :
%
% panel 1: $dataset1 data vs. obs.
% panel 2: toy model fit to $dataset1 vs. obs.
% panel 3: toy modl fit to $dataset1 with June coeffs for all 3 summer
%          months vs. obs.
%
% *) 'chi' and 'lambda' are set to June only by default,
%    with the option to include beta and gamma.
%
% -) (08/21) 'opt_nan_mask': NaN mask around 'box_regions' 1&2.
%
% ======================================================================


%%% Select dataset to analyzed
dataset1 = 'hadgem1';   
dataset1 = 'ccsm3';   
% ----------------------------------------------------------------------

% plotting options for plot_3panels 

out_format = 'both';
opt_plot_mask = 1;      % mask to NH only
opt_nan_mask = 1;

cvec = [0.0,0.25,0.5,0.8,0.9,1,1.1,1.25,2,4];   
opt_x_cvec = 'above';
color_handle = @color_relerror;
units = '[-]';
opt_overlay = 0;
opt_frame_col = 0;

name = 'tm_coeffs_all_june';
annotate_text = {'data-obs)','tm-obs)','tm.june-obs)'};
models_plot = [];   
vars_plot = {'bias_gcm_obs','bias_tm_obs','bias_tmjune_obs'};
% ----------------------------------------------------------------------

%% Toy model expression for Var(T)

% toy model formulation for Var(T), as in `tm_param_full.m'
% with '_june' tm coeffs and monthly forcing

% chi & lambda
f_Var_T = ...
['tmjune_Var_T = 1./(gamma.^2).*' ...
  '( (1-lambda_june.*(1-chi_june)).^2.*Var_F0 +' ...
  'L^2*(alpha.*(1-lambda_june) +' ...
  'chi_june.*(1+alpha.*lambda_june-beta)).^2.*Var_P );' ...
];

% chi, lambda & beta
%name = [name,'_w-beta'];
%f_Var_T = ...
%['tmjune_Var_T = 1./(gamma.^2).*' ...
%  '( (1-lambda_june.*(1-chi_june)).^2.*Var_F0 +' ...
%  'L^2*(alpha+chi_june.*(1-beta_june)).^2.*Var_P );' ...
%];

% chi, lambda, beta & gamma
%name = [name,'_w-beta-gamma'];
%f_Var_T = ...
%['tmjune_Var_T = 1./(gamma_june.^2).*' ...
%  '( (1-lambda_june.*(1-chi_june)).^2.*Var_F0 +' ...
%  'L^2*(alpha+chi_june.*(1-beta_june)).^2.*Var_P );' ...
%];
% ----------------------------------------------------------------------

%% get data

if ~strcmp(model_name,dataset1)
  next_model_name = dataset1;
  vars_req = {};
  startup_other;
end

tmp_str = relabel(vars_plot,dataset1);
if ~all(ismember(tmp_str,who))

  % get coeffs, tm_Var_T, obs_Var_T, june coeffs
  tm_param_full;
  obs_T = getobs('T',Nlat,Nlon);
  [jk1,jk2,obs_Var_T] = anomaly(obs_T,opt_anom_Var);
  gamma_june = x2d(sqz(gamma(1,:,:)));
  lambda_june = x2d(sqz(lambda(1,:,:)));
  chi_june = x2d(sqz(chi(1,:,:)));
  beta_june = x2d(sqz(beta(1,:,:)));

  % compute Var(T) all june
  eval(f_Var_T);

  % get box regions coordiantes
  if opt_nan_mask
    box_regions;
    tmp = repmat(NaN,Nlat,Nlon);
    tmp(ibox_1(2):ibox_1(4),ibox_1(1):ibox_1(3)) = 1;
    tmp(ibox_2(2):ibox_2(4),ibox_2(1):ibox_2(3)) = 1;
    Ibox_1_2 = tmp;
  else
    Ibox_1_2 = ones(Nlat,Nlon);
    name = [name,'_no_mask'];
  end

  % bias GCM to obs (summer-avg)
  bias_gcm_obs = sqmean(Var_T./obs_Var_T).*Ibox_1_2;

  % bias TM to obs (summer-avg)
  bias_tm_obs = sqmean(tm_Var_T./obs_Var_T).*Ibox_1_2;

  % bias TM(all june) to obs (summer-avg)
  bias_tmjune_obs = sqmean(tmjune_Var_T./obs_Var_T).*Ibox_1_2;

  % relabel ...
  for i=1:length(vars_plot)
    var_plot = char(vars_plot(i));
    disp(['Relabeling ... ',var_plot,' --> ', ...
            model_name,'_',var_plot,';']); 
    cmd=[model_name,'_',var_plot,'=',var_plot,';'];
    eval(cmd);
  end
end
% ----------------------------------------------------------------------

% Call plot_3panels.m 
plot_3panels;
% ======================================================================

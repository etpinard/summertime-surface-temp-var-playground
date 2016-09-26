% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_tm_Var_T_bias_exchange.m
%
% plot_3panels.m with opt_plot_mask
%
% of (summer-averaged) Var(T) error ratio w.r.t U. Del observations :
%
% Note that $dataset1 is understood to be a GCM dataset.
%
% panel 1: toy model fit to $dataset2 data vs. obs.
% panel 2: $dataset1 forcing / $dataset2 toy model coefficients
% panel 3: $dataset1 toy model coefficients / $dataset2 forcings
%
% -) (08/21) 'opt_nan_mask': NaN mask around 'box_regions' 1&2.
% -)         all 3 panels are plotted with the same resolution.
% -)         'opt_coeffs_all' (if =0 only lambda and chi are
%             exchanged, if =1 lambda, chi, beta, gamma)
% -) all outputs are interpolate (down) to $dataset2's grid
%    the 'int_' prefix refers to interpolated $dataset1 data
%
% ======================================================================


%%% Select two the datasets to analyzed
%dataset1 = 'hadgem1';   % gcm dataset (that we try to correct)
dataset1 = 'ccsm3';       
dataset2 = 'era40';     % reanalysis dataset (used to correct gcm)
% ----------------------------------------------------------------------

% plotting options for plot_3panels 

out_format = 'both';
opt_plot_mask = 1;      % mask to NH only
opt_nan_mask = 1;
opt_coeffs_all = 1;

cvec = [0.0,0.25,0.5,0.8,0.9,1,1.1,1.25,2,4];   
opt_x_cvec = 'above';
color_handle = @color_relerror;
units = '[-]';
opt_overlay = 0;
opt_frame_col = 0;

if ~opt_coeffs_all
  name = [dataset1,'_',dataset2,'_tm_coeffs_exchange'];
else
  name = [dataset1,'_',dataset2,'_tm_coeffs_exchange_all'];
end
annotate_text = {...
  ['rean.forc /' char(10) 'rean.coef)'], ...
  ['gcm.forc /' char(10) 'rean.coef)'], ...
  ['gcm.coef /' char(10) 'rean.forc)']};
models_plot = {'era40','int','int'};   
vars_plot = {'bias_rean','bias_gcm_rean','bias_rean_gcm'};
% ----------------------------------------------------------------------

%% Set up data retrival

% requied variable for `startup_other.m'
vars_req = {'lon','lat','Iland', ...
            'obs_Var_T','bias_gcm', ...
            'Var_F0','Var_P','alpha', ...
            'lambda','chi','gamma','beta'};
Nvar_req = length(vars_req);

% variables to interpolate 
vars_int = {'obs_Var_T','bias_gcm', ...
            'Var_F0','Var_P','alpha', ...
            'lambda','chi','gamma','beta'};
Nvar_int = length(vars_int);

% command to get observations 
cmd_other = [ ...
  'tm_param_full;', ...
  'obs_T = getobs(''T'',Nlat,Nlon);' ...
  '[jk1,jk2,obs_Var_T] = anomaly(obs_T,opt_anom_Var);' ...
  'bias_gcm = sqmean(tm_Var_T./obs_Var_T);' ...
  ];

% command to get dataset2 bias
f_rean = [ ...
  'obs_T = getobs(''T'',Nlat,Nlon);' ...
  '[jk1,jk2,obs_Var_T] = anomaly(obs_T,opt_anom_Var);' ...
  'era40_bias_rean = sqmean(tm_Var_T./obs_Var_T);' ...
];

% commands to get Var(T) , after interpolation
if ~opt_coeffs_all

  % gcm forcing / rean tm coeffs , (just chi and lambda)
  f_gcm_rean = [ ...
  'tmp = ' ...
  '1./(int_gamma.^2).*(' ...
  '(1-',dataset2,'_lambda.*(1-',dataset2,'_chi)).^2.*int_Var_F0' ...
  '+ L^2*(int_alpha.*(1-',dataset2,'_lambda) +' ...
  ,dataset2,'_chi.*(1 + ' ...
  'alpha.*',dataset2,'_lambda-int_beta)).^2.*int_Var_P );' ...
  'int_bias_gcm_rean = sqmean(tmp./int_obs_Var_T);' ...
  ];

else

  % gcm forcing / rean tm coeffs , (chi, lambda, beta, gamma)
  f_gcm_rean = [ ...
  'tmp = ' ...
  '1./(',dataset2,'_gamma.^2).*(' ...
  '(1-',dataset2,'_lambda.*(1-',dataset2,'_chi)).^2.*int_Var_F0' ...
  '+ L^2*(int_alpha.*(1-',dataset2,'_lambda) +' ...
  ,dataset2,'_chi.*(1 + ' ...
  'alpha.*',dataset2,'_lambda-',dataset2,'_beta)).^2.*int_Var_P );' ...
  'int_bias_gcm_rean = sqmean(tmp./int_obs_Var_T);' ...
  ];

end
  
% rean forcing / gcm tm coeffs
f_rean_gcm = [ ...
'tmp = ' ...
'1./(int_gamma.^2).*(' ...
'(1-int_lambda.*(1-int_chi)).^2.*',dataset2,'_Var_F0' ...
'+ L^2*(int_alpha.*(1-int_lambda) +' ...
'int_chi.*(1 + ' ...
'alpha.*int_lambda-int_beta)).^2.*',dataset2,'_Var_P );' ...
'int_bias_rean_gcm = sqmean(tmp./int_obs_Var_T);' ...
];

% get box regions coordiantes
if opt_nan_mask
  f_nan_mask = [ ...
  'box_regions;' ...
  'tmp = repmat(NaN,Nlat,Nlon);' ...
  'tmp(ibox_1(2):ibox_1(4),ibox_1(1):ibox_1(3)) = 1;' ... 
  'tmp(ibox_2(2):ibox_2(4),ibox_2(1):ibox_2(3)) = 1;' ...
  'Ibox_1_2 = tmp;'];
else
  f_nan_mask = ['Ibox_1_2 = ones(Nlat,Nlon);'];
  name = [name,'_no_mask'];
end
% ----------------------------------------------------------------------

%% Get data!
 
% set up depending on input `model_name'
if strcmp(model_name,dataset1)
  tmp_str = relabel(vars_req,dataset1);
  next_model_name = dataset2;
elseif strcmp(model_name,dataset2)
  eval(f_nan_mask);
  tmp_str = relabel(vars_req,dataset2);
  next_model_name = dataset1;
else
  disp('*** not supported')
  disp(['run ~/proj/etienne/switch_dataset.sh toy_model ',dataset1])
  break
end
 
% 1) execute with current `model_name', if needed
if ~all(ismember(tmp_str,who))
  eval(cmd_other); end

% 2) execute with 'other' model_name, if needed
tmp_str_other = relabel(vars_req,next_model_name);
if ~all(ismember(tmp_str_other,who))
  startup_other;
  eval(cmd_other);
  for i=1:Nvar_req
    var_req = char(vars_req(i));
    disp(['Relabeling ... ',var_req,' --> ', ...
            model_name,'_',var_req,';']); 
    cmd=[model_name,'_',var_req,'=',var_req,';'];
    eval(cmd);
  end
end

% *) compute 'bias_rean' and get land mask at dataset2's grid
if strcmp(model_name,dataset2)
  eval(f_rean);
  eval(f_nan_mask);
end

% 3) interpolate toy model coefficients down to the 'dataset2' grid

eval(['lon1 = ',dataset1,'_lon;']);
eval(['lat1 = ',dataset1,'_lat;']);
eval(['lon2 = ',dataset2,'_lon;']);
eval(['lat2 = ',dataset2,'_lat;']);
eval(['Iland2 = ',dataset2,'_Iland;']);

for i=1:Nvar_int
  
  % get variable to interpolate
  eval(['var1 = ',dataset1,'_',char(vars_int{i}),';']);
  
  % interpolate --> my_interp2.m
  tmp = my_interp2(var1,lat1,lon1,lat2,lon2,Iland2);

  % eval to `int_ '
  eval(['int_',char(vars_int{i}),'=tmp;']);

end

eval(['int_lon=',dataset2,'_lon;']);
eval(['int_lat=',dataset2,'_lat;']);

% 4) Compute 'gcm_rean' and 'rean_gcm' with interpolated data
eval(f_gcm_rean);
eval(f_rean_gcm);

% *) opt_nan_mask
if opt_nan_mask
  int_bias_gcm = int_bias_gcm.*Ibox_1_2;
  era40_bias_rean = era40_bias_rean.*Ibox_1_2; 
  int_bias_gcm_rean = int_bias_gcm_rean.*Ibox_1_2;
  int_bias_rean_gcm = int_bias_rean_gcm.*Ibox_1_2;
end
% ----------------------------------------------------------------------

%% Call plot_3panels.m 
plot_3panels;
% ======================================================================

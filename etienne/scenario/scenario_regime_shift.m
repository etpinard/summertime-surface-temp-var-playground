% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% scenario_regime_shift.m
%
% --> plot_map_miller2.m <--
%
% 1) Map regions of regime shift 
%       (=-1 for wet -> dry, =1 for dry -> wet)
%
% 2) Plot Var(T_21st)/Var(T_20th) in regions of regime shift.
%
% Assuming that m_crit is the same in the 20th and 21st century
%
% Also, note that 20th and 21st century runs have the same resolutions
% in both GCMs.
%
% ======================================================================

%%% Select the GCM to analyse
gcm1 = 'hadgem1';     
% ----------------------------------------------------------------------

%%% 1) scenario_regime_shift

%% compute 'regime_shift'

% assign data for 'gcm1'
cmd = [ ...
  'm_20th =',gcm1,'_m;' ...
  'm_21st =',gcm1,'_a1b_m;' ...
  'Nlat = size(m_20th,2);' ...
  'Nlon = size(m_20th,3);' ...
  'lon =',gcm1,'_lon;' ...
  'lat =',gcm1,'_lat;' ...
  ];
eval(cmd);

% compute m_crit (with m_20th)
m_crit = repmat(mean1d(m_20th),[Nlat Nlon]);

% compute m to m_crit difference
cmd = [ ...
  'm_crit_diff_20th = sqmean(m_20th)-m_crit;' ...
  'm_crit_diff_21st = sqmean(m_21st)-1.05*m_crit;'];
eval(cmd);

% compute regime_shift check
tmp1 = heaviside(m_crit_diff_20th.*m_crit_diff_21st);
tmp2 = sign(m_crit_diff_20th);
tmp3 = (tmp1-1).*tmp2;

% retain only values not equal to 0
regime_shift = makenan(tmp3,'==0');
% ----------------------------------------------------------------------

%% plotting

cvec = [-1,0,1];
units = '[-]';
opt_x_cvec = [];
color_handle = @color_scale;

% plot '.png'
name = [gcm1,'_scenario_regime_shift'];
plot_map_miller2( ...
  lon,lat,regime_shift, ...
  cvec,opt_x_cvec,name,color_handle,'[-]');

% plot '.eps'
name = [gcm1,'_scenario_regime_shift.eps'];
plot_map_miller2( ...
  lon,lat,regime_shift, ...
  cvec,opt_x_cvec,name,color_handle,'[-]');
% ----------------------------------------------------------------------

%%% 2) scenario_Var_T_regime_shift

%% mask Var(T) ratio to 'regime_shift' regions

% assign data for 'gcm1'
cmd = [ ...
  'T_20th =',gcm1,'_T;' ...
  'T_21st =',gcm1,'_a1b_T;' ...
 ];
eval(cmd);

% compute anomaly 
[j1,j2,Var_T_20th] = anomaly(T_20th,'Var');
[j1,j2,Var_T_21st] = anomaly(T_21st,'Var');

% compute Var(T) ratio
tmp = sqmean(Var_T_21st./Var_T_20th);

% mask it 
mask = abs(regime_shift); 
ratio_Var_T_shift = tmp.*mask;
% ----------------------------------------------------------------------

%% plotting

cvec = [0.0,0.25,0.5,0.8,0.9,1,1.1,1.25,2,4];   
units = '[-]';
opt_x_cvec = 'above';
color_handle = @color_relerror;

% plot '.png'
name = [gcm1,'_scenario_ratio_Var_T_shift'];
plot_map_miller2( ...
  lon,lat,ratio_Var_T_shift, ...
  cvec,opt_x_cvec,name,color_handle,'[-]');

% plot '.eps'
name = [gcm1,'_scenario_ratio_Var_T_shift.eps'];
plot_map_miller2( ...
  lon,lat,ratio_Var_T_shift, ...
  cvec,opt_x_cvec,name,color_handle,'[-]');
% ----------------------------------------------------------------------

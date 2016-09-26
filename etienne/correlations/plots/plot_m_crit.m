% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_m_crit.m
%
% --> plot_3panels.m <--
%
% (m - m_GM)_dataset * (m - m_GM)_ERA40
%
% if >0, then dataset and ERA40 have same evapotranspiration regime.
%
% ======================================================================

%%% Select the baseline dataset
dataset_base = 'era40';     
% ----------------------------------------------------------------------

name = 'plot_m_crit';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;     
units = '[-]';

cvec = [-1,0,1];
opt_x_cvec = [];
color_handle = @color_scale;

% for plot_3panels
vars_plot = { ...
  'm_crit_check_ccsm3','m_crit_check_hadgem1','m_crit_check_ncep_doe'};
models_plot = {'int','int','int'};
annotate_text = {'CCSM3.0','HadGEM1','NCEP-DOE'};
% ----------------------------------------------------------------------

%% Set up data retrival

% requied variable for `startup_other.m'
vars_req = {'lon','lat','Iland','m_crit_diff'};
Nvar_req = length(vars_req);

% command for all datasets
cmd_data = [ ...
  'm_crit_diff = sqmean(m)-repmat(mean1d(m),[Nlat Nlon]);'];
% ----------------------------------------------------------------------

%% Get data

% loop through datasets to get 'm_crit_diff'
models_loop = {'ccsm3','hadgem1','ncep_doe','era40'};
vars_req_str = repmat({''},Nvar_req,1);
for j=1:Nvar_req;
  vars_req_str{j} = [model_name,'_',char(vars_req(j))]; end
if ~all(ismember(vars_req_str,who));
  eval(cmd_data); end
for i_model=1:4
  next_model_name = char(models_loop(i_model));
  vars_req_str = repmat({''},Nvar_req,1);
  for j=1:Nvar_req;
    vars_req_str{j} = [next_model_name,'_',char(vars_req(j))]; end
  if ~all(ismember(vars_req_str,who));
    startup_other; 
    eval(cmd_data);
    for i=1:Nvar_req
      var_req = char(vars_req(i));
      disp(['Relabeling ... ',var_req, ...
            ' --> ',model_name,'_',var_req,';']); 
      cmd=[model_name,'_',var_req,'=',var_req,';'];
      eval(cmd);
    end
  end
end

% loop through the 3 datasets (not the era40)
models_loop = {'ccsm3','hadgem1','ncep_doe'};
eval(['lon_base = ',dataset_base,'_lon;']);
eval(['lat_base = ',dataset_base,'_lat;']);
eval(['Iland_base = ',dataset_base,'_Iland;']);
for i=1:3
  eval(['lon1 = ',char(models_loop{i}),'_lon;']);
  eval(['lat1 = ',char(models_loop{i}),'_lat;']);
  eval(['var1 = ',char(models_loop{i}),'_m_crit_diff;']);
  tmp = my_interp2(var1,lat1,lon1,lat_base,lon_base,Iland_base);
  eval(['int_m_crit_diff_',char(models_loop{i}),' = tmp;']);
end
eval(['int_lon=',dataset_base,'_lon;']);
eval(['int_lat=',dataset_base,'_lat;']);

% compute m_crit_check
tmp = int_m_crit_diff_ccsm3.*era40_m_crit_diff;
tmp2 = (1-heaviside(tmp)).*sign(int_m_crit_diff_ccsm3);
int_m_crit_check_ccsm3 = makenan(tmp2,'==0');

tmp = int_m_crit_diff_hadgem1.*era40_m_crit_diff;
tmp2 = (1-heaviside(tmp)).*sign(int_m_crit_diff_hadgem1);
int_m_crit_check_hadgem1 = makenan(tmp2,'==0');

tmp = int_m_crit_diff_ncep_doe.*era40_m_crit_diff;
tmp2 = (1-heaviside(tmp)).*sign(int_m_crit_diff_ncep_doe);
int_m_crit_check_ncep_doe = makenan(tmp2,'==0');
% ----------------------------------------------------------------------

%% Call plot_3panels.m 
plot_3panels;
% ======================================================================

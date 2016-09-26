%%% Startup file for sceanario/ 
  %
  % 1) Loads 'T' and 'm' from 'hadgem1' and 'ccsm3' 
  % (climate of 20th century) , (and tun anomaly_full)
  %
  % 2) Loads 'T' and 'm' from 'a1b' runs , summer_only , land_only
  % but not 'anomaly.m'
  %
  % ** Do NOT use ../switch_dataset.sh for this folder!
	%	
% ======================================================================


clear all; 
close all;		

%% Add path to parent directory and set up paths

parent_dir = [fileparts(pwd),'/'];
addpath(parent_dir);
make_paths
% ----------------------------------------------------------------------

%% 1) Load climate of the 20th century variables

% Load 'hadgem1' , T and m only , trim sat. grid points, anomaly_full

model_name = 'hadgem1';
opt_vars_load = 'obs_compare';
[vars_full,vars,Nvar] = startup_vars(opt_vars_load,model_name);	
[trim_opt,m_range] = startup_thres(model_name);		
startup_full
% ----------------------------------------------------------------------

% Load 'ccsm3' , T and m only , trim sat. grid points, anomaly_full

next_model_name = 'ccsm3';
vars_req = {'lon','lat','Iland', ...
            'T','Tbar','m','mbar'};
startup_other

for i=1:length(vars_req)
  var_req = char(vars_req(i));
  cmd=[model_name,'_',var_req,'=',var_req,';'];
  eval(cmd);
end
% ----------------------------------------------------------------------

%% 2) Load 'a1b' variables

% Load 'hadgem1' and 'ccsm3'

model_sres_name = {'hadgem1_a1b','ccsm3_a1b'};
model_sres_path = {'hadgem1-a1b','ccsm3-a1b'};
vars_full_sres = {'tas','mrsos'};
vars_sres = {'T','m'};

for i=1:length(model_sres_name)

  model_datapath = [datapath,model_sres_path{i},'/'];

  tmp = model_sres_name{i};
  model_root = [tmp(1:end-4),'_'];

  for j=1:length(vars_full_sres)

    path = [model_datapath,vars_full_sres{j},'.cdf'];
    X = nc_varget(path,vars_full_sres{j});
    lat = nc_varget(path,'lat');
    lon = nc_varget(path,'lon');
    X = summer_only(X,6,8,Nyear);

    cmd = ['X = X.*x2d(',model_root,'Iland,Ntime);'];
    eval(cmd);

    cmd = [model_sres_name{i},'_',vars_sres{j},' = X;'];
    eval(cmd)

  end
  
   cmd = [model_sres_name{i},'_lat = lat ;'];
   eval(cmd)
   cmd = [model_sres_name{i},'_lon = lon ;'];
   eval(cmd)
   cmd = [model_sres_name{i},'_Iland =',model_root,'Iland ;'];
   eval(cmd)

end
% ----------------------------------------------------------------------


% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_tm_Var_T_bias_mbar.m
%
% plot_3panels.m 
%
%
% ======================================================================

%%% Select date of toy model formulation:
%date = 'mar15';
%date = 'may14';
%date = 'may16';
date = 'param_full';
% ----------------------------------------------------------------------

%%% Select two the datasets to analyzed
dataset1 = 'hadgem1';   % forcing in 3rd panel
dataset2 = 'era40';     % tm coeffs and grid in 3rd panel
% ----------------------------------------------------------------------

% plotting options for plot_3panels and plot_hist2.m

out_format = 'png';
%out_format = 'eps';
cvec = [-1:0.25:3]; 
opt_x_cvec = 'above';
units = '[-]';
color_handle = @color_posbias2;
opt_overlay = 0;
opt_frame_col = 0;
bins = [-1,5];
yval = 1;

name = [dataset1,'_',dataset2,'_tm_coeffs_mbar'];
annotate_text = {'gcm)','rean)','gcm.rean)'};
models_plot = {dataset1,dataset2,'int'};   
vars_plot = {'Var_T_bias','Var_T_bias','Var_T_bias'};
% ----------------------------------------------------------------------

%% Set up data retrival

% requied variable for `startup_other.m'
vars_req = {'lon','lat','Iland','obs_Var_T','Var_T_bias', ...
            'mbar'};
Nvar_req = length(vars_req);

% functions to interpolate
vars_interp = {'mbar','Var_T_bias'};
Nvar_interp = length(vars_interp);

% command to be executed 
cmd_other = [ ...
  'tm_',date,';', ...
  'obs_T = getobs(''T'',Nlat,Nlon);' ...
  '[jk1,jk2,obs_Var_T] = anomaly(obs_T,opt_anom_Var);' ...
  'Var_T_bias = bias(tm_Var_T,obs_Var_T);' ...
  ];
% ----------------------------------------------------------------------

%% Get data!
 
% set up depending on input `model_name'
if strcmp(model_name,dataset1)
  tmp_str = relabel(vars_req,dataset1);
  next_model_name = dataset2;
elseif strcmp(model_name,dataset2)
  tmp_str = relabel(vars_req,dataset2);
  next_model_name = dataset1;
else
  disp('*** not supported')
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

% 3) interpolate toy model coefficients down to the 'dataset2' grid

eval(['lon1 = ',dataset1,'_lon;']);
eval(['lat1 = ',dataset1,'_lat;']);
eval(['lon2 = ',dataset2,'_lon;']);
eval(['lat2 = ',dataset2,'_lat;']);
eval(['Iland2 = ',dataset2,'_Iland;']);

for i=1:Nvar_interp
  
  % get variable to interpolate
  eval(['var1 = ',dataset1,'_',char(vars_interp{i}),';']);
  
  % interpolate --> my_interp2.m
  tmp = my_interp2(var1,lat1,lon1,lat2,lon2,Iland2);

  % eval to `int_ '
  eval(['int_',char(vars_interp{i}),'=tmp;']);

end

eval(['int_lon=',dataset2,'_lon;']);
eval(['int_lat=',dataset2,'_lat;']);
eval(['obs_Var_T=',dataset2,'_obs_Var_T;']);
% ----------------------------------------------------------------------

x = make1d(sqmean(int_mbar)./sqmean(era40_mbar));
y = make1d(sqmean(int_Var_T_bias));

box_regions

%plot(x,y,'x')
%axis([-0.1,2,0,5]);

%%%%%% Does not come out very nicely ....

break

%% Call plot_3panels.m and plot_hist2.m
plot_3panels;

plot_hist_arr = ...
  catsheet(sqmean(hadgem1_Var_T_bias), ...
           sqmean(era40_Var_T_bias), ...
           sqmean(int_Var_T_bias));
plot_hist2(plot_hist_arr,bins,[],name,[]);
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_gcm_tm_sig_T.m
%
% plot_5panels.m 
%
% of sig_T from GCM of TM for both GCMs and U. Del observations.
% 
% ======================================================================

%%% Select date of toy model formulation:
%date = 'mar15';
%date = 'may14';
date = 'may16';
% ----------------------------------------------------------------------

% plot_4panels and plot_hist2.m required fields, for all plots!

out_format = 'png';
out_format = 'eps';
%cvec = [0:0.25:3]; 
cvec = [0:0.5:3]; 
opt_x_cvec = 'above';
units = 'K';
color_handle = @color_mag;
opt_overlay = 0;
annotate_text = {'Obs)','GCM.1)','GCM.2)','TM.1)','TM.2)'};
opt_frame_col = 0;
bins = [0:0.1:5];
yval = 1;

name = ['gcm_tm_sig_T_',date];
vars_req = {'lon','lat','sig_T','tm_sig_T'};          
models_plot = {'obs','ccsm3','hadgem1','ccsm3','hadgem1'};
vars_plot = {'sig_T','sig_T','sig_T','tm_sig_T','tm_sig_T'};
% ----------------------------------------------------------------------

%% Call tm_$date with `opt_plot=0'
opt_plot = 0;

if ~all(ismember({'sig_T','tm_sig_T'},who))
  eval(['tm_',date,';']);
  sig_T = sqrt(sqmean(Var_T));
  tm_sig_T = sqrt(sqmean(tm_Var_T));
end
% ----------------------------------------------------------------------

%% Call startup_other if needed for other GCM'

if strcmp(model_name,'ccsm3');
  next_model_name = 'hadgem1';
elseif strcmp(model_name,'hadgem1')
  next_model_name = 'ccsm3';
  
  % get obs
  obs_T = getobs('T',Nlat,Nlon);
  disp('Computing ... obs_Tbar and obs_Var_T');
  [obs_Tbar,junk2,obs_Var_T] = anomaly(obs_T,opt_anom_Var);
  obs_lon = lon;
  obs_lat = lat;
  obs_sig_T = sqrt(sqmean(obs_Var_T));

else
  disp('not supported')
  break
end

Nvar_req = length(vars_req);
tmp = repmat({''},Nvar_req,1);
for j=1:Nvar_req;
  tmp{j} = [next_model_name,'_',char(vars_req(j))]; end
  
if ~all(ismember(tmp,who));

  startup_other; 

  tm_param;
  eval(['tm_',date,';']);
  sig_T = sqrt(sqmean(Var_T));
  tm_sig_T = sqrt(sqmean(tm_Var_T));

  for i=1:Nvar_req
    var_req = char(vars_req(i));
    disp(['Relabeling ... ',var_req,' --> ', ...
            model_name,'_',var_req,';']); 
    cmd=[model_name,'_',var_req,'=',var_req,';'];
    eval(cmd);
  end

end
  
if strcmp(model_name,'hadgem1')
  % get obs
  obs_T = getobs('T',Nlat,Nlon);
  disp('Computing ... obs_Tbar and obs_Var_T');
  [obs_Tbar,junk2,obs_Var_T] = anomaly(obs_T,opt_anom_Var);
  obs_lon = lon;
  obs_lat = lat;
  obs_sig_T = sqrt(sqmean(obs_Var_T))
end
% ----------------------------------------------------------------------

%% Call plot_4panels.m and plot_hist2.m

plot_5panels;
%plot_hist2(catsheet(z11,z12,z21,z22),bins,[],name,yval,out_format);
%plot_hist2(catsheet(ccsm3_sig_T,hadgem1_sig_T, ...
%           ccsm3_tm_sig_T,hadgem1_tm_sig_T),bins,[],name,yval,out_format);
% ----------------------------------------------------------------------

% ======================================================================

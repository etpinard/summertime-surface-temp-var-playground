% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% line_sigP.m
%
% --> plot_line.m <--
%
% line plot of sig_P in U. Delaware data and the 4 datasets.
%
% -) 'MJJAS' sig_P + (P'-Pbar) of 4 datasets+obs 
%
% ======================================================================

% options for plot_line.m 
out_format = 'png';
ylab = 'std(P)  ,  |P''| [mm day-1]';
name = 'sig_P';
opt_plot_line = 'MJJAS';
yvals = [-0.1,2.5];

% for startup_other.m
vars_req = {'sigPfull1','sigPfull2','PPfull1','PPfull2'};
comp_cmd = [ ...
  'Pfull = getnewvar(''pr'',[],[5,9]);' ...
  'Pfull = Pfull*secinday;' ...
  '[Pbar,PP,sigPfull] = anomaly(Pfull,[],5);' ...
  'box_regions;' ...
  'sigPfull1 = box_avg(sigPfull,ibox_1);' ...
  'sigPfull2 = box_avg(sigPfull,ibox_2);' ...
  'PPfull1 = box_avg(abs(PP),ibox_1);' ...
  'PPfull2 = box_avg(abs(PP),ibox_2);' ...
  ];

opt_no_anom = 1;
only_m1 = 5;
only_m2 = 9;
obs_cmd = [ ...
  'get_obs_P;' ...
  'Pob = Pob*secinday;' ...
  '[Pbar,PP,sigPfull] = anomaly(Pob,[],5);' ...
  'obs_sigPfull1 = box_avg(sigPfull,ibox_1);' ...
  'obs_sigPfull2 = box_avg(sigPfull,ibox_2);' ...
  'obs_PPfull1 = box_avg(abs(PP),ibox_1);' ...
  'obs_PPfull2 = box_avg(abs(PP),ibox_2);' ...
  ];
models_startup = {'ccsm3','ncep_doe','hadgem1','era40'};
% ----------------------------------------------------------------------

%% Call startup_other.m to get the (4) data sets 
Nvar_req = length(vars_req);

vars_req_str = relabel(vars_req,model_name);
if ~all(ismember(vars_req_str,who));
  eval(comp_cmd);
end

vars_req_str = relabel(vars_req,'obs');
if strcmp(model_name,'hadgem1') && ~all(ismember(vars_req_str,who));
  eval(obs_cmd)
end

for i_model=1:4

  % next model to load
  next_model_name = char(models_startup(i_model));

  % fill up `vars_req_str' for upcoming strcmp
  vars_req_str = relabel(vars_req,next_model_name);
  
  % call startup_other.m if variable in `vars_req_str' do not exists
  if ~all(ismember(vars_req_str,who));
    startup_other; 
    
    % evaluate `comp_cmd'
    eval(comp_cmd);

    % evalute `obs_cmd' if 'hadgem1'
    if strcmp(model_name,'hadgem1')
      eval(obs_cmd)
    end

    % one more round of relabeling (an artifact of startup_other)
    for i=1:Nvar_req

      var_req = char(vars_req(i));
      disp(['Relabeling ... ',var_req, ...
            ' --> ',model_name,'_',var_req,';']); 
      cmd=[model_name,'_',var_req,'=',var_req,';'];
      eval(cmd);

    end
  end
end
% ----------------------------------------------------------------------

%% Call plot_line.m

% ncep_doe is awful!!! 

Y1 = catsheet( ...
  ccsm3_sigPfull1,[], ...
  hadgem1_sigPfull1,era40_sigPfull1,obs_sigPfull1);
YY1 = catsheet( ...
  ccsm3_PPfull1,[], ...
  hadgem1_PPfull1,era40_PPfull1,obs_PPfull1);
plot_line(Y1,YY1,opt_plot_line,ylab,yvals,[name,'_box1'],out_format);

Y2 = catsheet( ...
  ccsm3_sigPfull2,[], ...
  hadgem1_sigPfull2,era40_sigPfull2,obs_sigPfull2);
YY2 = catsheet( ...
  ccsm3_PPfull2,[], ...
  hadgem1_PPfull2,era40_PPfull2,obs_PPfull2);
plot_line(Y2,YY2,opt_plot_line,ylab,yvals,[name,'_box2'],out_format);
% ----------------------------------------------------------------------

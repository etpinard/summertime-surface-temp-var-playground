% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% line_sigT_full.m
%
% --> plot_line.m <--
%
% line plot of sig_T in U. Delaware data and the 4 datasets.
%
% -) 'full' sig_T of 4 datasets+obs.
%
% in ./line_sigT.m : 'MJJAS' sig_T + (T'-Tbar) of 4 datasets+obs 
%
% ======================================================================

% options for plot_line.m 
out_format = 'png';
%out_format = 'eps';
ylab = 'std. of T [K]';
name = 'sig_T_full';
opt_plot_line = 'full';
yvals = [0.5,5.5];
YY = [];

% for startup_other.m
vars_req = {'sigTfull1','sigTfull2'};
comp_cmd = [ ...
  'Tfull = getnewvar(''tas'',[],[1,12]);' ...
  '[Tbar,TT,sigTfull] = anomaly(Tfull,[],12);' ...
  'box_regions;' ...
  'sigTfull1 = box_avg(sigTfull,ibox_1);' ...
  'sigTfull2 = box_avg(sigTfull,ibox_2);' ...
  ];

opt_no_anom = 1;
only_m1 = 1;
only_m2 = 12;
obs_cmd = [ ...
  'get_obs_T;' ...
  '[Tbar,TT,sigTfull] = anomaly(Tob,[],12);' ...
  'obs_sigTfull1 = box_avg(sigTfull,ibox_1);' ...
  'obs_sigTfull2 = box_avg(sigTfull,ibox_2);' ...
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

Y1 = catsheet( ...
  ccsm3_sigTfull1,ncep_doe_sigTfull1, ...
  hadgem1_sigTfull1,era40_sigTfull1,obs_sigTfull1);
plot_line(Y1,YY,opt_plot_line,ylab,yvals,[name,'_box1'],out_format);

Y2 = catsheet( ...
  ccsm3_sigTfull2,ncep_doe_sigTfull2, ...
  hadgem1_sigTfull2,era40_sigTfull2,obs_sigTfull2);
plot_line(Y2,YY,opt_plot_line,ylab,yvals,[name,'_box2'],out_format);
% ----------------------------------------------------------------------

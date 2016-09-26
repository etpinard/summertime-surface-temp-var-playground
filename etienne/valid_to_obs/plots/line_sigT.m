% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% line_sigT.m
%
% --> plot_line.m <--
%
% line plot of sig_T in U. Delaware data and the 4 datasets.
%
% -) 'MJJAS' sig_T + (T'-Tbar) of 4 datasets+obs 
%
% in ./line_sigT_full.m : 'full' sig_T of 4 datasets+obs.
%
% ======================================================================

% options for plot_line.m 
out_format = 'png';
ylab = 'std(T)  ,  |T''| [K]';
name = 'sig_T';
opt_plot_line = 'MJJAS';
yvals = [-0.1,4];

% for startup_other.m
vars_req = {'sigTfull1','sigTfull2','TTfull1','TTfull2'};
comp_cmd = [ ...
  'Tfull = getnewvar(''tas'',[],[5,9]);' ...
  '[Tbar,TT,sigTfull] = anomaly(Tfull,[],5);' ...
  'box_regions;' ...
  'sigTfull1 = box_avg(sigTfull,ibox_1);' ...
  'sigTfull2 = box_avg(sigTfull,ibox_2);' ...
  'TTfull1 = box_avg(abs(TT),ibox_1);' ...
  'TTfull2 = box_avg(abs(TT),ibox_2);' ...
  ];

opt_no_anom = 1;
only_m1 = 5;
only_m2 = 9;
obs_cmd = [ ...
  'get_obs_T;' ...
  '[Tbar,TT,sigTfull] = anomaly(Tob,[],5);' ...
  'obs_sigTfull1 = box_avg(sigTfull,ibox_1);' ...
  'obs_sigTfull2 = box_avg(sigTfull,ibox_2);' ...
  'obs_TTfull1 = box_avg(abs(TT),ibox_1);' ...
  'obs_TTfull2 = box_avg(abs(TT),ibox_2);' ...
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
YY1 = catsheet( ...
  ccsm3_TTfull1,ncep_doe_TTfull1, ...
  hadgem1_TTfull1,era40_TTfull1,obs_TTfull1);
plot_line(Y1,YY1,opt_plot_line,ylab,yvals,[name,'_box1'],out_format);

Y2 = catsheet( ...
  ccsm3_sigTfull2,ncep_doe_sigTfull2, ...
  hadgem1_sigTfull2,era40_sigTfull2,obs_sigTfull2);
YY2 = catsheet( ...
  ccsm3_TTfull2,ncep_doe_TTfull2, ...
  hadgem1_TTfull2,era40_TTfull2,obs_TTfull2);
plot_line(Y2,YY2,opt_plot_line,ylab,yvals,[name,'_box2'],out_format);
% ----------------------------------------------------------------------

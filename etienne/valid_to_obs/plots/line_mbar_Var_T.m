% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% line_mbar_sig_T.m
%
% --> plot_line_2axes.m <--
%
% line plot of mbar and sig_T on a 2-axes line plot.
%
% ======================================================================

% options for plot_line.m 
out_format = 'both';
name = 'mbar_sig_T';
opt_plot_line = {'MJJAS','mbar_sig_T'};

% for startup_other.m
vars_req = {'sig_T1','sig_T2','mbar1','mbar2'};
comp_cmd = [ ...
  'Tfull = getnewvar(''tas'',[],[5,9]);' ...
  'mfull = getnewvar(''mrsos'',[],[5,9]);' ...
  '[j1,j2,sigTfull] = anomaly(Tfull,[],5);' ...
  'mbarfull = anomaly(mfull,[],5);' ...
  'box_regions;' ...
  'sig_T1 = box_avg(sigTfull,ibox_1);' ...
  'sig_T2 = box_avg(sigTfull,ibox_2);' ...
  'mbar1 = box_avg(abs(mbarfull),ibox_1);' ...
  'mbar2 = box_avg(abs(mbarfull),ibox_2);' ...
  ];

% obs_cmd = [

%models_startup = {'hadgem1','era40'};
models_startup = {'hadgem1','era40','ncep_doe','ccsm3'};
% ----------------------------------------------------------------------

%% Call startup_other.m to get the (4) data sets 
Nvar_req = length(vars_req);

vars_req_str = relabel(vars_req,model_name);
if ~all(ismember(vars_req_str,who));
  eval(comp_cmd);
end

vars_req_str = relabel(vars_req,'obs');
if exist('obs_cmd') && ...
      strcmp(model_name,'hadgem1') && ~all(ismember(vars_req_str,who));
  eval(obs_cmd)
end

for i_model=1:length(models_startup)

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
    if exist('obs_cmd') && strcmp(model_name,'hadgem1')
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

if length(models_startup)==2
  Y_l1 = catsheet(era40_mbar1,hadgem1_mbar1);
  Y_r1 = catsheet(era40_sig_T1,hadgem1_sig_T1);
  Y_l2 = catsheet(era40_mbar2,hadgem1_mbar2);
  Y_r2 = catsheet(era40_sig_T2,hadgem1_sig_T2);
else
  Y_l1 = catsheet(era40_mbar1,ncep_doe_mbar1, ...
                  hadgem1_mbar1,ccsm3_mbar1);
  Y_r1 = catsheet(era40_sig_T1,ncep_doe_sig_T1, ...
                  hadgem1_sig_T1,ccsm3_sig_T1);
  Y_l2 = catsheet(era40_mbar2,ncep_doe_mbar2, ...
                  hadgem1_mbar2,ccsm3_mbar2);
  Y_r2 = catsheet(era40_sig_T2,ncep_doe_sig_T2, ...
                  hadgem1_sig_T2,ccsm3_sig_T2);
  name = [name,'_all'];
end

Y_l = catsheet(Y_l1,Y_l2);
Y_r = catsheet(Y_r1,Y_r2);

plot_line_2axes( ...
  Y_l,Y_r,opt_plot_line,name,'eps');
plot_line_2axes( ...
  Y_l,Y_r,opt_plot_line,name,'png');

break
plot_line_2axes( ...
  Y_l1,Y_r1,opt_plot_line,[name,'_box1'],out_format);
plot_line_2axes( ...
  Y_l2,Y_r2,opt_plot_line,[name,'_box2'],out_format);
% ----------------------------------------------------------------------

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% line_sigF.m
%
% --> plot_line.m <--
%
% line plot of sig_F (and sig_F0) in the 4 datasets.
%
% 1) 'MJJAS' sig_F + |F'| of 4 datasets+obs 
%
% 2) 'MJJAS' sig_F0 + |F0'| of 4 datasets+obs 
%
% ======================================================================

% options for plot_line.m in both 1) & 2)
out_format = 'png';
opt_plot_line = 'MJJAS';

% for startup_other.m
vars_req = {'sigFfull1','sigFfull2','FFfull1','FFfull2', ...
            'sigF0full1','sigF0full2','F0F0full1','F0F0full2'};
comp_cmd = [ ...
  'Fsd = getnewvar(''rsds'',[],[5,9]);' ...
  'Fsu = getnewvar(''rsus'',[],[5,9]);' ...
  'Fld = getnewvar(''rlds'',[],[5,9]);' ...
  'P = getnewvar(''pr'',[],[5,9]);' ...
  '[j1,FF,sigFfull] = anomaly(Fsd-Fsu+Fld,[],5);' ...
  '[j1,PP,sigPfull] = anomaly(P,[],5);' ...
  '[j1,F0F0] = regrs(FF,-PP,5);' ...
  'sigF0full = anomaly_sig(F0F0,5);' ...
  'box_regions;' ...
  'sigFfull1 = box_avg(sigFfull,ibox_1);' ...
  'sigFfull2 = box_avg(sigFfull,ibox_2);' ...
  'FFfull1 = box_avg(abs(FF),ibox_1);' ...
  'FFfull2 = box_avg(abs(FF),ibox_2);' ...
  'sigF0full1 = box_avg(sigF0full,ibox_1);' ...
  'sigF0full2 = box_avg(sigF0full,ibox_2);' ...
  'F0F0full1 = box_avg(abs(F0F0),ibox_1);' ...
  'F0F0full2 = box_avg(abs(F0F0),ibox_2);' ...
  ];

models_startup = {'ccsm3','ncep_doe','hadgem1','era40'};
% ----------------------------------------------------------------------

%% Call startup_other.m to get the (4) data sets 
Nvar_req = length(vars_req);

vars_req_str = relabel(vars_req,model_name);
if ~all(ismember(vars_req_str,who));
  eval(comp_cmd);
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

%% Call plot_line.m for output 1)

name = 'sig_F';
ylab = 'std(F) , |F''| [W m-2]';
yvals = [-0.1,30];

Y1 = catsheet( ...
  ccsm3_sigFfull1,ncep_doe_sigFfull1, ...
  hadgem1_sigFfull1,era40_sigFfull1);
YY1 = catsheet( ...
  ccsm3_FFfull1,ncep_doe_FFfull1, ...
  hadgem1_FFfull1,era40_FFfull1);
plot_line(Y1,YY1,opt_plot_line,ylab,yvals,[name,'_box1'],out_format);

Y2 = catsheet( ...
  ccsm3_sigFfull2,ncep_doe_sigFfull2, ...
  hadgem1_sigFfull2,era40_sigFfull2);
YY2 = catsheet( ...
  ccsm3_FFfull2,ncep_doe_FFfull2, ...
  hadgem1_FFfull2,era40_FFfull2);
plot_line(Y2,YY2,opt_plot_line,ylab,yvals,[name,'_box2'],out_format);
% ----------------------------------------------------------------------

%% Call plot_line.m for output 2)

name = 'sig_F0';
ylab = 'std(F0) , |F0''| [W m-2]';
yvals = [-0.1,28];

Y1 = catsheet( ...
  ccsm3_sigF0full1,ncep_doe_sigF0full1, ...
  hadgem1_sigF0full1,era40_sigF0full1);
YY1 = catsheet( ...
  ccsm3_F0F0full1,ncep_doe_F0F0full1, ...
  hadgem1_F0F0full1,era40_F0F0full1);
plot_line(Y1,YY1,opt_plot_line,ylab,yvals,[name,'_box1'],out_format);

Y2 = catsheet( ...
  ccsm3_sigF0full2,ncep_doe_sigF0full2, ...
  hadgem1_sigF0full2,era40_sigF0full2);
YY2 = catsheet( ...
  ccsm3_F0F0full2,ncep_doe_F0F0full2, ...
  hadgem1_F0F0full2,era40_F0F0full2);
plot_line(Y2,YY2,opt_plot_line,ylab,yvals,[name,'_box2'],out_format);
% ----------------------------------------------------------------------

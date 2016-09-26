% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% line_tm_coeffs.m
%
% --> plot_line.m <--
%
% line plot of toy model coefficients in the 4 datasets.
%
%   'JJA' of 1) beta 2) lambda 3) chi 4) gamma 5) alpha.
%
% ======================================================================

% options for plot_line.m in 1-5)
out_format = 'png';
opt_plot_line = 'JJA';

% for startup_other.m
vars_req = {'beta1','lambda1','chi1','gamma1','alpha1', ... 
            'beta2','lambda2','chi2','gamma2','alpha2'};

comp_cmd = [ ...
  'beta = [];' ...
  'gamma = [];' ...
  'tm_param_full;' ...
  'box_regions;' ...
  'beta1 = box_avg(beta,ibox_1);' ...
  'beta2 = box_avg(beta,ibox_2);' ...
  'lambda1 = box_avg(lambda,ibox_1);' ...
  'lambda2 = box_avg(lambda,ibox_2);' ...
  'chi1 = box_avg(chi,ibox_1);' ...
  'chi2 = box_avg(chi,ibox_2);' ...
  'gamma1 = box_avg(gamma,ibox_1);' ...
  'gamma2 = box_avg(gamma,ibox_2);' ...
  'alpha1 = box_avg(alpha,ibox_1);' ...
  'alpha2 = box_avg(alpha,ibox_2);' ...
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

%% Call plot_line.m for each output 1 to 5

for i=1:5

  switch i
    case 1; 
      name = 'beta'; 
      ylab = 'beta [-]';
      yvals = [0.1,0.72];
    case 2;
      name = 'lambda'; 
      ylab = 'lambda [-]';
      yvals = [0.05,0.4];
    case 3;
      name = 'chi'; 
      ylab = 'chi [-]';
      yvals = [-0.3,0.7];
    case 4;
      name = 'gamma'; 
      ylab = 'gamma [W m-2 K-1]';
      yvals = [6.1,17.2];
    case 5;
      name = 'alpha'; 
      ylab = 'alpha [-]';
      yvals = [-0.05,0.7];
  end
    
  tmp_var = char(vars_req{i});
  tmp_var = tmp_var(1:end-1);

  cmd = ['Y1 = catsheet(ccsm3_',tmp_var,'1,ncep_doe_',tmp_var, ...
               '1,hadgem1_',tmp_var,'1,era40_',tmp_var,'1);']; 
  eval(cmd)
  plot_line(Y1,[],opt_plot_line,ylab,yvals,[name,'_box1'],out_format);

  cmd = ['Y2 = catsheet(ccsm3_',tmp_var,'2,ncep_doe_',tmp_var, ...
               '2,hadgem1_',tmp_var,'2,era40_',tmp_var,'2);']; 
  eval(cmd)
  plot_line(Y2,[],opt_plot_line,ylab,yvals,[name,'_box2'],out_format);

end
% ----------------------------------------------------------------------

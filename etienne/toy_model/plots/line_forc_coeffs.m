% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% line_forc_coeffs.m
%
% --> plot_line_2axes.m <--
%
% line plot of forcing variance and toy model coeffs (lamdba and chi)
%
% left.1) Var(F0)^1/2 , left.2) L*alpha*Var(P)^1/2
% right.1) lambda , right.2) chi 
%
% for the hadgem1 and era40 (8 fields in total)
%
% ======================================================================

% output name (hadgem1 vs era40 or hadgem1 vs ccsm3 vs era40)
%name = 'forc_coeffs';
name = 'forc_coeffs_all'; 

% options for plot_line.m 
opt_plot_line = {'JJA_avg','forc_coeffs'};

% for startup_other.m
vars_req = {'forc_F01','forc_F02','forc_P1','forc_P2', ... 
            'lambda1','lambda2','chi1','chi2'};
comp_cmd = [ ...
  'tm_param_full;' ...
  'box_regions;' ...
  'forc_F01 = box_avg(sqrt(Var_F0),ibox_1);' ...
  'forc_F02 = box_avg(sqrt(Var_F0),ibox_2);' ...
  'forc_P1 = box_avg(L*alpha.*sqrt(Var_P),ibox_1);' ...
  'forc_P2 = box_avg(L*alpha.*sqrt(Var_P),ibox_2);' ...
  'lambda1 = box_avg(lambda,ibox_1);' ...
  'lambda2 = box_avg(lambda,ibox_2);' ...
  'chi1 = box_avg(chi,ibox_1);' ...
  'chi2 = box_avg(chi,ibox_2);' ...
  ];
% ----------------------------------------------------------------------

%% Call startup_other.m to get the (4) data sets 
Nvar_req = length(vars_req);

switch name
  case 'forc_coeffs'; 
    models_startup = {'hadgem1','era40'};
  case 'forc_coeffs_all'; 
    models_startup = {'hadgem1','era40','ccsm3'}; 
  otherwise; 
    disp('shiiiiiiiii'); break
end

vars_req_str = relabel(vars_req,model_name);
if ~all(ismember(vars_req_str,who));
  eval(comp_cmd);
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

%% Concatenate vectors
if length(models_startup)==2
  Y_l1 = catsheet(era40_forc_F01,hadgem1_forc_F01, ...
                  era40_forc_P1,hadgem1_forc_P1);
  Y_l2 = catsheet(era40_forc_F02,hadgem1_forc_F02, ...
                  era40_forc_P2,hadgem1_forc_P2);
  Y_r1 = catsheet(era40_lambda1,hadgem1_lambda1, ...
                  era40_chi1,hadgem1_chi1);
  Y_r2 = catsheet(era40_lambda2,hadgem1_lambda2, ...
                  era40_chi2,hadgem1_chi2);
elseif length(models_startup)==3
  Y_l1 = catsheet(era40_forc_F01,hadgem1_forc_F01,ccsm3_forc_F01, ...
                  era40_forc_P1,hadgem1_forc_P1,ccsm3_forc_P1);
  Y_l2 = catsheet(era40_forc_F02,hadgem1_forc_F02,ccsm3_forc_F02, ...
                  era40_forc_P2,hadgem1_forc_P2,ccsm3_forc_P2);
  Y_r1 = catsheet(era40_lambda1,hadgem1_lambda1,ccsm3_lambda1, ...
                  era40_chi1,hadgem1_chi1,ccsm3_chi1);
  Y_r2 = catsheet(era40_lambda2,hadgem1_lambda2,ccsm3_lambda2, ...
                  era40_chi2,hadgem1_chi2,ccsm3_chi2);
end
Y_l = catsheet(Y_l1,Y_l2);
Y_r = catsheet(Y_r1,Y_r2);
% ----------------------------------------------------------------------

%% Call plot_line.m
plot_line_2axes( ...
  Y_l,Y_r,opt_plot_line,name,'eps');
plot_line_2axes( ...
  Y_l,Y_r,opt_plot_line,name,'png');

%plot_line_2axes( ...
%  Y_l1,Y_r1,opt_plot_line,[name,'_box1'],out_format);
%plot_line_2axes( ...
%  Y_l2,Y_r2,opt_plot_line,[name,'_box2'],out_format);
% ----------------------------------------------------------------------

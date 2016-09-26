% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_tm_T_dist.m
%
% --> plot_hist2_panels.m <--
%
% Compare distributions of 
%
% i) Dataset T' ii) Toy model T'
% iii) Toy model T' w/o m' w/ residuals
%
% ======================================================================

%%% output alternative formulation, or not
opt_tilde = 0;
% ----------------------------------------------------------------------

%%% output name (--> panel format)
name = 'tm_T_dist_no_m_full';
% ----------------------------------------------------------------------

% options for plot_hist2_panels.m 
out_format = 'both';
opt_hist = {'tm_T_dist_no_m'};

% for startup_other.m
vars_req = {'TT1','TT2','TT3', ...
            'tm_TT1','tm_TT2','tm_TT3', ...
            'tm_TT_no_m1','tm_TT_no_m2','tm_TT_no_m3'};
cmd_no_m = [ ...
'x = xmonth(1./gamma).*(FF' ...
'- L*(xmonth(lambda/L).*FF)' ...
'- L*E00E00 - Hs00Hs00 - Flu0Flu0 - xiU0xiU0);' ...
];
comp_cmd = [ ...
  'tm_param_full;' ...
  ,cmd_no_m, ...
  'box_regions;' ...
  'TT1 = box_cat(TT,ibox_1);' ...
  'TT2 = box_cat(TT,ibox_2);' ...
  'TT3 = box_cat(TT,ibox_3);' ...
  'tm_TT1 = box_cat(tm_TT,ibox_1);' ...
  'tm_TT2 = box_cat(tm_TT,ibox_2);' ...
  'tm_TT3 = box_cat(tm_TT,ibox_3);' ...
  'tm_TT_no_m1 = box_cat(x,ibox_1);' ...
  'tm_TT_no_m2 = box_cat(x,ibox_2);' ...
  'tm_TT_no_m3 = box_cat(x,ibox_3);' ...
];

%models_startup = {'hadgem1','era40'};
models_startup = {'hadgem1','era40','ncep_doe','ccsm3'}; 
% ----------------------------------------------------------------------

%% Call startup_other.m to get the (4) data sets 
Nvar_req = length(vars_req);

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

%% Concatenating vectors

switch name

  case 'tm_T_dist_no_m_full'

%  ccsm3_Z1=catsheet(ccsm3_TT1,ccsm3_tm_TT1,ccsm3_tm_TT_no_m1);
%  ccsm3_Z3=catsheet(ccsm3_TT3,ccsm3_tm_TT3,ccsm3_tm_TT_no_m3);
%  hadgem1_Z1=catsheet(hadgem1_TT1,hadgem1_tm_TT1,hadgem1_tm_TT_no_m1);
%  hadgem1_Z3=catsheet(hadgem1_TT3,hadgem1_tm_TT3,hadgem1_tm_TT_no_m3);
%  era40_Z1=catsheet(era40_TT1,era40_tm_TT1,era40_tm_TT_no_m1);
%  era40_Z3=catsheet(era40_TT3,era40_tm_TT3,era40_tm_TT_no_m3);
%  ncep_doe_Z1=catsheet(ncep_doe_TT1,ncep_doe_tm_TT1,ncep_doe_tm_TT_no_m1);
%  ncep_doe_Z3=catsheet(ncep_doe_TT3,ncep_doe_tm_TT3,ncep_doe_tm_TT_no_m3);

  ccsm3_Z1=catsheet(ccsm3_TT1,ccsm3_tm_TT_no_m1);
  ccsm3_Z3=catsheet(ccsm3_TT3,ccsm3_tm_TT_no_m3);
  hadgem1_Z1=catsheet(hadgem1_TT1,hadgem1_tm_TT_no_m1);
  hadgem1_Z3=catsheet(hadgem1_TT3,hadgem1_tm_TT_no_m3);
  era40_Z1=catsheet(era40_TT1,era40_tm_TT_no_m1);
  era40_Z3=catsheet(era40_TT3,era40_tm_TT_no_m3);
  ncep_doe_Z1=catsheet(ncep_doe_TT1,ncep_doe_tm_TT_no_m1);
  ncep_doe_Z3=catsheet(ncep_doe_TT3,ncep_doe_tm_TT_no_m3);

  Z = catsheet(ccsm3_Z1,hadgem1_Z1,era40_Z1,ncep_doe_Z1, ...
               ccsm3_Z3,hadgem1_Z3,era40_Z3,ncep_doe_Z3);

end
% ----------------------------------------------------------------------

%% call plot_hist2_panels

plot_hist2_panels(Z,opt_hist,name,out_format);
% ----------------------------------------------------------------------

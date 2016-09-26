% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_tm_m_dist.m
%
% --> plot_hist2_panels.m <--
%
% Compare distributions of 
%
% i) Observation m' ii) Dataset m' iii) Toy model m'
% 
%
%
% ======================================================================

%%% output alternative formulation, or not
opt_tilde = 0;
% ----------------------------------------------------------------------

%%% output name (--> panel format)
%name = 'tm_m_dist';
%name = 'tm_m_dist_1';
name = 'tm_m_dist_full';
% ----------------------------------------------------------------------

% options for plot_hist2_panels.m 
out_format = 'both';
opt_hist = {'tm_T_dist'};

% for startup_other.m
vars_req = {'mm1','mm2','mm3', ...
            'tm_mm1','tm_mm2','tm_mm3'};
comp_cmd = [ ...
  'tm_param_full;' ...
  'box_regions;' ...
  'mm1 = box_cat(mm,ibox_1);' ...
  'mm2 = box_cat(mm,ibox_2);' ...
  'mm3 = box_cat(mm,ibox_3);' ...
  'tm_mm1 = box_cat(tm_mm,ibox_1);' ...
  'tm_mm2 = box_cat(tm_mm,ibox_2);' ...
  'tm_mm3 = box_cat(tm_mm,ibox_3);' ...
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

  case 'tm_m_dist'
  name = [model_name,'_',name];
%  Z = .
    
  case 'tm_m_dist_1'
  name = [model_name,'_',name];

  case 'tm_m_dist_full'

  ccsm3_Z1 = catsheet(ccsm3_mm1,ccsm3_tm_mm1);
  ccsm3_Z3 = catsheet(ccsm3_mm3,ccsm3_tm_mm3);
  hadgem1_Z1 = catsheet(hadgem1_mm1,hadgem1_tm_mm1);
  hadgem1_Z3 = catsheet(hadgem1_mm3,hadgem1_tm_mm3);
  era40_Z1 = catsheet(era40_mm1,era40_tm_mm1);
  era40_Z3 = catsheet(era40_mm3,era40_tm_mm3);
  ncep_doe_Z1 = catsheet(ncep_doe_mm1,ncep_doe_tm_mm1);
  ncep_doe_Z3 = catsheet(ncep_doe_mm3,ncep_doe_tm_mm3);

  Z = catsheet(ccsm3_Z1,hadgem1_Z1,era40_Z1,ncep_doe_Z1, ...
               ccsm3_Z3,hadgem1_Z3,era40_Z3,ncep_doe_Z3);

end
% ----------------------------------------------------------------------

%% call plot_hist2_panels

plot_hist2_panels(Z,opt_hist,name,out_format);
% ----------------------------------------------------------------------

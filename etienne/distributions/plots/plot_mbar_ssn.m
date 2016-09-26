% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_mbar_ssn.m
%
% --> plot_6panels.m <--
%
% mbar seasonal cycle:
% Monthly mbar for all 3 summer months, 
% 2 GCMs and 2 Reanalysis separately.
%
% ======================================================================

out_format = 'png';
%out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;
units = 'mm';

cvec = [0:2:40]; 
opt_x_cvec = 'above';
color_handle = @color_mydusk;
bins = [0:0.5:50]; 
yval = 0.1;

% for startup_other 
vars_req = {'lon','lat','mbar','mbar_1','mbar_2','mbar_3'};
comp_cmd = [ ...
  'mbar_1 = sqz(mbar(1,:,:));' ... 
  'mbar_2 = sqz(mbar(2,:,:));' ...
  'mbar_3 = sqz(mbar(3,:,:));' ...
  ];
models_startup = {'ccsm3','ncep_doe','hadgem1','era40'};

% for plot_6panels
vars_plot = {'mbar_1','mbar_1','mbar_2','mbar_2','mbar_3','mbar_3'};
% ----------------------------------------------------------------------

%% Call startup_other.m to get the (4) data sets 
Nvar_req = length(vars_req);
eval(comp_cmd);

for i_model=1:4

  % next model to load
  next_model_name = char(models_startup(i_model));

  % fill up `vars_req_str' for upcoming strcmp
  vars_req_str = repmat({''},Nvar_req,1);
  for j=1:Nvar_req;
    vars_req_str{j} = [next_model_name,'_',char(vars_req(j))];
  end
  
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

%% 1) ccsm3 and hadgem1, for plot_6panels.m
name = 'gcms_mbar_ssn';
models_plot={'ccsm3','hadgem1','ccsm3','hadgem1','ccsm3','hadgem1'};

% call plot_6panels.m
plot_6panels
% ----------------------------------------------------------------------

%% 2) ncep_doe and era40, for plot_6panels.m
name = 'rean_mbar_ssn';
models_plot={'ncep_doe','era40','ncep_doe','era40','ncep_doe','era40'};

% call plot_6panels.m
plot_6panels
% ----------------------------------------------------------------------

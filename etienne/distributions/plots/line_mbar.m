% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% line_mbar.m
%
% annual cycle line plot of mbar for the 'box_regions' and using the 4
% datasets.
%
% ======================================================================

% for plot_line.m
out_format = 'png';
opt_plot_line = 'full';
name = 'mbar';
ylab = 'mbar [mm]';
yvals = [5,44];

% for startup_other.m
vars_req = {'mfull1','mfull2'};
comp_cmd = [ ...
  'mfull = getnewvar(''mrsos'',[],[1,12]);' ...
  'box_regions;' ...
  'mfull1 = box_avg(mfull,ibox_1);' ...
  'mfull2 = box_avg(mfull,ibox_2);' ...
  ];
models_startup = {'ccsm3','ncep_doe','hadgem1','era40'};
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

%% Call plot_line.m

Y1 = catsheet(ccsm3_mfull1,ncep_doe_mfull1,hadgem1_mfull1,era40_mfull1);
plot_line(Y1,[],opt_plot_line,ylab,yvals,[name,'_box1']);

Y2 = catsheet(ccsm3_mfull2,ncep_doe_mfull2,hadgem1_mfull2,era40_mfull2);
plot_line(Y2,[],opt_plot_line,ylab,yvals,[name,'_box2']);
% ----------------------------------------------------------------------


break

Y = test;
plot_line(Y,'',ylab,yvals,name);

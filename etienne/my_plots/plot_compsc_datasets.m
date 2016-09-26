%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_compsc_datasets.m
%
% Automating procedure for datasets comparisons 4 panel/hist plots.
%
% Specifically it:
%
% 1) loops through all datasets 
% 2) calls plot_sc_4panels 
%
% ======================================================================
%
% Variables to specify:
%
%   vars_req (cell array of variable names to keep for all models),
%   *** vars_req{1}=$coords_plot*(1) and vars_req{2}=$coords_plot(2)
%
%   comp_cmd (string which includes all commands to be executed for
%   all datasets)
%
%   name_add (output syntax is ['comp_sc',$name_add,'_',$var_req(i)]) 
%   
%   cvec, opt_x_cvec, color_handle, units (for plot_sc_4panels)
%
%   case_cmd (string for switch statement involving vars_req-dependent
%   cvec, opt_x_cvec, color_handle, units)
%   e.g. case_cmd = 'case 1; cvec = [1:2:10]; case 2; cvec = [ ...];';
%
%   out_format ('png' or 'eps')
%   opt_frame_col (0 or 1, [] -> 0)
% ======================================================================


% Default setting for plot_sc_4panels.m
models_plot = {'ccsm3','ncep_doe','hadgem1','era40'};
annotate_text = {'CCSM3.0','NCEP-DOE','HadGEM1','ERA40'};
coords_plot = {vars_req{1},vars_req{2}};

% Get number of 'required variables' and with and w/o `coords_plot'
Nvar_req = length(vars_req);
Nvar_req_plot = Nvar_req-2;
% ----------------------------------------------------------------------

%% Evaluate `comp_cmd' a first time, if needed

% fill up `vars_req_str' for upcoming strcmp
vars_req_str = repmat({''},Nvar_req,1);
for j=1:Nvar_req;
  vars_req_str{j} = [model_name,'_',char(vars_req(j))];
end
if ~all(ismember(vars_req_str,who));
  eval(comp_cmd);
end
% ----------------------------------------------------------------------

%% Call startup_other.m to get other (4) data sets 

for i_model=1:4

  % next model to load
  next_model_name = char(models_plot(i_model));

  % fill up `vars_req_str' for upcoming strcmp
  vars_req_str = repmat({''},Nvar_req,1);
  for j=1:Nvar_req;
    vars_req_str{j} = [next_model_name,'_',char(vars_req(j))];
  end
  
  % call startup_other.m if variable in `vars_req_str' do not exists
  if ~all(ismember(vars_req_str,who));
    startup_other; 
    
    % Evaluate `comp_cmd'
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

%% Call plot_4panels.m and plot_hist2.m

% loop through the non-`lon' `lat' required variable for plotting
for i=1:Nvar_req_plot
  
  % $i'th vars_req for plotting
  var_req = char(vars_req(i+2));

  % only 1 entry in `vars_plot', here, for plot_4panels
  vars_plot = {var_req};

  % set output name
  if ~exist('name_add') || isempty(name_add)
    name = ['compsc_',var_req];
  else
    name = ['compsc_',name_add,'_',var_req];
  end

  % set cvec, opt_x_cvec, color_handle, bins, yval with `case_cmd'
  if exist('case_cmd') && ~isempty(case_cmd)
    tmp_case_cmd = ['switch i;',case_cmd,'end'];
    eval(tmp_case_cmd)
    clear tmp_case_cmd
  end

  %%% call plotting procedure
  plot_sc_4panels;

end
% ----------------------------------------------------------------------

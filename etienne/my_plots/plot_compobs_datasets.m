%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_compobs_datasets.m
%
% ## Based on plot_comp_datasets.m 
%
% Automating procedure for datasets comparisons 5 panel/hist plots.
%
% Specifically it:
%
% 1) loops through all datasets 
% 2) calls plot_5panels 
% 3) plot_hist2.m  
%
% *** Important! Note that the `obs_' fields are computed at the
% resolution of the hadgem1 (for simplicity, until a new 'land_only.m'
% procedure comes online).
%
% *** (06/10) plot_hist2.m cannot output 5 lines, so `obs_' are
% omitted. Are histograms useful here?
%
% ======================================================================
%
% Variables to specify:
%
%   vars_req (cell array of variable names to keep for all models),
%   *** it must have vars_req{1}='lat' and vars_req{2}='lon'.
%
%   *** as of (06/07) all variable in vars_req must 2D (for the
%   plot_hist2.m call).
%
%   comp_cmd (string which includes all commands to be executed for
%   all datasets)
%
%   obs_cmd (string which includes the observation-specific commands)
%
%   name_add (output syntax is ['compobs_',$name_add,'_',$var_req(i)]) 
%   
%   cvec, opt_x_cvec, color_handle, units (for plot_4panels)
%   *** all of which can have 1 or multiple sheets (shortly ...)
%
%   bins, yval (for plot_hist2)
%   *** all of which can have 1 or multiple sheets (shortly ...)
%
%   out_format ('png' or 'eps')
%   opt_frame_col (0 or 1, [] -> 0)
%
%   (06/04) what to do with 'opt_overlay' ???
% ======================================================================

%% *** Important: do not include 'obs' for startup_other loop.
models_plot = {'ccsm3','ncep_doe','hadgem1','era40'};

% Default setting for plot_4panels.m
annotate_text = {'U. Del','CCSM3.0','NCEP-DOE','HadGEM1','ERA40'};

% Get number of 'required variables' and with and w/o `lat' & `lon'
Nvar_req = length(vars_req);
Nvar_req_plot = Nvar_req-2;
% ----------------------------------------------------------------------

%% Print and evaluate `comp_cmd' (and `cmd_obs') a first time
eval(comp_cmd);
if strcmp(model_name,'hadgem1')
  eval(obs_cmd);
  obs_lon = lon;
  obs_lat = lat;
end
% ----------------------------------------------------------------------

%% Call startup_other.m to get other (4) data sets (and observations) 

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
    
    % Print and evaluate `comp_cmd'
    eval(comp_cmd);

    % get observation at the resolution of the hadgem1 
    if strcmp(model_name,'hadgem1')
      eval(obs_cmd);
      obs_lon = lon;
      obs_lat = lat;
    end

%    if i_model==4
      % one more round of relabeling (an artifact of startup_other)
      for i=1:Nvar_req

        var_req = char(vars_req(i));
        disp(['Relabeling ... ',var_req, ...
              ' --> ',model_name,'_',var_req,';']); 
        cmd=[model_name,'_',var_req,'=',var_req,';'];
        eval(cmd);

      end

%    end

  end

end
% ----------------------------------------------------------------------

%% *** Important: include 'obs' for plot_5panels call
models_plot = {'obs','ccsm3','ncep_doe','hadgem1','era40'};

%% Call plot_5panels.m and plot_hist2.m

% loop through the non-`lon' `lat' required variable for plotting
for i=1:Nvar_req_plot
  
  % $i'th vars_req for plotting
  var_req = char(vars_req(i+2));

  % only 1 entry in `vars_plot', here, for plot_4panels
  vars_plot = {var_req};

  % set output name
  if ~exist('name_add') || isempty(name_add)
    name = ['compobs_',var_req];
  else
    name = ['compobs_',name_add,'_',var_req];
  end

  % set cvec, opt_x_cvec, color_handle
  if size(cvec,1) > 1
    tmp_cvec = cvec;
    cvec = cvec(i,:);
    tmp_opt_x_cvec = opt_x_cvec;
    opt_x_cvec = opt_x_cvec(i,:);
    tmp_color_handle = color_handle;
    color_handle = color_handle(i,:);
  end

  % set bins, yval
  if exist('bins') 
    if size(bins,1) > 1
      tmp_bins = bins;
      bins = bins(i,:);
      tmp_yval = yval;
      yval = yval(i,:);
    end
  end

  % define 'vars_req_cat' for plot_hist2.m 
  % without 'obs'
  % maybe add a 'sqmean' for 3D input var_req
  cmd = '';
  for j=2:5;
    cmd = [cmd,models_plot{j},'_',var_req,','];
  end
  cmd = cmd(1:end-1);
  eval(['vars_req_cat = catsheet(',cmd,');']);
  
  %%% call `plot_5panels.m'
  plot_5panels;

  %%% call `plot_hist2.m', if options are defined
  if exist('bins') && exist('yval')
    plot_hist2(vars_req_cat,bins,[],name,yval,out_format);
  end

  % reset cvec, opt_x_cvec, color_handle
  if size(cvec,1) > 1
    cvec = tmp_cvec;
    opt_x_cvec = tmp_opt_x_cvec;
    color_handle = tmp_color_handle;
  end

  % reset bins, yval
  if exist('bins') 
    if size(bins,1) > 1
      bins = tmp_bins;
      yval = tmp_yval;
    end
  end

end
% ----------------------------------------------------------------------

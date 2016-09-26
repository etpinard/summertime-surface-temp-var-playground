% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% startup_other.m
%
% Procedure which extracts data from the "other" GCM not extracted 
% by startup.m
%
% Required inputs: `vars_req' cell array including names of variables
%                   to be kept from both GCM outputs.
%
%                   `next_model_name' next model to call
%                   startup_full.m with.
% 
% ======================================================================


%% Number of required variables for computation in the folder
Nvar_req = length(vars_req);
% ----------------------------------------------------------------------

%% label the existing field neededs (for now)

for i=1:Nvar_req

  var_req = char(vars_req(i));

  if exist(var_req)
    disp(['Relabeling ... ',var_req,' --> ',model_name,'_',var_req,';']); 
    cmd=[model_name,'_',var_req,'=',var_req,';'];
    eval(cmd);
  end 

end
% ----------------------------------------------------------------------

%% Set the 'next' model name to `model_name'
model_name = next_model_name;
% ----------------------------------------------------------------------

%% Set opt_vars_load if does not exist
if ~exist('opt_vars_load')
  opt_vars_load = 'all'; end
% ----------------------------------------------------------------------

%% Clear $vars and $vars_req
for i=1:Nvar
  cmd=['clear ',char(vars(i))];
  eval(cmd); end

for i=1:Nvar_req
  cmd=['clear ',char(vars_req(i))];
  eval(cmd); end
% ----------------------------------------------------------------------

%% Call startup_full !

[vars_full,vars,Nvar] = startup_vars(opt_vars_load,model_name);
[trim_opt,m_range] = startup_thres(model_name);		
startup_full;
% ----------------------------------------------------------------------

% ----------------------------------------------------------------------

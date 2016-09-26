% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_aero.m
%
% Use plot_2panels.m on ../aero_resistance.m
% 
% ======================================================================

models_plot = {'ccsm3','hadgem1'};
out_format = 'png';
cvec = [0:0.2:1.4];
opt_x_cvec = 'add_both';
color_handle = [];
opt_overlay = 0;
annotate_text = {'CCSM3','HadGEM1'};
opt_frame_col = 1;
bins = [-1,1];

vars_req = {'lon','lat','coefvar_C'};
Nvar_req = length(vars_req);
% ----------------------------------------------------------------------

% Call aero_resistance a first time
opt_plot = 0;
aero_resistance
% ----------------------------------------------------------------------

% Set-up `startup_other' call
if strcmp(model_name,'ccsm3')
  next_model_name = 'hadgem1';
else
  next_model_name = 'ccsm3';
end

tmp = repmat({''},Nvar_req,1);
for j=1:Nvar_req;
  tmp{j} = [next_model_name,'_',char(vars_req(j))]; end

if ~all(ismember(tmp,who));
  startup_other; 
  clear Hs Tsk V
  aero_resistance

  for i=1:Nvar_req
    var_req = char(vars_req(i));
    disp(['Relabeling ... ',var_req,' --> ',model_name,'_',var_req,';']); 
    cmd=[model_name,'_',var_req,'=',var_req,';'];
    eval(cmd);
  end

end
% ----------------------------------------------------------------------

% Call plot_2panels or plot_3panels (need to implement multiple models)
name = 'coefvar_aero';
vars_plot = {'coefvar_C'};
%vars_plot = {'ccsm3_coefvar_C','hadgem1_coefvar_C','coefvar_Cd'};
plot_2panels;
%plot_3panels;
% ======================================================================


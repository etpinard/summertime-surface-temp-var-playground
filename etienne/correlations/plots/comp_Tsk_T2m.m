% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_Tsk_T2m.m
%
% plot_4panels.m of all data sets for correlations involving (Tsk_T2m).
%
% ======================================================================

% plot_4panels and plot_hist2.m required fields, for all plots!

models_plot = {'ccsm3','ncep_doe','hadgem1','era40'};
out_format = 'png';
%out_format = 'eps';
cvec = [-1:0.1:1];
opt_x_cvec = [];
color_handle = @color_corr4;
opt_overlay = 0;
annotate_text = {'CCSM3','NCEP-DOE','HadGEM1','ERA40'};
opt_frame_col = 1;
bins = [-1,1];
yval = 4;
% ----------------------------------------------------------------------

%% Call corr_depind.m for computations (instantaneous and summer-avg.)
if ~exist('Tsk') || ~exist('DeltaTDeltaT')
  [Tsk,Tskbar,TskTsk,sig_Tsk] = getnewvar('ts');
  DeltaT = Tsk-T;
  [DeltaTbar,DeltaTDeltaT,sig_DeltaT] = anomaly(DeltaT);
end

var_dep = 'DeltaT';
vars_ind = {'F','E','P','F0','T','m','Hs'};
vars_req = {'lon','lat', ...
            'Cor_DeltaTF','Cor_DeltaTE', ...
            'Cor_DeltaTP','Cor_DeltaTF0', ...
            'Cor_DeltaTT','Cor_DeltaTm','Cor_DeltaTHs'};
opt_corlag = 0; 
corr_depind;      % use Cor_* , the summer-avg correlations.
% ----------------------------------------------------------------------

%% Call startup_other.m to get other data sets 
%% (would be hard to put in a separate procedure ...)
Nvar_req = length(vars_req);

for i_model=1:4

  next_model_name = char(models_plot(i_model));

  tmp = repmat({''},Nvar_req,1);
  for j=1:Nvar_req;
    tmp{j} = [next_model_name,'_',char(vars_req(j))]; end
   
  if ~all(ismember(tmp,who));
    startup_other; 

    [Tsk,Tskbar,TskTsk,sig_Tsk] = getnewvar('ts');
    DeltaT = Tsk-T;
    [DeltaTbar,DeltaTDeltaT,sig_DeltaT] = anomaly(DeltaT);
    corr_depind;      

  % one more round of relabeling
  for i=1:Nvar_req
    var_req = char(vars_req(i));
    disp(['Relabeling ... ',var_req,' --> ',model_name,'_',var_req,';']); 
    cmd=[model_name,'_',var_req,'=',var_req,';'];
    eval(cmd);
  end

  end

end
% ----------------------------------------------------------------------

%% Call plot_4panels.m and plot_hist2.m

% names of variables to be plotted
for i=1:Nvar_ind
  
  name = ['comp_corr_Tsk-T2m-', char(vars_ind(i))];
  vars_plot = {['Cor_DeltaT',char(vars_ind(i))]};
  plot_4panels;
  plot_hist2(catsheet(z11,z12,z21,z22),bins,[],name,yval,out_format);

end
% ----------------------------------------------------------------------

% ======================================================================

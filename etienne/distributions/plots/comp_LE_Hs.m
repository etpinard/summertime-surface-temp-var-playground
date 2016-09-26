% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_LE_Hs.m
%
% plot_4panels.m of all data sets. 
%
% Coefficient of variation of the latent + sensible heat flux
%
% ======================================================================

% plot_4panels and plot_hist2.m required fields, for all plots!

models_plot = {'ccsm3','ncep_doe','hadgem1','era40'};
out_format = 'png';
%out_format = 'eps';
cvec = [0:0.05:0.8];
opt_x_cvec = 'above';
color_handle = [];
opt_overlay = 0;
annotate_text = {'CCSM3','NCEP-DOE','HadGEM1','ERA40'};
opt_frame_col = 1;
bins = [-0.1,0.8];
yval = 17;

vars_req = {'lon','lat','LE_Hs_coefvar','E_coefvar','Hs_coefvar'};
% ----------------------------------------------------------------------

%% Compute regression fraction
[tmpbar,junk1,tmptmp] = anomaly(L*E+Hs);
LE_Hs_coefvar = sqmean(abs(tmptmp./tmpbar));
E_coefvar = sqmean(abs(sig_E./Ebar));
Hs_coefvar = sqmean(abs(sig_Hs./Hsbar));
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
    [tmpbar,junk1,tmptmp] = anomaly(L*E+Hs);
    LE_Hs_coefvar = sqmean(abs(tmptmp./tmpbar));
    E_coefvar = sqmean(abs(sig_E./Ebar));
    Hs_coefvar = sqmean(abs(sig_Hs./Hsbar));

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
for i=1:length(vars_req)-2
  
  name = [char(vars_req(i+2))];
  vars_plot = {[char(vars_req(i+2))]};
  plot_4panels;
  plot_hist2(catsheet(z11,z12,z21,z22),bins,[],name,yval,out_format);

end
% ----------------------------------------------------------------------

% ======================================================================

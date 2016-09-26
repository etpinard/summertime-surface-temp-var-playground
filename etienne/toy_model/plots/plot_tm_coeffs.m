% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_tm_coeffs.m
%
% --> plot_sc_miller.m <--
%
% Side-by-side scatter and miller map of the toy model coefficients.
%
% For cross-datasets comparisons, see comp_tm_coeffs.m or
% comp_tm_coeffs.m
%
% ======================================================================

%%% Select dataset
model_plot = 'hadgem1';
%model_plot = 'era40';
% ----------------------------------------------------------------------

%%% output alternative coeffs, or not
opt_tilde = 1;
% ----------------------------------------------------------------------

% Options for all outputs

out_format = 'both';
opt_overlay = 0;
color_handle = @color_coeffs;

vars_plot = {'mbar','Tbar','lon','lat', ...
             'gamma','lambda','chi','beta', ...
             'nu_s', ...
             'chi_tilde','gamma_tilde','eta'};
coords_plot = {'mbar','Tbar'};
% ----------------------------------------------------------------------

% get data

if ~strcmp(model_name,model_plot)
  
  next_model_name = model_plot;
  vars_req = {};
  startup_other;

end

tmp_str = relabel(vars_plot,model_plot);
if ~all(ismember(tmp_str,who))
  tm_param_full;
  nu_s = nu_s*secinday;
  for i=1:length(vars_plot)
    var_plot = char(vars_plot(i));
    disp(['Relabeling ... ',var_plot,' --> ', ...
            model_name,'_',var_plot,';']); 
    cmd=[model_name,'_',var_plot,'=',var_plot,';'];
    eval(cmd);
  end
end
% ----------------------------------------------------------------------

%% gamma

var_plot = 'gamma';
cvec=[0:4:24];
cvec=[0:5:25];
opt_x_cvec='above';
units='[W m-2 K-1]';

name = var_plot;
annotate_text = {'',var_plot};
%plot_sc_miller;
% ----------------------------------------------------------------------

%% lambda

var_plot = 'lambda';
cvec=[0:0.1:0.6]; 
cvec=[0:0.2:0.8]; 
opt_x_cvec='above';
units='[-]';

name = var_plot;
annotate_text = {'',var_plot};
%plot_sc_miller;
% ----------------------------------------------------------------------

%% chi

var_plot = 'chi';
cvec=[-0.75:0.25:0.75];
cvec=[-0.8:0.2:0.8];
opt_x_cvec='add_both';
units='[-]';

name = var_plot;
annotate_text = {'',var_plot};
%plot_sc_miller;
% ----------------------------------------------------------------------

%% beta

var_plot = 'beta';
cvec=[-0.1:0.1:0.8];
cvec=[0:0.2:0.8];
opt_x_cvec='add_both'; 
units='[-]';

name = var_plot;
annotate_text = {'',var_plot};
%plot_sc_miller;
% ----------------------------------------------------------------------

%% nu_s

var_plot = 'nu_s';
cvec=[0:0.2:0.8];
opt_x_cvec='add_both'; 
units='[day-1]';

name = var_plot;
annotate_text = {'',var_plot};
%plot_sc_miller;
% ----------------------------------------------------------------------

%% gamma_tilde

var_plot = 'gamma_tilde';
cvec=[0:4:24];
cvec=[0:5:25];
opt_x_cvec='above';
units='[W m-2 K-1]';

name = var_plot;
annotate_text = {'',var_plot};
%plot_sc_miller;
% ----------------------------------------------------------------------

%% chi_tilde

var_plot = 'chi_tilde';
cvec=[-0.75:0.25:0.75];
cvec=[-0.8:0.2:0.8];
opt_x_cvec='add_both';
units='[-]';

name = var_plot;
annotate_text = {'',var_plot};
%plot_sc_miller;
% ----------------------------------------------------------------------

%% eta

var_plot = 'eta';
cvec=[0:0.1:0.6]; 
cvec=[0:0.2:0.8]; 
opt_x_cvec='above';
units='[-]';

name = var_plot;
annotate_text = {'',var_plot};
%plot_sc_miller;
% ----------------------------------------------------------------------

%% in Fbar-Pbar space

% i) lambda, beta, nu_s, chi
name = 'scFP_lambda_beta_nus_chi';
coords_plot = {'Pbar','Fbar'};
out_format = 'both';
vars_plot = {'lambda','beta','nu_s','chi'};
annotate_text = vars_plot;
models_plot = [];
cvec=[-0.8:0.2:0.8];
opt_x_cvec='add_both';
units='[-]';
%plot_sc_4panels;

% ii)
name = 'sc_FP_gamma';
cvec=[0:5:25];
opt_x_cvec='above';
units='[W m-2 K-1]';

%plot_scatter_ccols(Pbar,Fbar,gamma, ...
%  cvec,opt_x_cvec,{'Pbar-Fbar','gamma'}, ...
%  [name,'.png'],color_handle,units);
%plot_scatter_ccols(Pbar,Fbar,gamma, ...
%  cvec,opt_x_cvec,{'Pbar-Fbar','gamma'}, ...
%  [name,'.eps'],color_handle,units);
% ----------------------------------------------------------------------

% **) plots for presentation
name = 'sc_lambda';
cvec=[0:0.2:0.8]; 
opt_x_cvec='above';
units='[-]';

plot_scatter_ccols(mbar,Tbar,lambda, ...
  cvec,opt_x_cvec,{'mbar-Tbar','lambda'}, ...
  [name,'.png'],color_handle,units);
plot_scatter_ccols(mbar,Tbar,lambda, ...
  cvec,opt_x_cvec,{'mbar-Tbar','lambda'}, ...
  [name,'.eps'],color_handle,units);

name = 'sc_chi';
cvec=[-0.8:0.2:0.8];
opt_x_cvec='add_both';
units='[-]';

plot_scatter_ccols(mbar,Tbar,chi, ...
  cvec,opt_x_cvec,{'mbar-Tbar','chi'}, ...
  [name,'.png'],color_handle,units);
plot_scatter_ccols(mbar,Tbar,chi, ...
  cvec,opt_x_cvec,{'mbar-Tbar','chi'}, ...
  [name,'.eps'],color_handle,units);
% ----------------------------------------------------------------------

% ======================================================================

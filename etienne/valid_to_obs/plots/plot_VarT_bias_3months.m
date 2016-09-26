% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_VarT_bias_3months.m
%
% Var(T) bias w.r.t to observation for all 3 summer months
%
% ======================================================================

% plot_3panels required fields

name = 'bias_Var_T';
models_plot = [];
out_format = 'png';
cvec = [-1:0.25:3]; 
opt_x_cvec = 'above';
color_handle = @color_posbias2;
opt_overlay = 0;
annotate_text = {'Jun/Dec','Jul/Jan','Aug/Feb'};
opt_frame_col = 1;
bins = [-0.9:0.1:3];
yval = 3.5;

% names of variables to be plotted
vars_plot = {'bias_Var_T1','bias_Var_T2','bias_Var_T3'};
% ----------------------------------------------------------------------

%% Compute relative bias using bias.m
bias_Var_T = bias(Var_T,Var_Tob);

%% squeeze out each month
bias_Var_T1 = sqz(bias_Var_T(1,:,:));
bias_Var_T2 = sqz(bias_Var_T(2,:,:));
bias_Var_T3 = sqz(bias_Var_T(3,:,:));
% ----------------------------------------------------------------------

% Call plot_3panels.m or plot_4panels.m
plot_3panels;
plot_hist2(addsheet(bias_Var_T1,bias_Var_T2,bias_Var_T3), ...
            bins,[],[model_name,'_',name],yval,out_format);
% ======================================================================

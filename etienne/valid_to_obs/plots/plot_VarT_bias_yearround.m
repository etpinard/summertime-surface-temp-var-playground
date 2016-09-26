% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_VarT_bias_yearround.m
%
% --> plot_6panels.m <--
%
% Monthly Var(T) bias for all months of the year.
%
% As before, the SH has a -6 month lag on the NH (i.e. the NH lags the
% SH by 6 months), see summer_only.m .
%
% The output is split into 2 6-panel figures.
%
% ======================================================================

out_format = 'png';
%out_format = 'eps';
opt_frame_col = 0;
opt_overlay = 0;
units = '[-]';

cvec = [-1:0.25:3]; 
opt_x_cvec = 'above';
color_handle = @color_posbias2;

% for 1)
vars_plot1 = {'bias_VarT1','bias_VarT4', ... 
              'bias_VarT2','bias_VarT5', ...
              'bias_VarT3','bias_VarT6'};
% for 2)
vars_plot2 = {'bias_VarT7','bias_VarT10' ... 
              'bias_VarT8','bias_VarT11', ...
              'bias_VarT9','bias_VarT12'};
% ----------------------------------------------------------------------

%% Loop through the 12 months of the year

% option for ../get_obs/get_obs_T.m
opt_no_anom = 1;

if ~all(ismember(vars_plot1,who)) || ~all(ismember(vars_plot2,who))
  for i=1:12
    
    % month by month
    only_m1 = i;
    only_m2 = i;

    % extract T and compute Var(T) of $model_name at month $i
    Ti = getnewvar('tas','',[only_m1,only_m2]);
    Var_Ti = sqz(var(Ti));

    % extract Tob, compute Var(Tob) of observation at month $i
    get_obs_T;
    Var_Tobi = sqz(var(Tob));

    % compute bias, eval to name as in `vars_plot'
    cmd = ['bias_VarT',num2str(i),' = bias(Var_Ti,Var_Tobi);'];
    eval(cmd);

  end
end
% ----------------------------------------------------------------------

% 1) From Jan in NH / Jul in SH
name = 'VarT_bias_1-6';
models_plot = [];       % before each plot_6panel call
vars_plot = vars_plot1;
annotate_text = {'Jan/Jul','Apr/Oct', ...
                 'Feb/Aug','May/Nov', ...
                 'Mar/Sep','Jun/Dec'};
plot_6panels;
% ----------------------------------------------------------------------

% 2) From Jul in NH / Jan in SH
name = 'VarT_bias_7-12';
models_plot = [];       % before each plot_6panel call
vars_plot = vars_plot2;
annotate_text = {'Jul/Jan','Oct/Apr', ...
                 'Aug/Feb','Nov/May' ...
                 'Sep/Mar','Dec/Jun'};
plot_6panels;
% ----------------------------------------------------------------------

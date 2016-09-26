% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_tm_param.m
%
% --> plot_comp_datasets.m <--
%
% Cross-datasets comparison of toy model parameterization
% performance (taken from tm_param_full.m).
%
% Performance is quantified with the 'fraction of variance explained'
% using `Var_expl.m'.
%
% ======================================================================

%name_add = '';
out_format = 'both';
opt_overlay = 0;
opt_frame_col = 0;

%cvec = [0:0.2:1];
%cvec = [0:0.1:1];
cvec = [0,0.3:0.1:1];
opt_x_cvec = '[]';
units = '[-]';
color_handle = @color_Var_expl;
%bins = [0:0.05:1];
%yval = 6;

comp_cmd = [ ...
  'tm_param_full;' ...
  'Res_E = Var_expl(E00E00,Var_E);' ...
  'Res_Hs = Var_expl(Hs00Hs00,Var_Hs);' ...
  'Res_Flu = Var_expl(Flu0Flu0,Var_Flu);' ...
  'Res_xiU = Var_expl(xiU0xiU0,Var_xiU);' ...
  'Res_R = Var_expl(R0R0,Var_R);' ...
  'Res_xim = Var_expl(xim00xim00,Var_xim);' ...
  ];

vars_req = {'lon','lat', ...
            'Res_E','Res_Hs', ...
            'Res_Flu','Res_xiU', ... 
            'Res_R','Res_xim'};

%comp_cmd = [ ...
%  'tm_param_full;' ...
%  'Res_E = Var_expl(E00E00,Var_E);' ...
%  ];
%vars_req = {'lon','lat','Res_E'};
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m

plot_comp_datasets;
% ----------------------------------------------------------------------

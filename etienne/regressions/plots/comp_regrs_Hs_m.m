% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_regrs_Hs_m.m
%
% --> plot_comp_datasets.m <--
%
% Cross-datasets comparison of fraction of H_s' variance explained by
% a regression onto m'.
%
% ======================================================================

%name_add = '';
out_format = 'both';
opt_overlay = 0;
opt_frame_col = 0;
units = '[-]';

cvec = [0,0.3:0.1:1];
opt_x_cvec = [];
color_handle = @color_Var_expl;

% regression command
comp_cmd = [ ...
  '[a_m,tmp] = regrs(HsHs,mm);' ...
  'Res_Hs_m = Var_expl(tmp,Var_Hs);' ...
]; 

vars_req = {'lon','lat','Res_Hs_m'};
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m

plot_comp_datasets;
% ----------------------------------------------------------------------

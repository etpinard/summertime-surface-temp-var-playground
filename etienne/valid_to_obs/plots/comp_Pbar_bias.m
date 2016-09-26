% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_Pbar_bias.m
%
% --> plot_comp_datasets.m <--
%
% Summertime Pbar bias ratio w.r.t U. of Delaware observations.
%
% ======================================================================

% name_add = '';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;
units = '[-]';

cvec = [0,0.25,0.5,0.8,0.9,1,1.1,1.25,2,4];   
opt_x_cvec = 'above';
color_handle = @color_relerror;
%bins = [0,5];
%yval = 2.5;

vars_req = {'lon','lat','Pbar_bias'};
comp_cmd = [ ...
  'get_obs_P;' ...
  'den = makenan(Pobbar,''==0'');' ...
  'Pbar_bias = sqmean(Pbar./den);' ...
  ];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------

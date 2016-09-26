% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_corr_bud_res.m
%
% --> plot_comp_datasets.m <--
%
% Summertime correlations involving budget residuals.
%
% ======================================================================

% plot_4panels and plot_hist2.m required fields, for all plots!

% name_add = '';
out_format = 'both';
opt_frame_col = 0;
opt_overlay = 0;
%opt_overlay = 2;
units = '[-]';

%cvec = [-1:0.2:-0.4,0,0.4:0.2:1]; 
cvec = [-1:0.2:1];
opt_x_cvec = [];
color_handle = @color_corr;
%bins = [-1,1];
%yval = 4;

vars_req = {'lon','lat', ...
            'Cor_ximP','Cor_xiUF'};

comp_cmd = [ ...
  '[j1,Cor_ximP] = corr_inst(ximxim,PP,sig_xim,sig_P);' ...
  '[j1,Cor_xiUF] = corr_inst(xiUxiU,FF,sig_xiU,sig_F);' ...
];

% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
plot_comp_datasets;
% ----------------------------------------------------------------------

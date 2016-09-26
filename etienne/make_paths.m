%%% Procedure that sets up all the needed path to functions, 
	% procedure and data files.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Requires:  
%%	parent_dir (= [fileparts(pwd),'/'];)  of the scripts folders.
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

% Add path to the file exchange library
addpath('/home/disk/p/etienne/proj/file_exchange/');

% Add path to the m_map plotting library
addpath('/home/disk/p/etienne/proj/m_map/');

% Add path to shortcuts functions
addpath([parent_dir,'/my_shortcuts/']);

% Add path to plotting subroutines
addpath([parent_dir,'/my_plots/']);

% Set and save global plotting options in 'plotting.mat'
frame_color = [0.7,0,0; 0,0.4,0; 0,0,0.5; 0.58,0,0.83];
frame_thick = 1.75;
% more to come!

% Set latitude range for miller maps and histograms
lat_range = [-55,77];

% Set latitude and longitude range for the `opt_plot_mask' option
lat_mask = [20,65];
lon_mask = [-140,60];

save([parent_dir,'/plotting'],'frame_color','frame_thick');

% Set up path to data files (now in ~/nobackup)
datapath = '/home/disk/p/etienne/nobackup/data/';

% ======================================================================

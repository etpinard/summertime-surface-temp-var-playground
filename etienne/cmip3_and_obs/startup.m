%%% Startup file for cmip5_and_obs/ 
	%	
  % 1) Load ERA40 data (above all, to get Iland)
	% 2) Load CMIP5 ensemble 'tas_ymonvar.cdf' , 
  %     compute summer Var_T,
  %     trim to land only.
  % 3) Load U. Del observations
% ======================================================================


clear all; 
close all;		

%% Add path to parent directory and set up paths

parent_dir = [fileparts(pwd),'/'];
addpath(parent_dir);
make_paths
% ----------------------------------------------------------------------

%% Load data!

cmip5_path = [datapath,'cmip3/cmip3.mat'];
load(cmip5_path)
% ----------------------------------------------------------------------

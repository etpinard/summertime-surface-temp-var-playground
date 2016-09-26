%%% Script folder-specific startup file.
	%	
	%* 1) Selects the model			(Maybe make a prompt ... )
	%  2) Sets up the paths with make_paths.m
	%  3) Selects which variables to load with startup_vars.m
	%  4) Selects the soil-saturation criterion for trimming
	%		 with startup_thres.m
	%  5) Calls startup_full to complete the automated startup
	%
	%  *) and script folder-specific startup commands ...
% ======================================================================

clear all; 
close all;		

%	Which model output?	$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$	
%model_name = 'gfdl21';						% GFDL 2.1	
%model_name = 'ccsm3';						% NCAR CCSM 3.0
model_name = 'hadgem1';					% Hadley Centre HadGem1
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%model_name = ncep_doe; 	 % NCEP-DOE reanalysis

% Add path to parent directory using the fileparts function
parent_dir = [fileparts(pwd),'/'];
addpath(parent_dir);

% Sets up the other (e.g. plotting, data) paths with make_paths.m
make_paths

% Selects which variables to load , just T and m are sufficient here
opt_vars_load = 'obs_compare';
[vars_full,vars,Nvar] = startup_vars(opt_vars_load);	

% Selects the soil-saturation criterion for trimming
[trim_opt,m_range] = startup_thres(model_name);		

%%% Call startup_full.m
opt_anom_Var = 'no';
startup_full
% ======================================================================

%%% Some additional startup commands

% get data from the `other' GCM
get_2nd_gcm;

% get observation

% ======================================================================

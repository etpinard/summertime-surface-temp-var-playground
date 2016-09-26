function [vars_full,vars,Nvar] = startup_vars(opt,model_name)
%
% Function that generates the vars (actually, vars_old see
% anomaly_full.m) and vars_full hence a useful 
% way to keep track of variables. 
%
% In consequence, this function select which variables will be loaded
% in startup_full.m
%
%	INPUT:			opt		, string for option (more to come ...)
%							model_name , (NEW!) model_name to accommodate reanalysis
%
% OUTPUT:			vars_full	 , array of names as in NetCDF files
%							vars			 , array of names in MATLAB
%							Nvar			 , # of variables 
% ======================================================================
	
	% blank line after startup.m call
	disp('   ')

switch opt

	case 'all'

		if strcmp(model_name,'ccsm3') || strcmp(model_name,'hadgem1')

			% Name in NetCDF files
			vars_full = {'tas', ...		%  2m Temperature             		
									'mrsos', ...	%  0.1m soil moisture content 		
									'mrso', ...		%  total soil moisture content		
									'pr', ...			%  precip                     		
									'hfss', ...		%  sensible heat flux         		
									'hfls', ...		%  latent heat flux (L*E)     		
									'mrros', ...	%  0.1m runoff                		
									'mrro', ...		%  total runoff              		
									'rsus', ...		%  shortwave up               		
									'rsds', ...		%  shortwave down             		
									'rlus', ...		%  longwave up                		
									'rlds'};			%  longwave down              		
			
			% Name in MATLAB --- keep same order as vars!
			vars = {'T', ...				%  2m Temperature
							'm', ...        %  0.1m soil moisture content
							'm_f', ...      %  total (full) soil moisture content
							'P', ...        %  precip 
							'Hs', ...       %  sensible heat flux
							'E', ...        %  latent heat flux (L*E)
							'R', ...        %  0.1m runoff
							'R_f', ...			%  total (full) runoff
							'Fsu', ...      %  shortwave up
							'Fsd', ...      %  shortwave down              
							'Flu', ...      %  longwave up
							'Fld'};         %  longwave down

		elseif strcmp(model_name,'ncep_doe')

			% Name in NetCDF files
			vars_full = {'tas', ...		%  2m Temperature        
									'mrsos', ...	%	 top 10 cm, content
									'soilw', ...	%  first 10cm, volumetric
									'pr', ...			%  precip                     		
									'hfss', ...		%  sensible heat flux         		
									'hfls', ...		%  latent heat flux (L*E)     		
									'mrros', ...	%  surface runoff              		
									'rsus', ...		%  shortwave up               		
									'rsds', ...		%  shortwave down             		
									'rlus', ...		%  longwave up                		
									'rlds'};			%  longwave down              		
			
			% Name in MATLAB --- keep same order as vars!
			vars = {'T', ...				%  2m Temperature
							'm', ...				%  top 10 cm, content
							'm1', ...       %  first 7cm, volumetric
							'P', ...        %  precip 
							'Hs', ...       %  sensible heat flux
							'E', ...        %  latent heat flux (L*E)
							'R', ...        %  0.1m runoff
							'Fsu', ...      %  shortwave up
							'Fsd', ...      %  shortwave down              
							'Flu', ...      %  longwave up
							'Fld'};         %  longwave down

			disp(['$$$ m1 is the first 7cm of soil, volumetric'])

		elseif strcmp(model_name,'era40')

			% Name in NetCDF files
			vars_full = {'tas', ...		%  2m Temperature        
									'mrsos', ...	%	 top 10 cm, content
									'swvl1', ...	%  first 7cm, volumetric
									'swvl2', ...	%  first 21cm, volumetric
									'pr', ...			%  precip                     		
									'hfss', ...		%  sensible heat flux         		
									'hfls', ...		%  latent heat flux (L*E)     		
									'mrros', ...	%  surface runoff              		
									'rsus', ...		%  shortwave up               		
									'rsds', ...		%  shortwave down             		
									'rlus', ...		%  longwave up                		
									'rlds'};			%  longwave down              		
			
			% Name in MATLAB --- keep same order as vars!
			vars = {'T', ...				%  2m Temperature
							'm', ...				%  top 10 cm, content
							'm1', ...       %  first 7cm, volumetric
							'm2', ...       %  first 21cm, volumetric
							'P', ...        %  precip 
							'Hs', ...       %  sensible heat flux
							'E', ...        %  latent heat flux (L*E)
							'R', ...        %  0.1m runoff
							'Fsu', ...      %  shortwave up
							'Fsd', ...      %  shortwave down              
							'Flu', ...      %  longwave up
							'Fld'};         %  longwave down

			disp(['$$$ m1 is the first 7cm of soil, volumetric'])
			disp(['$$$ m2 is the first 21cm of soil, volumetric'])

		end
	
	case 'obs_compare'
	
		if strcmp(model_name,'ccsm3') || strcmp(model_name,'hadgem1')

			% Name in NetCDF files
			vars_full = {'tas', ...		%  2m Temperature             		
									'mrsos', ...	%  0.1m soil moisture content 		
									'mrso' ...		%  total soil moisture content		
									'pr'};				%  precip                     		

			% Name in MATLAB --- keep same order as vars!
			vars = {'T', ...				%  2m Temperature
							'm', ...        %  0.1m soil moisture content
							'm_f' ...			  %  total (full) soil moisture content
							'P'};		        %  precip 

		elseif strcmp(model_name,'ncep_doe')

			% Name in NetCDF files
			vars_full = {'tas', ...			%  2m Temperature             		
									'mrsos', ...		%  first 10 cm
									'pr'};						%  precip                     		

			% Name in MATLAB --- keep same order as vars!
			vars = {'T', ...	
							'm', ...  
							'P'};		  
			
		elseif strcmp(model_name,'era40')

			% Name in NetCDF files
			vars_full = {'tas',  ...	%  2m Temperature             		
									'mrsos', ...	%  first 10cm
									'pr'};				%  precip                     		
			
			% Name in MATLAB --- keep same order as vars!
			vars = {'T', ...				%  2m Temperature
							'm', ...        %  first 10cm
							'P'};		        %  precip 


		end

end

	% How many variables in total
	Nvar = length(vars);
	
	%	% Check if vars_full and vars line up (yah they do!)
	%flag = 0;
	%%if Nvar~=length(vars_full); 
	%	disp('vars_full and vars DO NOT LINE UP');
	%	flag = 1;
	%end
	%if flag; break; end 
	%clear flag
	
end

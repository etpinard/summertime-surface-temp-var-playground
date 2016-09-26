function [trim_opt,m_range] = startup_thres(opt)
%
% Function that selects the soil-saturation threshold
% to trim variable arrays.                            
%
%	INPUT:			opt		, string option (more to come ...)
%
% OUTPUT:		  trim_opt  , determine which of mrso or mrsos 
%														is used for the saturation criterion
%							m_range		, the accepted range of moiture values
%													i.e. values outside $m_range will be
%													trimmed in startup_full.m
% ======================================================================
	

switch opt

	case 'none'			% no trimming (for testing)
		trim_opt = 'top';
		m_range = [0,1e5];

	case 'ccsm3';		% CCSM 3.0		
		trim_opt = 'top';	
		m_range = [0,50];		
		% trim_opt = 'full';
		%m_range = [0,2000];

	case 'hadgem1'	% HadGem1

		% In this model, Greenland has basicaly no moisture 
		trim_opt = 'full';	
		m_range = [80,1e6];		

	case 'ncep_doe'			% NCEP-DOE 

    % (05/13) now w.r.t the mrsos variable!
		trim_opt = 'top';
		m_range = [0,100];

	case 'era40'			  % ERA40

    % (05/09) now w.r.t the mrsos variable!
		trim_opt = 'top';
		m_range = [0,50];

end

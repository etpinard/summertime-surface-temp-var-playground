function out = makenan(array,cond)
%
% Function that sets all entries of an array to NaNs with respect to
%	some condition (only numerical for now).
%
% INPUT:	  array , array in question	
%           cond  , condition (a string e.g. '==0' or '>1e6')
% 
% OUTPUT:		out   , array with NaNs appropriately positioned
% ====================================================================

    
    % evaluate condition on array
  eval(['nogood = find(array ' cond ');']);

    % trim array with NaNs appropriately positioned
  array(nogood) = NaN;

    % output the resulting array
  out = array;

end

function out = isinarray(val,array)
%
% Function that check whether a particular value is contained in an
% array returning a logical 1 or 0.
% As of 03/12, the function is only compatible for string 
% arrays and values.
%
% INPUT:		val   , value to be checked
%           array , array in question
% 
% OUTPUT:		out   , logical output
% ====================================================================

    % works only for strings ... for now
    % using the 'exact' option to avoid unwanted results
  tmp = strmatch(val,array,'exact');

    % output a logical
  out = ~isempty(tmp);

end

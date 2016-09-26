function [out,out_all] = exist_all(str_arr)
%
% Generalization of MATALB's `exist' command to multiple string
% inputted as a string all {'','',  }
%
% DOES NOT WORK!!!!
%
% INPUT:		str_arr , string array to check
% 
% OUTPUT:		out   , logical output
% ====================================================================

  % initializing output array 
  N = length(str_arr);
  tmp_arr = repmat(NaN,N,1);
  tmp = 1;
  
  who kappa str_arr
  out_all = ismember(str_arr,who)
  out = prod(out_all);

end

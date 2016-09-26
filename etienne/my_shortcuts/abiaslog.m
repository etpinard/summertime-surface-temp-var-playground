function err = abiaslog(X,Xtrue)
%
% Function that compute relative the base 10 logartithm of the 
% one-sided error of some X (3D or 2D) with respective to its "true" 
% value Xtrue.
%
% That is,
%
% err = log_10( | (X - Xtrue)/Xtrue | )
%
% INPUT:			X		 	, erroneous field (2D or 3D)
%             Xtrue , true field (same dimension as X)
% 
% OUTPUT:		  err   , log base 10 of relative one-sided error	
%							
% ====================================================================

    % first call abias.m
   tmp = abias(X,Xtrue);

    % flag to stout if tmp==0 somewhere
   nogood = find(tmp==0);

   if length(nogood)>=1;
     disp('$$$ abiaslog.m will output infinite values');
     %% maybe do something else with this at one point ...
   end

    % then very simply
  err = log10(tmp);


end

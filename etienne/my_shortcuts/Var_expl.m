function out = Var_expl(X0X0,Var_X)
%
%	Computes the fraction of variance explained given the regression
%	residual and the original variance.
%
% That is,
%
% out = 1 - ( <X0X0,X0X0> / Var_X ) .
%
% INPUT:      X0X0   , regression residual (Ntime x Nlat x Nlon)
%             Var_X  , original variance (Nmonth x Nlat x Nlon)
% 
% OUTPUT:     out   , fraction of variance explianed 
%                       (Nmonth x Nlat x Nlon)
%             
% ====================================================================

  % compute residual variance using anomaly_Var.m
  tmp = anomaly_Var(X0X0);

  % output fraction of variance explained
  out = 1 - tmp./Var_X;

end

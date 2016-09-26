function sig_X = anomaly_sig(XX,Nmonth)
%
% A function that computes the standard deviation of 
% X directly from its anomaly field XX.
%
%	A very useful shortcut for derived regression residuals 
% such as F0F0 and H0H0 or for product fields such as m*F.
%
% INPUT: 		XX			, anomaly field of X (Ntime x Nlat x Nlon).
%	          Nmonth  , # of months (if [], taken form 'global.mat')
%
% OUTPUT:				sig_X		, monthly standard deviation of X
%														(Nmonth x Nlat x Nlon).
% ===================================================================

  % load Nyear, via global.mat
  load('global.mat','Nyear');

  % get 'Nmonth', if undefined
  if nargin==1
    load('global.mat','Nmonth');
  end

	% using anomaly.m
	% Leading factor makes it unbiased.
	sig_X = sqrt(Nyear/(Nyear-1)*anomaly(XX.*XX,[],Nmonth));

		%% Note that the above is analytically equivalent to
	% [junk1,junk2,sig_X] = anomaly(XX);

		%% However, it is more susceptible to round off errors (I think).
		
end

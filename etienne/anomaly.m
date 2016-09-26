function [Xbar,XX,mag_XX] = anomaly(X,opt_anom_Var,Nmonth)
% 
% A function that computes the anomalies from a monthly 
% climatological record of a variable X (Ntime x Nlat x Nlon).
% Monthly climatological means are also outputted as well as
% anomaly amplitudes.
%
% Important: anomalies are computed by removing monthly means 
%            instead of removing full-summer mean.
%
%           X(time,lat,lon) = Xbar(month,lat,lVn) + XX(time,lat,lon) .
%
%           In other words, the annual cycle is removed.
%
% Notation: for a given variable X (e.g. T, m, F, ... )
%           monthly clim. mean array are denoted as Xbar.
%           anomaly fields as XX.
%           monthly standard deviation as sig_X. 
%             (i.e. computed each month separately).
%           monthly variance as Var_X (w/ an uppercase to not 
%           confuse with "var" for variable.
%
% NEW:      Option for the anomaly magnitude, put opt_anom_Var='Var'
%           for mag_XX to be the Var_X. The default option (i.e. if
%           the second argument is left blank) leads still sig_X as
%           before.
%
% 
% INPUT:    X       , variable in question, its dimension must be
%                     (Ntime x Nlat x Nlon).
%           opt_anom_Var , put ='Var' for Var_X instead of sig_X.
%           Nmonth  , # of months in sample (if undefined, 'Nmonth'
%                     from 'global.mat' is loaded). 
%
% OUTPUT:   Xbar    , monthly clim. mean values (Nmonth x Nlat x Nlon)
%           XX      , anomalies of X  (Ntime x Nlat x Nlon).
%           mag_XX  , Default: monthly std (Nmonth x Nlat x Nlon)
%                   , option: monthly variance (Nmonth x Nlat x Nlon)
% =====================================================================

% Things to improve $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
% 
% -) Make a 'full-summer' option for anomalies computed with 
%    to full-summer climatogical means.
%
% -) Add detrend step to remove interannual trends in the Xbar field
%    aaaaaaah maybe not.
%
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  

  % load 'Nyear' via global.mat
%  load('global.mat','Nyear');

  % if not specified, load 'Nmonth' from 'global.mat'
  if nargin<=2
    load('global.mat','Nmonth');
  end

  % 'Ntime' is total number of time entries in the sample
  Ntime = size(X,1);
%  Ntime = Nmonth*Nyear;

  % 'Nyear' is number of years in the sample
  Nyear = Ntime/Nmonth;

  % for compatibility in ./valid_to_obs/, get Nlat, Nlon
  Nlat = size(X,2);
  Nlon = size(X,3);

  % pre-allocating the output arrays
  tmp_Xbar = repmat(NaN,[Nmonth,Nlat,Nlon]);
  tmp_XX = repmat(NaN,[Ntime,Nlat,Nlon]);
  tmp_mag = repmat(NaN,[Nmonth,Nlat,Nlon]);

  % 1) Loop through the summer month, consider X for 
  %    each month seperatly, compute clim. mean.
    
  % reshaping column-wise with the summer month # 
  % as the first index.
  X4d = reshape(X,Nmonth,Nyear,Nlat,Nlon);

  for it=1:Nmonth     % looping through the months

    % allocating month-by-month
    tmp_X = sqz(X4d(it,:,:,:));       % (Nyear x Nlat x Nlon)

    % compute Xbar for month $it --> using sqmean.m
    % and fill tmp_Xbar array. 
    tmp_Xbar(it,:,:) = sqmean(tmp_X); % (Nmonth x Nlat x Nlon)

  end

  % outputting Xbar
  Xbar = tmp_Xbar;

  if nargout>2    % to speed things up when only Xbar is needed

    % 2) compute anomalies by first replicating
    %    tmp_Xbar $Nyear times ---> using xmonth.m
    XX = X - xmonth(tmp_Xbar,Nyear);  % (Ntime x Nlat x Nlon)
  
    if nargout==3   % to spead things up mag_XX is not needed

      % 3) Repeat step 1) but now with XX
        
      % reshaping column-wise with the summer month # 
      X4d = reshape(XX,Nmonth,Nyear,Nlat,Nlon);
  
      for it=1:Nmonth     % looping through the months
  
        % allocating month-by-month
        tmp_X = sqz(X4d(it,:,:,:));       % (Nyear x Nlat x Nlon)
  
        % compute (XX.*XX)bar for month $it --> using sqmean.m
        % and fill tmp_mag array. 
        tmp_mag(it,:,:) = sqmean(tmp_X.*tmp_X); 
                                         % (Nmonth x Nlat x Nlon)
  
      end

      % NEW! if opt_anom_Var is set to 'Var' output Var_X
      % if not (and default w/o argument), output sig_X as before.
      % Note also that both output are unbiassed estimators

      if nargin==2 && strcmp(opt_anom_Var,'Var')

        % output the variance of X
        mag_XX = Nyear/(Nyear-1)*tmp_mag;
      
      else
          
        % output the standard deviation of X
        mag_XX = sqrt(Nyear/(Nyear-1)*tmp_mag);
      
      end

    end

  end

% done.
% -------------------------------------------------------------------

  %% Detrend code from David (in ~/nobackup/david/

%   % -) second remove a possible linear trend in the anomalies
%    %  the "climate change trend" (with no breakpoints)
% for i=1:N
%   tmp = squeeze(y(:,i));    % for every location is space
%   y(:,i) = detrend(tmp);    % linear detrending
% end
%   
% %%% Make this nandetrend ... to better handle more general date sets
%   
%   % -) output with the same dimension as the original "x"
% xx = reshape(y,n1*Nyear,n2,n3);
% xbar = x -xx;
%
% % What David did
%% take out seasonal cycle
%%
%for i =1:nlat
%    for j = 1:nlon
%    dummy = reshape(squeeze(ts(:,i,j)),3,30);
%    ts(:,i,j) = reshape(dummy - repmat(mean(dummy')',1,30),1,90);
%    end
%end
%
%% detrend data
%% detrend data
%
%for i = 1:nlat
%    for j = 1:nlon
%        dummy = squeeze(ts(:,i,j));
%        yy=squeeze(ts(:,i,j));
%       locs_good = find(~isnan(yy));
%       if ~isempty(locs_good)
%
%       yd=detrend(yy(locs_good));
%       ts(locs_good,i,j)=yd;
%       else
%       end
%    end
%end

end

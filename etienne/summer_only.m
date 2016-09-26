function out = summer_only(x,m1,m2,Nyear)
% 
% A function that truncates 3-dimensional monthly-sampled arrays 
% of coordinates x(time,lat,lon) to summer only months beginning from
% "m1" in the NH or ("m1"-6) in the SH to "m2" and ("m2-"6) resp..
% 
% NOTE: "x" must have January as its first entry.
%
% This procedure can also produce "winter_only" or spring_only
% variables with the appropriate (m1,m2) pair.
% 
% EXAMPLE:    data = summer_only(data,6,8,30);
%   truncates "data" to JJA in the NH and DJF in SH for 30 years.
%
% INPUT:      x       ,  array to be truncated
%             m1      ,  first month of NH summer
%             m2      ,  last month of NH summer (m2 must be > m1)
%             Nyear   ,  how many years can the sample support both
%                     ,  NH & SH summers.
%             
% OUTPUT:     out     ,  truncated array
%                     maybe this could output Nmonth ...
% ====================================================================


  m = [m1:m2];      % the full month vector corresp. to NH summer
  Nmonth  = length(m);  

  ntime = Nyear*Nmonth;   % how many month entries after truncation

  % -) building the summer month indices
  t = [0:Nyear-1]*12;   
  tt = repmat(NaN,[Nyear,Nmonth]);
  
  for i=1:Nmonth
    tt(:,i) = t+m(i);
  end
    
  tt = tt'; tt = reshape(tt,1,ntime);   % the summer month indices
  

  % -) building the dimensions vectors
  Nlat = size(x,2); 
  
  if mod(Nlat,2)==0     % if even

    Nlat2 = Nlat/2; 
    nh = [Nlat2+1:Nlat];      % NH latitudes
    sh = [1:Nlat2];           % SH latitudes

  else                  % if odd          

    Nlat2 = floor(Nlat/2);
    nh = [Nlat2+2:Nlat];        % NH latitudes
    sh = [1:Nlat2+1];           % SH latitudes (equator in SH)

  end

  Nlon = size(x,3);

  % -) intializing the output array
  tmp = repmat(NaN,[ntime Nlat Nlon]);
  
  %%% This was (+13) in David's code ... (~/nobackup/david/)
      % e.g. for GFDL 2.1 data 
      % the first entry in the .cdf files are for January 1970
      % (+12) takes us to 1971 for 30 years of up to Decemeber 2000.

  % -) truncating "x"
  if Nyear==1           % special case if Nyear=1

    % NH 
    tmp(:,nh,:) = x(tt,nh,:);
  
    % SH
    tt_sh = tt-6;
    for i=1:length(tt_sh)
      if tt_sh(i) <= 0;
        tt_sh(i) = tt_sh(i) + 12;
      end
    end

    tmp(:,sh,:) = x(tt_sh,sh,:);

  else

    % -) skipping one year ahead in order to have 30 years set
    %    for both hemispheres
    tt = tt + 12;
  
    tmp(:,nh,:) = x(tt,nh,:);
    tmp(:,sh,:) = x(tt-6,sh,:);     % ("tt"-6) for the SH

  end

  out = tmp;                      % the output

end

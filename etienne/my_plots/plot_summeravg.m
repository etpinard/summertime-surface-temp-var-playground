%%% Procedure which facilitates the plotting of summer-averaged fields.
  % 
  % First, compute a summer-average (if needed) and then calls
  % (NEW!) plot_map_miller2.m and plot_hist.m are called 
  % successively for summer-averaged variable.
% ======================================================================
%
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%%
%% Requires: 
%%  Z (Nmonth x Nlat x Nlon).
%%  cvec (contour vector for plot_map_miller2.m)
%%  opt_x_cvec (optional, for plot_map_miller2.m) 
%%  color_handle (color map handle for plot_map_miller2.m)
%%  bins (bin vector for plot_hist.m)
%%  yval (height the yaxis for plot_hist.m)
%%  name (string for output file)
%%  opt_mean (=1 for sqrt of the mean of the squares)
%%  opt_overlay (=1 for m_Ov contour overlay on miller plots)
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  
% opt_overlay check
if ~exist('opt_overlay')
  opt_overlay = 0; end

% compute m_Ov if needed (using m_crit from startup_full.m)
if opt_overlay && ~exist('m_Ov') 
  m_Ov = (sqmean(mbar)>m_crit); end

% if opt_x_cvec does not exist, set to []
if ~exist('opt_x_cvec')
  disp('$$$ Setting opt_x_cvec to []');
  opt_x_cvec = []; end

  % Computing the summer-averaged field ---> using sqmean.m
if ndims(Z)==3;
  
    % opt_mean for sqrt of the mean of the squares
    % e.g. for stds and correlations ...
  if exist('opt_mean') && opt_mean
    z = sqrt(sqmean(Z.^2));
    
    %% Does not change much though ... at least as of now
    %% DON'T enable for correlations --> makes corr >=0 only !
  
  else 
    z = sqmean(Z);    % if not --> regular mean
  end

else
  z = Z;
end

  %% MAYBE I should make a "seasonality" index to check if 
  %% we are loosing valuable information in comparison to
  %% month-to-month analysis.

  %% (if given) add m_Ov contour (make this more general ...)
if opt_overlay

  %% Call plot_map_miller.m --- with [z,m_Ov]
%plot_map_miller(lon,lat,permute(cat(3,z,m_Ov),[3,1,2]), ...
%                   cvec,name,color_handle);  
plot_map_miller(lon,lat,permute(cat(3,z,m_Ov),[3,1,2]), ...
                    cvec,opt_x_cvec,name,color_handle); 

else

    %% Call plot_map_miller.m --- with z
  %plot_map_miller(lon,lat,z,cvec,name,color_handle); 
  plot_map_miller2(lon,lat,z,cvec,opt_x_cvec,name,color_handle);  

end

  %% Call plot_hist.m   (with an empty xlab)
plot_hist(z,bins,Nland,'',name,yval);

clear z
%clear opt_mean 
%clear opt_overlay 
  %% to keep in mind in subroutines/ plotting procedures
  %% I don't know what's optimal !!!
% ======================================================================

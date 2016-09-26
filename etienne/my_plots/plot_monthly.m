%%% Procedure which facilitates the plotting of monthly fields.
  % 
  % (NEW!) plot_map_miller2.m and plot_hist.m are called successively 
  % for the $Nmonth of a particular (Nmonth x Nlat x Nlon) variable.
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
%%  opt_overlay (=1 for m_over contour overlay on miller plots)
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

% opt_overlay check
if ~exist('opt_overlay')
  opt_overlay = 0; end

% compute m_over if needed (using m_crit from startup_full.m)
if opt_overlay && ~exist('m_over') 
  m_over = (sqmean(mbar)>m_crit); end

% if opt_x_cvec does not exist, set to []
if ~exist('opt_x_cvec')
  disp('$$$ Setting opt_x_cvec to []');
  opt_x_cvec = []; end

for it=1:Nmonth   % looping through the summer months
  
    % squeezing Z at month $i
  z = sqz(Z(it,:,:));

    % output name for month $i
  name1 = [name,'_',num2str(it)];
  
    %% (if given) add m_Ov contour (make this more general ...)
  if opt_overlay
  
    %% Call plot_map_miller.m --- with [z,m_Ov]
% plot_map_miller(lon,lat,permute(cat(3,z,m_Ov),[3,1,2]), ...
%                     cvec,name1,color_handle); 
  plot_map_miller(lon,lat,permute(cat(3,z,m_Ov),[3,1,2]), ...
                      cvec,opt_x_cvec,name1,color_handle);  
    
  else
  
      %% Call plot_map_miller.m --- with z
    %plot_map_miller(lon,lat,z,cvec,name1,color_handle);  
    plot_map_miller2(lon,lat,z,cvec,opt_x_cvec,name1,color_handle); 

  end
  
    %% Call plot_hist.m   (with an empty xlab)
  plot_hist(z,bins,Nland,'',name1,yval);
  
end

clear z name1
%clear opt_overlay
% ======================================================================

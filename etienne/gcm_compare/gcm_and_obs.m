% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% model_and_obs.m
%
% Plot GCM and observation summertime sig_T
%
% ======================================================================

%% $ Select fields to plot
% ----------------------------------------------------------------------

%% $ Select plotting options and output name
name = 'cor_E_F-P-F0';
cvec = [-1:0.1:1];
color_handle = @color_corr4;
opt_overlay = 0;
% ----------------------------------------------------------------------

%% Call corr_depind.m for computations (instantaneous and summer-avg.)
opt_corlag = 0; 
corr_depind;      % use Cor_* , the summer-avg correlations.
% ======================================================================

%% $ Select plot ordering and shift to [-180,180] grid 
[z1,x] = data_shift(lon,Cor_EF);
z2 = data_shift(lon,Cor_EP);
z3 = data_shift(lon,Cor_EF0);
y = lat;
% ----------------------------------------------------------------------


%% Plotting using the m_map set of procedures (~/proj/m_map/) more or
%% less like in plot_map_miller.m

% aesthetic options  
% (careful! theses are highly dependent on one another!!)
frame_thick = 1.75;
frame_color = [0,0,0];
splot_vsep = 0;   
cbar_pos = [0.91,0.3,0.03,0.4];     % cbar left, bottom, width, height
cbar_offset = 0.05;                 % cbar horiz. offset 
output_size = [20,30];              % output size in cm
% ----------------------------------------------------------------------

% Disable X term output	(must be 1st) & initialize subplot handle vector
FIG = figure('visible','off');   
h_sub = zeros(3,1);

% add path to custom color maps and set color map
addpath('/home/disk/p/etienne/proj/etienne/my_plots/color_maps/');
cmap = color_handle(cvec);
colormap(cmap);

% looping through the 3 ($Nvar_ind) panels 
for i=1:Nvar_ind
  
  % evaluate `z$i'
  eval(['z = z', num2str(i) ';']);

  % set panel location using subaxis.m and save handle
  % (not sure why, but set marginleft=0 for better fit)
  h_sub(i) = subaxis(Nvar_ind,1,i, ...
          'SpacingVert',splot_vsep,'MarginLeft',0);

  %% plotting algorithm: choose projection, remove grid, draw data
  %% contours and draw coast lines in black:
  m_proj('miller','lat',[lat_range(1),lat_range(2)], ...
                  'long',[x(1),x(Nlon)]);
  m_grid('xtick',[],'ytick',[], ...
          'linewidth',frame_thick,'color',frame_color);
  hold on
  m_contourf(x,y,z,cvec,'linestyle','none');
  m_coast('color',[0 0 0],'linewidth',0.75);

  % add overlay contour  
  if opt_overlay
    m_contour(x,y,o, ...
     'linestyle','-','color',[0.1,0.1,0.1],'linewidth',0.25); end

end
  
% shrink panels horizontally to make room for colorbar 
% (must be done after all panels are generated)
for i=1:Nvar_ind

  %% get position, subtract offset and cbar width, 
  %% add frame margin to the left and re-set position.
  pos = get(h_sub(i),'Position');
  new_pos = pos - [-0.005,0,cbar_offset+cbar_pos(3),0];
  set(h_sub(i),'Position',new_pos);

end

% correction to vertical spacing between panels as
% shrinking in the horizontal increases the vertical spacing
splot_correc = [0,0.3*cbar_offset,0,0];
set(h_sub(1),'Position',get(h_sub(1),'Position')-splot_correc);
set(h_sub(3),'Position',get(h_sub(3),'Position')+splot_correc);

% add color bar at the specific location --> using my_cbar.m
my_cbar(cvec,cvec,[],cbar_pos);

% set output size and print in .eps
h_fig = gcf;
set(h_fig,'paperunits','centimeters','paperpositionmode','manual');
set(h_fig,'papersize',output_size);
set(gcf,'paperposition',[0,0,output_size]);
plot_print_eps; 
%plot_print;    
close(FIG);

%% Note that the equivalent .png output features large vertical
%% margins.
% ======================================================================

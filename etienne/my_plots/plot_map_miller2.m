function plot_map_miller2(x,y,Z,cvec,opt_x_cvec,name,color_handle,units)
%
% A function that plots the 2D function "z" on a Miller projected
% world map. The grid is centered on 0 longitude.
%
% 2nd generation. 
% 
% INPUT:        x       , longitude vector
%               y       , latitude vector
%               Z       , 2D function of (x,y)
%                         Or multiple 2D functions in a 3D
%                         array. The first sheet for color contouring
%                         and the remaining for line contouring.
%
%               cvec    , contour level vector (row, linear, ordered)
%                         leave [] for automatic creation via x_cvec.m
%               opt_x_cvec  , option for x_cvec.m :
%                             {[],'below','above','add_both'}
%
%               name       , string for the output file
%                            include '.eps' in `name' for EPS output
%                            
%               color_handle , color map function handle
%               units      , string of units 
%
% NOTE:   -)  This function calls data_shift.m if x is in [0:360]
%         -)  It calls x_cvec.m to expand `cvec'
%         -)  It calls my_cbar to print a colorbar
%         -)  The jet colormap is optimal when NCvec = 8
% ====================================================================

% Things to improve $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
% 
% -) extend Z options to more than 2 sheets.
%    and make m_contour better-looking. Oof 2 sheets is a lot of 
%    information.
%
% -) As the CCSM 3.0 and the HadGEM1 do not use the same latitude
%    vector, the frame height is slightly diffrent from one model to
%    the next. Look into how to change that. Oooof I don't know.
%
% -) Maybe add my_cbar position as input ...
%
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


  %% add equator line option
  opt_Eq = 0;
% ----------------------------------------------------------------------

  % General aesthetic options
  frame_thick = 2.75;
  frame_color = [0,0,0];
  output_size = [20,10];
  frame_pos = [0.01,0.01,0.8,1];
  c_pos = [0.85,0.2,0.025,0.6,0.1];  % cbar l, b, w, h, tick length 
% ----------------------------------------------------------------------

  % get extension from `name'
  if strcmp(name(end-3),'.')
    ext = name(end-3:end);
    name = name(1:end-4);
  else
    ext = 'png';
  end

  % add 'model_name' to 'name' or not
  if strcmp(name(1:5),'ccsm3') || ...
     strcmp(name(1:8),'ncep_doe') || ...
     strcmp(name(1:7),'hadgem1') || ...
     strcmp(name(1:5),'era40')
    opt_print_no_name = 1;
  else
    opt_print_no_name = 0;
  end

  close;  
  
  % add path to color maps
  addpath('/home/disk/p/etienne/proj/etienne/my_plots/color_maps/');

  % Disable X term output, transparent background.
  if strcmp(ext,'png')
    FIG = figure('visible','off');
  else
    FIG = figure('visible','off', ... 
                 'color','none', ...
                 'InvertHardcopy','off');
  end
  
  % Take first sheet of Z as z if Z is 3D, 
  % the 2D field to be color contoured --> using sqz.m
  if ndims(Z)>2
    z = sqz(Z(1,:,:));
    opt_overlay = 1;
  else
    z = Z;
    opt_overlay = 0;
  end

  % Calls data_shift to shift the grid to [-180:180] if needed
  if (x(1) >= 0) 
    [z,x] = data_shift(x,z);  
  end

  % Calls x_cvec to expand (or generate) contour vector with opt_x_cvec
  % and restrict range of `z' to Cvec.
  [Cvec,NCvec,z] = x_cvec(z,cvec,opt_x_cvec);

  % Custom color map if color_handle exists
  check = 'color_handle';
  if exist(check) && ~isempty(color_handle);
    cmap = color_handle(Cvec);
    colormap(cmap)
  else
    colormap(jet(NCvec-1));     % 1 color less than contour levels 
  end   
  
  % draw the axis
  axes('position',frame_pos);

  %% Using the m_map set of procedures (~/proj/m_map/)
    
  % -) select projection type (lat_range **)
  m_proj('miller','lat',[-55,77],'long',[x(1),x(end)]);   
  %m_proj('miller','lat',[-90,90],'lon',[x(1),x(end)]);   
  
  % -) remove grid, thicker box
  m_grid('xtick',[],'ytick',[], ...
          'linewidth',frame_thick, ...
          'color',frame_color); 
  hold on
  
  % -) (if wanted) add equator line 
  if opt_Eq
    h_Eq = m_line(x,x*0);
    set(h_Eq,'linewidth',1.5, ...
             'color',[0.1,0.1,0.1], ...
             'linestyle','--');
    text(-3.05,0.2,'JJA', ...
         'fontsize',15, ...
         'fontweight','b', ...
         'color',frame_color);
    text(-3.05,-0.2,'DJF', ...
         'fontsize',15, ...
         'fontweight','b', ...
         'color',frame_color);
    name = [name '_Eq'];
  end
    
  % -) plot data (without contour lines)
  m_contourf(x,y,z,Cvec,'linestyle','none');
    
  % -) (if given) plot additional overlay contour(s)
  if opt_overlay
    o = sqz(Z(2,:,:));
    o = data_shift(x,o);  
    m_contour(x,y,o, ...
        'linestyle','-','color',[0.1,0.1,0.1],'linewidth',0.25);

    % and add suffix to output name
    name = [name '_Ov'];
  end

  % -) draw coast lines 
  m_coast('color',[0 0 0],'linewidth',0.75);
    
  % -) add color bar using my_cbar.m
  my_cbar(cvec,Cvec,units,c_pos,ext);

  % -) select output figure size
  h_fig = gcf;
  set(h_fig,'paperunits','centimeters','paperpositionmode','manual');
  set(h_fig,'papersize',output_size);
  set(h_fig,'paperposition',[0,0,output_size]);

  % printing ouptut using plot_print.m (as a .png or .eps)
  if strcmp(ext,'png')
    plot_print; 
  else
		load('global.mat','model_name');
    if ~opt_print_no_name
      name = [model_name,'_',name]; 
    end
    plot_print_eps; 
  end

  close(FIG);

end

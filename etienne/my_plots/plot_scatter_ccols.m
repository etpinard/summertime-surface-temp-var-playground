function scatter_plot_ccols(x,y,z,cvec,opt_x_cvec, ...
                                  opt,name,color_handle,units)
%
% The plotting function for color-coded scatter plot. That is, 2D
% scatter plot projections of a 3D z(x,y) field.
%
% As in scatter_plot_full.m, all multi-dimensional input variables
% will be transform into vector, as long as x,y,z are of the same size.
%
%
% INPUT:        x     ,   independent variable of x-axis 
%               y     ,   independent variable of y-axis 
%               z     ,   dependent variable, to be color-coded
%
%               cvec    , contour level vector (row, linear, ordered)
%                         leave [] for automatic creation via x_cvec.m
%               opt_x_cvec  , option for x_cvec.m :
%                             {[],'below','above','add_both'}
%               opt{1} , which coordinate pair
%                               'mbar-Tbar' , 'Pbar-Fbar'
%               opt{2} , on-plot annotation string
%
%               name  ,   name for output 
%                         (send w/o extension for both an .png and
%                         .eps output)
%               color_handle , color map function handle
%               units      , string of units 
%
% NOTE:   -)  It calls x_cvec.m to expand `cvec'  
%         -)  It calls my_cbar to print a colorbar
%         -)  The jet colormap is optimal when NCvec = 8
% ======================================================================

% Things to improve $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
% 
%
% -) Get out_format='both' to work
%
% -) get '.eps' to work with model_name
%
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


  %% Aesthetic options  
  %% (careful! theses are highly dependent on one another!!)

  frame_thick = 2;                % frame thickness
  frame_pos = [0.15,0.16,0.6,0.8];     % frame position
  frame_color = [0,0,0];             % frame color
  output_size = [13,8];             % output size in cm
  c_pos = [0.82,0.2,0.025,0.7,0.075];  % cbar l, b, w, h, tick length 
  grid_col = [102,102,102]./255;     % grid line color
  grid_width = 1.3;                  % grid line width
  sc_linew = 1.1;                    % scatter points line width
  sc_mksize = 1.6;                     % scatter points marker size
  sc_mksize = 1.2;                     % scatter points marker size
  sc_ticksize = 14;                  % tick label font size
% ----------------------------------------------------------------------

  % Calls x_cvec to expand (or generate) contour vector with opt_x_cvec
  % and restrict range of `z' to Cvec.
  [Cvec,NCvec,z] = x_cvec(z,cvec,opt_x_cvec);

%% Input specific annotations and display options

  if iscell(opt)
    opt_coords = opt{1};
    annotate_text = opt{2};
  else
    opt_coords = opt;
    annotate_text = [];
  end

  switch opt_coords

    case 'mbar-Tbar'

    annotate_pos = [0.5,265];             % on-plot annot. positions 
%    sc_order = Cvec(NCvec-1:-1:1)
    sc_order = Cvec;
    sc_xlabel = 'mbar [mm]';
    sc_xlabel_shift = [-26 -1.8 0];
    sc_xlims = [-1,52];
    sc_xticks = [0:10:50];
    sc_xticklbl = {'',10,'20','30','40',''};
    grid_hori = [10:10:40];
    sc_ylabel = 'Tbar [K]';
    sc_ylabel_shift = [0 0 0];
    sc_ylabel_rot = 90;
    sc_ylims = [262,312];
    sc_yticks = [270:10:310];
    %sc_yticklbl = 
    grid_vert = [270:10:300];

    x = resdown(x); 
    y = resdown(y); 
    z = resdown(z); 

    case 'Pbar-Fbar'

    secinday = 24*60*60;
    x = x*secinday;     % convert 'Pbar' from [mm/s] to [mm/day]

    annotate_pos = [9.5,285];                % on-plot annot. positions 
    sc_order = Cvec;
    sc_xlabel = 'Pbar [mm day-1]';
    sc_xlabel_shift = [0 0 0];
    sc_xlims = [-0.4,14];
    sc_xticks = [0:2:12];
    sc_xticklbl = {'0','2','4','6','8','10','12'};
    grid_hori = sc_xticks(2:end);
    sc_ylabel = 'Fbar [W m-2]';
    sc_ylabel_shift = [0.5 0 0];
    sc_ylabel_rot = 90;
    sc_ylims = [260,720];
    sc_yticks = [300:100:700];
    %sc_yticklbl = 
    grid_vert = sc_yticks(2:end-1);

    case 'chi-gammaT'

    annotate_pos = [-1.5,0.05];                % on-plot annot. positions 
    sc_order = Cvec;
  %  sc_order = Cvec(end-1:-1:1);
    sc_xlabel = 'chi  [-]';
    sc_xlabel_shift = [-1.62 -0.4 0];             % move left, up
    sc_xlims = [-1.6,1.6];
    sc_xticks = [-1.5:0.5:1.5];
    sc_xticklbl = {'','-1.0','-0.5','0.0','0.5','1.0',''};
    grid_hori = [0];
    sc_ylabel = 'gamma^2 Var(T) / Var(F)  [-]';
    sc_ylabel_shift = [0.1 2.7 0];
    sc_ylabel_rot = 90;
    sc_ylims = [-0.2,5.2];
    sc_yticks = [0:1:5];
    %sc_yticklbl = 
    grid_vert = [1];

  otherwise

    disp('plot_sc_4panels.m: *** Unsupported option opt_coords ***')
    return

  end
% ----------------------------------------------------------------------

  %% Get extension from `name'
  if strcmp(name(end-3),'.')
    ext = name(end-3:end);
    name = name(1:end-4);
  else
    ext = 'png';
  end

  opt_print_no_name = 0;

%  % add 'model_name' to 'name' or not
%  if strcmp(name(1:5),'ccsm3') || ...
%     strcmp(name(1:8),'ncep_doe') || ...
%     strcmp(name(1:7),'hadgem1') || ...
%     strcmp(name(1:5),'era40')
%    opt_print_no_name = 1;
%  else
%    opt_print_no_name = 0;
%  end
% ----------------------------------------------------------------------

  close;

  % add path to color maps
  addpath('/home/disk/p/etienne/proj/etienne/my_plots/color_maps/');
  
  % Disable X term output, transparent background.
  if strcmp(ext,'.png') || strcmp(ext,'both')
    FIG = figure('visible','off');
  elseif strcmp(ext,'.eps')
    FIG = figure('visible','off', ... 
                 'color','none', ...
                 'InvertHardcopy','off');
  end

  % draw the axis
  axes('position',frame_pos,'box','on');
  
  % Custom color map if color_handle exists
  if exist('color_handle') && ~isempty(color_handle);
    cmap = color_handle(Cvec);
    colormap(cmap)
  else
    cmap = colormap(jet(NCvec-1));  % N-1 colors for N contours
  end   
  
  %% plotting algorithm: Make array 1D, find all points in between
  %% each color contours in the order given by `sc_order', plot
  %% (** maybe try patch to add transparency).

  [z1d,N] = make1d(z);
  x1d = make1d(x);
  y1d = make1d(y);

  for i_loop=1:NCvec-1

    i_Cvec = find(sc_order(i_loop)==Cvec);

    if i_Cvec<NCvec-1
      inside = find(z1d >= Cvec(i_Cvec) & z1d < Cvec(i_Cvec+1));
    else
      inside = (z1d >= Cvec(i_Cvec) & z1d <= Cvec(i_Cvec+1)); 
    end

    plot(x1d(inside),y1d(inside), ... 
          'o','color',cmap(i_Cvec,:), ...
          'linewidth',sc_linew, ...
          'markersize',sc_mksize);
    hold on;

  end

  % axis aethetics
  set(gca,'FontName','Helvetica', ...
          'Fontsize',14, ... 
          'linewidth',frame_thick, ...
          'xcolor',frame_color, ...
          'ycolor',frame_color, ...
          'tickdir','out', ...
          'xtick',sc_xticks, ...
          'ytick',sc_yticks);
  xlim(sc_xlims);
  ylim(sc_ylims);
  if exist('sc_xticklbl')
    set(gca,'xticklabel',sc_xticklbl); end
  if exist('sc_yticklbl')
    set(gca,'yticklabel',sc_yticklbl); end

  % label axes
  ylabel(sc_ylabel, ...
         'fontsize',sc_ticksize, ...
         'fontweight','b', ...
         'rotation',sc_ylabel_rot);
  vec_pos = get(get(gca, 'YLabel'), 'Position');
  set(get(gca, 'YLabel'), ...
      'Position', vec_pos - sc_ylabel_shift);
  xlabel(sc_xlabel, ...
         'fontsize',sc_ticksize, ...
         'fontweight','b');
  vec_pos = get(get(gca, 'XLabel'), 'Position');
  set(get(gca, 'XLabel'), ...
      'Position', vec_pos - sc_xlabel_shift);

  % add custom grid --> gridxy
  gridxy([],grid_vert, ...
            'color',grid_col, ...
            'linestyle','--',...
            'linewidth',grid_width);
  gridxy(grid_hori,[], ...
            'color',grid_col, ...
            'linestyle','--',...
            'linewidth',grid_width);

  % add annotation
  if ~isempty(annotate_text)
    ann = strrep(annotate_text,'_',' ');
    text(annotate_pos(1),annotate_pos(2),ann, ...
         'fontsize',14, ...
         'fontweight','b');
  end

  % add color_bar using my_cbar 
  my_cbar(cvec,Cvec,units,c_pos,ext);

  % -) select output figure size
  h_fig = gcf;
  set(h_fig,'paperunits','centimeters','paperpositionmode','manual');
  set(h_fig,'papersize',output_size);
  set(h_fig,'paperposition',[0,0,output_size]);

  % printing ouptut using plot_print.m (as a .png or .eps)
  if strcmp(ext,'.png')
    plot_print; 
  else
		load('global.mat','model_name');
    if ~opt_print_no_name
      name = [model_name,'_',name]; 
    end
    plot_print_eps; 
  end

%  switch ext
%    case '.png'; plot_print; 
%    case '.eps'; 
%      load('global.mat','model_name');
%      name = [model_name,'_',name];
%      plot_print_eps; 
%    case 'both'; 
%      plot_print;
%%      tmp_str = func2str(color_handle);
%%      tmp = @color_coeffs;
%%      scatter_plot_ccols(x,y,z,cvec,opt_x_cvec, ...
%%                          opt,[name,'.eps'],tmp,units)
%  end

  close(FIG);

end

%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_sc_miller.m
%
% Side-by-side, color-coded scatter plot, miller map of the same
% variable.
%
% Implemented for 1 dataset and 1 variable at a time.
% 
% As as plot_sc_4panels, by default, the full resolution is used for
% the scatter plot, only (mbar,Tbar) or (Pbar,Fbar) coordinate pairs 
% have full aesthetics support.
%
% ======================================================================
%
% Variables to specify:
%
%   var_plot (cell singleton of variable name)
%   *** make sure that the corresp. 'lon' and 'lat' vectors are defined
%
%   model_plot (optional, cell singleton of model name to output)
%
%   coords_plot (1x2 cell array of coordinates: x then y),
%
%   name (model_name is added here if needed), 
%   cvec, opt_x_cvec, color_handle, units 
%
%   annotate_text (optional, cell array of on-plot annotation) 
%
%   out_format ('png' or 'eps') 
%   
%   ** what to do with 'opt_frame_col' and 'opt_overlay' ??
% ======================================================================


%% Validating $vars_plot and $models_plot

% only 1 model at a time
Nmodel_plot = 1;

if isempty(model_plot) || ~exist('model_plot')

  % if model_plot if empty or DNE, 'z''s are 'var_plot'
  tmp_var = [char(var_plot)];
  eval(['z1 = ',tmp_var,';']);
  eval(['z2 = ',tmp_var,';']);

  % and similarly for 'lon', 'lat', 
  eval(['x2 = ', lon,';']);
  eval(['y2 = ', lat,';']);

  % and 'coords_plot'
  eval(['x1 = ', char(coords_plot{1}),';']);
  eval(['y1 = ', char(coords_plot{2}),';']);

else

  % if not, add $model_plot to above
  tmp_var = [char(model_plot),'_',char(var_plot)];
  eval(['z1 = ',tmp_var,';']);
  eval(['z2 = ',tmp_var,';']);
  eval(['x2 = ',char(model_plot),'_lon;']);
  eval(['y2 = ',char(model_plot),'_lat;']);
  eval(['x1 = ',char(model_plot),'_',char(coords_plot{1}),';']);
  eval(['y1 = ',char(model_plot),'_',char(coords_plot{2}),';']);

end

% {x,y,z}1 correspond to the scatter plot
% {x,y,z}2 correspond to the miller map plot
% ----------------------------------------------------------------------

%% Set-up variables

% squeeze 'z1', 'z2' ,'x1' , 'y1' if 3D
if ndims(z1)==3
  z1 = sqmean(z1); end
if ndims(z2)==3
  z2 = sqmean(z2); end
if ndims(x1)==3
  x1 = sqmean(x1); end
if ndims(y1)==3
  y1 = sqmean(y1); end

%%% Not halving the resolution for 'z1' !

% eval `datashift' for 'z2' and 'x2'
cmd = ['[z2,x2]=data_shift(x2,z2);'];
eval(cmd);

% outputs some statistics 
cmd=['mystats(z1,tmp_var);'];
eval(cmd);

% eval `x_cvec' for 'z1' and 'z2'
cmd = ['[Cvec,NCvec,z1]=x_cvec(z1,cvec,opt_x_cvec);'];
eval(cmd);
cmd = ['[Cvec,NCvec,z2]=x_cvec(z2,cvec,opt_x_cvec);'];
eval(cmd);

% if overlay option, using m_crit (not supported yet)
if opt_overlay    
  name = [name,'_Ov']; 
  o = (sqmean(mbar) > m_crit).*Iland;
  o = data_shift(lon,o); end      
% ----------------------------------------------------------------------

%% Global aesthetics options
%% (careful! theses are highly dependent on one another!!)

frame_thick = 2.75;                      % frame thickness
axes_pos1 = [0.07,0.15,0.29,0.75];                % axes 1 position
axes_pos2 = [0.40,0.04,0.5,0.9];              % axes 2 position
cbar_pos = [0.925,0.18,0.012,0.6,0.08];  % cbar l, b, w, h, tick length
output_size = [45,15];                   % output size in cm

% if requested, color frame to be match with plot_hist2.m output
if exist('opt_frame_col') && opt_frame_col
  load('plotting.mat','frame_color');
else
  frame_color = [0,0,0; 0,0,0];
end

% if requested, text_annotate
if ~exist('annotate_text') || isempty(annotate_text)
  annotate_text = {'a)','b)'};
end
% ----------------------------------------------------------------------

%% Scatter plot aesthetics options

grid_col = [102,102,102]./255;           % grid line color
grid_width = 1.3;                        % grid line width
sc_linew = 1.3;                          % scatter points line width
sc_mksize = 2;                           % scatter points marker size
sc_ticksize = 18;                        % tick label font size

if strcmp(coords_plot(1),'mbar') && strcmp(coords_plot(2),'Tbar')

  sc_annotate_pos = [0.5,265];           % on-plot annot. positions 
  sc_order = Cvec(1:NCvec-1);
  sc_order = Cvec;
  sc_xlabel = 'mbar [mm]';
  sc_xlabel_shift = [-27 -3 0];
  sc_xlims = [-1,52];
  sc_xticks = [0:10:50];
  sc_xticklbl = {'',10,'20','30','40',''};
  grid_hori = [10:10:40];
  sc_ylabel = 'Tbar [K]';
  sc_ylabel_shift = [-13 -27 0];
  sc_ylims = [262,312];
  sc_yticks = [270:10:310];
  %sc_yticklbl = 
  grid_vert = [270:10:300];
  
elseif strcmp(coords_plot(1),'Pbar') && strcmp(coords_plot(2),'Fbar')

  sc_annotate_pos = [9.5,285];          % on-plot annot. positions 
  sc_order = Cvec(1:NCvec-1);
  sc_order = Cvec;
  sc_xlabel = 'Pbar [mm day-1]';
  sc_xlabel_shift = [-7.5 -30 0];
  sc_xlims = [-0.4,14];
  sc_xticks = [0:2:12];
  sc_xticklbl = {'0','2','4','6','8','10','12'};
  grid_hori = sc_xticks(2:end);
  sc_ylabel = 'Fbar [W m-2]';
  sc_ylabel_shift = [-1 220 0];
  sc_ylims = [260,720];
  sc_yticks = [300:100:700];
  %sc_yticklbl = 
  grid_vert = sc_yticks(2:end-1);

else

  disp('*** Unsupported options ***')
  break

end
% ----------------------------------------------------------------------

%% Miller map aesthetics options

annotate_pos = [-3,-0.8];                % on-plot annot. positions
% ----------------------------------------------------------------------

%% Display set-up

% Disable X term output (must be 1st) & initialize subplot handle vector
if strcmp(out_format,'png')
  FIG = figure('visible','off');
else
  FIG = figure('visible','off', ... 
               'color','none','InvertHardcopy','off');
end

% add path to custom color maps and set color map
addpath('/home/disk/p/etienne/proj/etienne/my_plots/color_maps/');
if ~isempty(color_handle);
  cmap = color_handle(Cvec);
else
  cmap = jet(NCvec-1);
end   
colormap(cmap)
% ----------------------------------------------------------------------

%% Plotting the scatter panel

% define axes
axes('position',axes_pos1, ...
     'box','on');
    
%% plotting algorithm: Make array 1D, find all points in between
%% each color contours in the order given by `sc_order', plot
[z1d,N] = make1d(z1);
x1d = make1d(x1);
y1d = make1d(y1);
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
        'Fontsize',22, ... 
        'linewidth',frame_thick, ...
        'xcolor',frame_color(1,:), ...
        'ycolor',frame_color(1,:), ...
        'tickdir','out', ...
        'xtick',sc_xticks, ...
        'xticklabel',sc_xticklbl, ...
        'ytick',sc_yticks);
xlim(sc_xlims);
ylim(sc_ylims);

% label axes
ylabel(sc_ylabel, ...
       'fontsize',sc_ticksize, ...
       'fontweight','b', ...
       'rotation',0);
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
text(sc_annotate_pos(1),sc_annotate_pos(2),char(annotate_text(1)), ...
     'fontsize',20, ...
     'fontweight','b');
% ----------------------------------------------------------------------

%% Plotting the miller map panel

% define axes
axes('position',axes_pos2);

%% plotting algorithm: choose projection, remove grid, draw data
%% contours and draw coast lines in black:
m_proj('miller','lat',[lat_range(1),lat_range(2)], ...
                'long',[x2(1),x2(end)]);
m_grid('xtick',[], ...
       'ytick',[], ...
       'linewidth',frame_thick, ...
       'color',frame_color(2,:));
hold on
m_contourf(x2,y2,z2,Cvec,'linestyle','none');
m_coast('color',[0 0 0],'linewidth',0.75);

% must set caxis after each panel!
caxis([Cvec(1),Cvec(NCvec)]);

% add overlay contour  
if opt_overlay
  m_contour(x,y,o, ...
            'linestyle','-', ...
            'color',[0.1,0.1,0.1], ...
            'linewidth',0.55); 
end

% add annotation (replace underscore by space)
ann = strrep(annotate_text(2),'_',' ');
text(annotate_pos(1),annotate_pos(2),ann, ...
     'fontsize',20, ...
     'fontweight','b', ...
     'color',frame_color(2,:));
% ----------------------------------------------------------------------

%% Add color bar 

my_cbar(cvec,Cvec,units,cbar_pos,out_format);
% ----------------------------------------------------------------------

%% Set output size and print in .eps

% output options
h_fig = gcf;
set(h_fig,'paperunits','centimeters','paperpositionmode','manual');
set(h_fig,'papersize',output_size);
set(gcf,'paperposition',[0,0,output_size]);

% add $model_name, if needed
tmp = name;
if Nmodel_plot==1;
  name = [model_name,'_',name];
  models_plot = [];
end

% printing outputs options 
switch out_format
  case 'png';
    disp(['Plotting ... ',name,' ... as a png']);
    print('-dpng',['figs/png/',name,'.png'],'-r150');
    close(FIG);
    name = tmp;
    if opt_overlay
      name = name(1:end-5); end
  case 'eps';
    plot_print_eps; 
    close(FIG);
    name = tmp;
    if opt_overlay
      name = name(1:end-5); end
  case 'both';  
    close(FIG);  % not optimal, but it works.
    name = tmp;
    if opt_overlay
      name = name(1:end-5); end
    out_format = 'png';
    plot_sc_miller
    out_format = 'eps';
    plot_sc_miller;
    out_format = 'both';
end
% ----------------------------------------------------------------------

% ======================================================================

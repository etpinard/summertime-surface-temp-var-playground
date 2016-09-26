%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_sc_2panels.m
%
% plotting procedure for 2 color-coded scatter plot panels, 
% outputted as an .eps or .png
%
% Implemented for 1 or multiple models.
%
% By default, the x-coord is `mbar' and the y-coord is `Tbar'.
% (*** make an option, later ***)
%
% By default, the resolution is halved using `resdown.m'.
%
% ======================================================================
%
% Variables to specify:
%
%   vars_plot (cell array of variable names),
%   *** must be 1x1 or 1x2
%
%   models_plot (cell array of model names to output), 
%   *** (optional) [] or 1x2
%
%   coords_plot (cell array of coordinates: x then y),
%   *** must be 1x2
%
%   name (model_name is added here if needed), 
%   cvec, opt_x_cvec, color_handle
%   annotate_text (cell array of on-plot annotation *** optional) 
%
%   out_format ('png' or 'eps')
%   opt_frame_col (0 or 1, [] -> 0)
% ======================================================================


%% Validating $vars_plot and $models_plot

% This is a 2 panel figure
Npanel = 2;

% get number of different variable to plot
Nvar_plot = length(vars_plot);
if Nvar_plot==1
  vars_plot = repmat({char(vars_plot)},Npanel,1);
else
  if Nvar_plot~=Npanel
  disp('Error ... wrong # of variables in vars_plot');
  break; end
end

% get number of different models used for plot
if ~exist('models_plot') || isempty(models_plot)
  models_plot = {'',''}; 
  Nmodel_plot = 1;
else
  Nmodel_plot = length(models_plot);
  if Nmodel_plot~=Npanel
  disp('Error ... wrong # of variables in model_plot');
  break; end
end
% ----------------------------------------------------------------------

%% Relabel variables, 
%% halve resolution, print some stats 

% subplot counter
i_model = 1;
i_var = 1;

for i=1:Npanel

  % get subplot code
  code = num2str(i);

  % get model prefix
  if Nmodel_plot==1;
    tmp_model = '';
  else
    tmp_model = [char(models_plot(i_model)),'_'];
    i_model = i_model + 1;
  end

  % get variable name and eval to `tmp_z', sqz if 3D
  tmp_var = [tmp_model,char(vars_plot(i_var))];
  cmd = ['tmp_z = ',tmp_var,';'];
  eval(cmd);
  if ndims(tmp_z)==3
    tmp_z = sqmean(tmp_z); end
  eval(['z',code,'=tmp_z;']);

  % get x-coord name and eval to `tmp_x', sqz if 3D
  cmd = ['tmp_x = ',tmp_model,char(coords_plot(1)),';'];
  eval(cmd);
  if ndims(tmp_x)==3
    tmp_x = sqmean(tmp_x); end
  eval(['x',code,'=tmp_x;'])

  % get y-coord name and eval to `tmp_y', sqz if 3D
  cmd = ['tmp_y = ',tmp_model,char(coords_plot(2)),';'];
  eval(cmd);
  if ndims(tmp_y)==3
    tmp_y = sqmean(tmp_y); end
  eval(['y',code,'=tmp_y;'])

  % outputs some statistics
  cmd=['mystats(z',code,',tmp_var);'];
  eval(cmd);
   
  % eval `resdown' on `x$i', `y$i' and `z$i'
  cmd = ['x',code,'= resdown(x',code,');'];
  eval(cmd);
  cmd = ['y',code,'= resdown(y',code,');'];
  eval(cmd);
  cmd = ['z',code,'= resdown(z',code,');'];
  eval(cmd);

  % eval `x_cvec' for `z$i'
  cmd = ['[Cvec,NCvec,z',code,'] =', ...
          'x_cvec(z',code,',cvec,opt_x_cvec);'];
  eval(cmd);

  % increment the variable counter
  i_var = i_var + 1;

end
% ----------------------------------------------------------------------

%% Aesthetic options  
%% (careful! theses are highly dependent on one another!!)

frame_thick = 2.75;                      % frame thickness
splot_hsep = 0.0;                        % horiz. separation
cbar_pos = [0.81,0.23,0.017,0.65,0.09];  % cbar l, b, w, h, tick length
cbar_offset = 0;                         % cbar horiz. offset 
annotate_pos = [0.5,265];                % on-plot annot. positions 
output_size = [35,12];                   % output size in cm
% ----------------------------------------------------------------------

%% Default options for `x=mbar' and `y=Tbar'

sc_order = Cvec(1:NCvec-1);
sc_xlims = [-1,52];
sc_xticks = [0:10:50];
sc_xticklbl = {'',10,'20','30','40',''};
sc_ylims = [262,312];
sc_yticks = [270:10:310];
%sc_yticklbl = {'270',10,'20','30','40',''}
sc_linew = 1.3;                                  % line width
sc_mksize = 5;                                  % marker size
sc_ticksize = 15;
% ----------------------------------------------------------------------

%% Display set-up

% Disable X term output (must be 1st) & initialize subplot handle vector
if strcmp(out_format,'png')
  FIG = figure('visible','off');
else
  FIG = figure('visible','off', ... 
               'color','none','InvertHardcopy','off');
end
h_sub = zeros(Npanel,1);
i_sub = 1;

% add path to custom color maps and set color map
addpath('/home/disk/p/etienne/proj/etienne/my_plots/color_maps/');
if ~isempty(color_handle);
  cmap = color_handle(Cvec);
else
  cmap = jet(NCvec-1);
end		
colormap(cmap)
% ----------------------------------------------------------------------

%% Looping through the panels

for j=1:2
    
  % evaluate `x$j' , `y$j'  , `z$j'
  eval(['x = x', num2str(j),';']);
  eval(['y = y', num2str(j),';']);
  eval(['z = z', num2str(j),';']);

  % set panel location using subaxis.m and save handle
  % (not sure why, but set marginleft=0 for better fit)
  h_sub(i_sub) = subaxis(1,2,i_sub, ...
          'SpacingHoriz',splot_hsep, ...
          'MarginLeft',0);

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
          'Fontsize',22, ... 
          'linewidth',frame_thick, ...
          'tickdir','out', ...
          'xtick',sc_xticks, ...
          'xticklabel',sc_xticklbl, ...
          'ytick',sc_yticks);
  xlim(sc_xlims);
  ylim(sc_ylims);

  % label axes 
  if j==1
	  ylabel('Tbar [K]', ...
           'fontsize',sc_ticksize, ...
           'fontweight','b');
    vec_pos = get(get(gca, 'YLabel'), 'Position');
%    set(get(gca, 'YLabel'), 'Position', vec_pos - [0.0001 0 0]);
    xlabel('mbar [mm]', ...
           'fontsize',16, ...
           'fontweight','b');
    vec_pos = get(get(gca, 'XLabel'), 'Position');
    set(get(gca, 'XLabel'), 'Position', vec_pos - [-27 0.5 0]);
  end

  % remove yticks in panel 2
  if j==2
    set(gca,'yticklabel',[]); end

  % add custom grid --> gridxy
  grid_col = [102,102,102]./255;
  gridxy([],[270:10:300], ...
            'color',grid_col, ...
            'linestyle','--',...
            'linewidth',1.3);
  gridxy([10:10:40],[], ...
            'color',grid_col, ...
            'linestyle','--',...
            'linewidth',1.3);

  % add annotation
  text(annotate_pos(1),annotate_pos(2),char(annotate_text(i_sub)), ...
       'fontsize',20, ...
       'fontweight','b');

  % increment subplot counter
  i_sub = i_sub + 1;

end
% ----------------------------------------------------------------------
  
%% Colorbar and corrections

% shrink all panels horizontally to make room for colorbar 
% (must be done after all panels are generated)
for i=1:Npanel

  %% get position, subtract offset and cbar width, 
  %% add frame margin to the left and re-set position.
  pos = get(h_sub(i),'Position');
  new_pos = pos - [-0.1,-0.075,cbar_offset+cbar_pos(3)+0.095,0];
  set(h_sub(i),'Position',new_pos);

end

set(h_sub(2),'Position',get(h_sub(2),'Position')-[0.1,0,0,0]);

% add color bar at the specific location --> using my_cbar.m 
my_cbar(cvec,Cvec,[],cbar_pos,out_format);
% ----------------------------------------------------------------------

%% Set output size and print in .eps

h_fig = gcf;
set(h_fig,'paperunits','centimeters','paperpositionmode','manual');
set(h_fig,'papersize',output_size);
set(gcf,'paperposition',[0,0,output_size]);
tmp = name;
if Nmodel_plot==1;
  name = [model_name,'_',name];
end
if strcmp(out_format,'png')
	disp(['Plotting ... ',name]);
	print('-dpng',['figs/png/',name,'.png'],'-r150');
else
  plot_print_eps; 
end
name = tmp;
close(FIG);
% ----------------------------------------------------------------------


% ======================================================================

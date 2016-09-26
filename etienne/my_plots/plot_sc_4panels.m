%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_sc_4panels.m
%
% plotting procedure for 2 by 2 color-coded scatter plot panels, 
% outputted as an .eps or .png
%
% Implemented for 1 or multiple models.
%
% By default, the x-coord is `mbar' and the y-coord is `Tbar', 
% (06/18) option for `Pbar' & `Fbar'
% (07/03) option for `chi' & `scale_gammaT'
% (08/30) option for `mbar' & `scale_gammaT'
% (09/05) option for `Lchisig_P' & `scale_gammaT'
% (09/05) option for `lambda' & `scale_gammaT'
%
% By default, the full resolution is used.
%
% ======================================================================
%
% Variables to specify:
%
%   vars_plot (cell array of variable names),
%   *** must be 1x1 or 1x4
%
%   models_plot (cell array of model names to output), 
%   *** (optional) [] or 1x4
%
%   coords_plot (cell array of coordinates: x then y),
%   *** must be 1x2
%
%   name (model_name is added here if needed), 
%   cvec, opt_x_cvec, color_handle, units
%   annotate_text (cell array of on-plot annotation *** optional) 
%
%   out_format ('png' or 'eps' or 'both')
%   opt_frame_col (0 or 1, [] -> 0)
% ======================================================================


%% Validating $vars_plot and $models_plot

% This is a 4 panel figure
Npanel = 4;

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
  models_plot = {'','','',''}; 
  Nmodel_plot = 1;
else
  Nmodel_plot = length(models_plot);
  if Nmodel_plot~=Npanel
  disp('Error ... wrong # of variables in model_plot');
  break; end
end
% ----------------------------------------------------------------------

%% Relabel variables, 
%% (halve resolution), print some stats 

% subplot counter
i_model = 1;
i_var = 1;

for i=1:Npanel/2 

  for j=1:Npanel/2

    % get subplot code
    code = [num2str(i),num2str(j)];

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
    if strcmp(out_format,'png')
      cmd=['mystats(z',code,',tmp_var);'];
      eval(cmd);
    end
     
%%    % eval `resdown' on `x$i', `y$i' and `z$i'
%    cmd = ['x',code,'= resdown(x',code,');'];
%    eval(cmd);
%    cmd = ['y',code,'= resdown(y',code,');'];
%    eval(cmd);
%    cmd = ['z',code,'= resdown(z',code,');'];
%    eval(cmd);

    % eval `x_cvec' for `z$i'
    cmd = ['[Cvec,NCvec,z',code,'] =', ...
            'x_cvec(z',code,',cvec,opt_x_cvec);'];
    eval(cmd);

    % increment the variable counter
    i_var = i_var + 1;

  end

end
% ----------------------------------------------------------------------

%% Aesthetic options  
%% (careful! theses are highly dependent on one another!!)

frame_thick = 2.75;                      % frame thickness
splot_vsep = 0.01;                       % vertical separation 
splot_hsep = 0.01;                       % horiz. separation
cbar_pos = [0.92,0.2,0.015,0.55,0.045];  % cbar l, b, w, h, tick length
cbar_offset = 0.04;                      % cbar horiz. offset 
output_size = [35,25];                   % output size in cm
grid_col = [102,102,102]./255;           % grid line color
grid_width = 1.3;                        % grid line width
sc_linew = 1.3;                          % scatter points line width
sc_mksize = 2;                           % scatter points marker size
sc_ticksize = 18;                        % tick label font size
% ----------------------------------------------------------------------

%% Input specific annotations and display options

if strcmp(coords_plot(1),'mbar') && strcmp(coords_plot(2),'Tbar')

  annotate_pos = [0.5,265];                % on-plot annot. positions 
%  sc_order = Cvec(1:NCvec-1);
  sc_order = Cvec;
  sc_xlabel = 'mbar [mm]';
  sc_xlabel_shift = [-27 -3 0];
  sc_xlims = [-1,52];
  sc_xticks = [0:10:50];
  sc_xticklbl = {'',10,'20','30','40',''};
  grid_hori = [10:10:40];
  sc_ylabel = 'Tbar [K]';
  sc_ylabel_shift = [-3 25 0];
  sc_ylabel_rot = 90;
  sc_ylims = [262,312];
  sc_yticks = [270:10:310];
  %sc_yticklbl = 
  grid_vert = [270:10:300];
  
elseif strcmp(coords_plot(1),'Pbar') && strcmp(coords_plot(2),'Fbar')

  x11 = x11*secinday;     % convert 'Pbar' from [mm/s] to [mm/day]
  x12 = x12*secinday;
  x21 = x21*secinday;
  x22 = x22*secinday;

  annotate_pos = [9.5,285];                % on-plot annot. positions 
  sc_order = Cvec;
  sc_xlabel = 'Pbar [mm day-1]';
  sc_xlabel_shift = [-7.5 -30 0];
  sc_xlims = [-0.4,14];
  sc_xticks = [0:2:12];
  sc_xticklbl = {'0','2','4','6','8','10','12'};
  grid_hori = sc_xticks(2:end);
  sc_ylabel = 'Fbar [W m-2]';
  sc_ylabel_shift = [-1 220 0];
  sc_ylabel_rot = 90;
  sc_ylims = [260,720];
  sc_yticks = [300:100:700];
  %sc_yticklbl = 
  grid_vert = sc_yticks(2:end-1);

elseif strcmp(coords_plot(1),'chi')  ...
    && strcmp(coords_plot(2),'scale_gammaT')

  annotate_pos = [-0.85,4.7];                % on-plot annot. positions 
%  sc_order = Cvec;
  sc_order = Cvec(end-1:-1:1);
  sc_xlabel = 'chi  [-]';
  sc_xlabel_shift = [-0.9 -0.4 0];             % move left, up
%  sc_xlims = [-1.6,1.6];
  sc_xlims = [-0.9,0.9];
%  sc_xticks = [-1.5:0.5:1.5];
  sc_xticks = [-0.8:0.4:0.8];
  sc_xticklbl = {'-0.8','-4.0','0.0','0.4','0.8'};
  grid_hori = [0];
  sc_ylabel = 'gamma^2 Var(T) / Var(F)  [-]';
  sc_ylabel_shift = [0.055 2.7 0];
  sc_ylabel_rot = 90;
  sc_ylims = [-0.2,5.2];
  sc_yticks = [0:1:5];
  %sc_yticklbl = 
  grid_vert = [1];

  % ** trim to half resolution
  for i=1:Npanel/2 
    for j=1:Npanel/2
      code = [num2str(i),num2str(j)];
      cmd = ['x',code,'= resdown(x',code,');']; eval(cmd);
      cmd = ['y',code,'= resdown(y',code,');']; eval(cmd);
      cmd = ['z',code,'= resdown(z',code,');']; eval(cmd);
    end
  end

elseif strcmp(coords_plot(1),'mbar')  ...
    && strcmp(coords_plot(2),'scale_gammaT')

  annotate_pos = [35,4.7];                % on-plot annot. positions 
%  sc_order = Cvec;
  sc_order = Cvec(end-1:-1:1);
  sc_xlabel = 'mbar  [mm]';
  sc_xlabel_shift = [-27 -0.6 0];
  sc_xlims = [-1,52];
  sc_xticks = [0:10:50];
  sc_xticklbl = {'',10,'20','30','40',''};
  grid_hori = [19.4,28.5,20.5,23.5];
  sc_ylabel = 'gamma^2 Var(T) / Var(F)  [-]';
  sc_ylabel_shift = [1.7 2.7 0];
  sc_ylabel_rot = 90;
  sc_ylims = [-0.2,5.2];
  sc_yticks = [0:1:5];
  %sc_yticklbl = 
  grid_vert = [1];

  % ** trim to half resolution
  for i=1:Npanel/2 
    for j=1:Npanel/2
      code = [num2str(i),num2str(j)];
      cmd = ['x',code,'= resdown(x',code,');']; eval(cmd);
      cmd = ['y',code,'= resdown(y',code,');']; eval(cmd);
      cmd = ['z',code,'= resdown(z',code,');']; eval(cmd);
    end
  end

elseif strcmp(coords_plot(1),'Lchisig_P')  ...
    && strcmp(coords_plot(2),'scale_gammaT')

  annotate_pos = [-13,4.7];                % on-plot annot. positions 
%  sc_order = Cvec;
  sc_order = Cvec(end-1:-1:1);
  sc_xlabel = 'L chi Var(P)^{1/2}  [Wm-2]';
  sc_xlabel_shift = [-23 -0.6 0];             % move left, up
%  sc_xlims = [-1.6,1.6];
  sc_xlims = [-15,30];
%  sc_xticks = [-1.5:0.5:1.5];
  sc_xticks = [-15:5:30];
  sc_xticklbl = {'','-10','','0','','10','','20','',''};
  grid_hori = [0];
  sc_ylabel = 'gamma^2 Var(T) / Var(F)  [-]';
  sc_ylabel_shift = [1.5 2.7 0];
  sc_ylabel_rot = 90;
  sc_ylims = [-0.2,5.2];
  sc_yticks = [0:1:5];
  %sc_yticklbl = 
  grid_vert = [1];

  % ** trim to half resolution
  for i=1:Npanel/2 
    for j=1:Npanel/2
      code = [num2str(i),num2str(j)];
      cmd = ['x',code,'= resdown(x',code,');']; eval(cmd);
      cmd = ['y',code,'= resdown(y',code,');']; eval(cmd);
      cmd = ['z',code,'= resdown(z',code,');']; eval(cmd);
    end
  end

elseif strcmp(coords_plot(1),'lambda')  ...
    && strcmp(coords_plot(2),'scale_gammaT')

  annotate_pos = [0.7,4.7];                % on-plot annot. positions 
%  sc_order = Cvec;
  sc_order = Cvec(end-1:-1:1);
  sc_xlabel = 'lambda  [-]';
  sc_xlabel_shift = [-0.52 -0.6 0];             % move left, up
  sc_xlims = [-0.05,1];
  sc_xticks = [0:0.1:0.9];
  sc_xticklbl = {'0','','0.2','','0.4','','0.6','','0.8',''};
  grid_hori = [0.2];
  sc_ylabel = 'gamma^2 Var(T) / Var(F)  [-]';
  sc_ylabel_shift = [0.035 2.7 0];
  sc_ylabel_rot = 90;
  sc_ylims = [-0.2,5.2];
  sc_yticks = [0:1:5];
  %sc_yticklbl = 
  grid_vert = [1];

  % ** trim to half resolution
  for i=1:Npanel/2 
    for j=1:Npanel/2
      code = [num2str(i),num2str(j)];
      cmd = ['x',code,'= resdown(x',code,');']; eval(cmd);
      cmd = ['y',code,'= resdown(y',code,');']; eval(cmd);
      cmd = ['z',code,'= resdown(z',code,');']; eval(cmd);
    end
  end
else

  disp('plot_sc_4panels.m: *** Unsupported entries in coords_plot ***')
  break

end
% ----------------------------------------------------------------------

%% Optional plotting arguments

% if requested, color frame to be match with plot_hist2.m output
if exist('opt_frame_col') && opt_frame_col
  load('plotting.mat','frame_color');
else
  frame_color = [0,0,0; 0,0,0; 0,0,0; 0,0,0];
end

% if requested, text_annotate
if ~exist('annotate_text') || isempty(annotate_text)
  annotate_text = {'a)','b)','c)','d)'};
end
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

%% Looping through the panels of the 2 x 2 figure

for i=1:Npanel/2

  for j=1:Npanel/2
    
    % get subplot code
    code = [num2str(i),num2str(j)];

    % evaluate `x$i$j' , `y$i$j' , `z$i$j'
    eval(['x = x',code,';']);
    eval(['y = y',code,';']);
    eval(['z = z',code,';']);
  
    % set panel location using subaxis.m and save handle
    % (not sure why, but set marginleft=0 for better fit)
    h_sub(i_sub) = subaxis(2,2,i_sub, ...
                             'SpacingVert',splot_vsep, ...
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
%        disp('plot_sc_4panels.m: Weird code on line 268');
        inside = find(z1d >= Cvec(i_Cvec) & z1d <= Cvec(i_Cvec+1)); 
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
            'xcolor',frame_color(i_sub,:), ...
            'ycolor',frame_color(i_sub,:), ...
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
    if i==1 && j==1
      ylabel(sc_ylabel, ...
             'fontsize',sc_ticksize, ...
             'fontweight','b', ...
             'rotation',sc_ylabel_rot);
      vec_pos = get(get(gca, 'YLabel'), 'Position');
      set(get(gca, 'YLabel'), ...
          'Position', vec_pos - sc_ylabel_shift);
    end
    if i==2 && j==1
      xlabel(sc_xlabel, ...
             'fontsize',sc_ticksize, ...
             'fontweight','b');
      vec_pos = get(get(gca, 'XLabel'), 'Position');
      set(get(gca, 'XLabel'), ...
          'Position', vec_pos - sc_xlabel_shift);
    end

    % remove xticks in panel 1-2
    if i==1
      set(gca,'xticklabel',[]); end
    
    % remove yticks in panel 2-4
    if j==2 
      set(gca,'yticklabel',[]); end

    % add custom grid --> gridxy
    gridxy([],grid_vert, ...
              'color',grid_col, ...
              'linestyle','--',...
              'linewidth',grid_width);
    if length(grid_hori)==1
      gridxy(grid_hori,[], ...
                'color',grid_col, ...
                'linestyle','--',...
                'linewidth',grid_width);
    else
      gridxy(grid_hori(i_sub),[], ...
                'color',grid_col, ...
                'linestyle','--',...
                'linewidth',grid_width);
    end

    % add annotation
    ann = strrep(annotate_text(i_sub),'_',' ');
    text(annotate_pos(1),annotate_pos(2),ann, ...
         'fontsize',20, ...
         'fontweight','b');

    % increment subplot counter
    i_sub = i_sub + 1;
 
  end

end
% ----------------------------------------------------------------------
  
%% Colorbar and corrections

% shrink all panels horizontally to make room for colorbar 
% (must be done after all panels are generated)
for i=1:Npanel

  %% get position, subtract offset and cbar width, 
  %% add frame margin to the left and re-set position.
  pos = get(h_sub(i),'Position');
  new_pos = pos - [-0.1,0,cbar_offset+cbar_pos(3),0];
  set(h_sub(i),'Position',new_pos);

end

% correction to vertical spacing between panels as
% shrinking in the horizontal increases the vertical spacing
splot_vcor = [0,0.0003,0,0];
set(h_sub(1),'Position',get(h_sub(1),'Position')-splot_vcor);
set(h_sub(2),'Position',get(h_sub(2),'Position')-splot_vcor);
splot_hcor = [0.057,0,0,0];
set(h_sub(2),'Position',get(h_sub(2),'Position')-splot_hcor);
set(h_sub(4),'Position',get(h_sub(4),'Position')-splot_hcor);

% add color bar at the specific location --> using my_cbar.m 
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
    plot_sc_4panels
    out_format = 'eps';
    plot_sc_4panels;
    out_format = 'both';
end
% ----------------------------------------------------------------------


% ======================================================================

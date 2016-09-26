%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_5panels.m
%
% plotting procedure for 1 + 2 by 2 4-miller-map figure, outputted as
% an .eps or .png
%
% Implemented for 1 or multiple models.
%
% ======================================================================

% Variables to specify:
%
%   vars_plot (cell array of variable names),
%   *** must be 1x1 or 1x5
%
%   models_plot (cell array of model names to output), 
%   *** (optional) [] or 1x5
%
%   name (model_name is added here if needed), 
%   cvec, opt_x_cvec, color_handle, units.
%   annotate_text (cell array of on-plot annotation *** optional) 
%
%   opt_overlay (0 or 1,[] -> 0) 
%   *** (06/26) only supported when 'models_plot' is 1x1
%
%   out_format ('png' or 'eps')
%   opt_frame_col (0 or 1,[] -> 0)
% ======================================================================


%% Validating $vars_plot and $models_plot

% This is a 5 panel figure
Npanel = 5;

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
  models_plot = {'','','','',''}; 
  Nmodel_plot = 1;
else
  Nmodel_plot = length(models_plot);
  if Nmodel_plot~=Npanel
  disp('Error ... wrong # of variables in model_plot');
  break; end
end
% ----------------------------------------------------------------------

%% Relabel variables, 
%% shift to [-180,180] grid, print some stats 

% do the top panel separatly
code = '0';
if Nmodel_plot==1;
  tmp_model = '';
else
  tmp_model = [char(models_plot(1)),'_'];
end
tmp_var = [tmp_model,char(vars_plot(1))];
eval(['tmp_z=',tmp_var,';']);
eval(['tmp_lon=',tmp_model,'lon;'])
eval(['y',code,'=',tmp_model,'lat;'])
if ndims(tmp_z)==3
  tmp_z = sqmean(tmp_z); end
cmd = ['[z',code,',x',code,']=' ...
       'data_shift(tmp_lon,tmp_z);'];
eval(cmd);
cmd=['mystats(z',code,',tmp_var);'];
eval(cmd);
cmd = ['[Cvec,NCvec,z',code,'] =', ...
        'x_cvec(z',code,',cvec,opt_x_cvec);'];
eval(cmd);

% subplot counter
i_model = 2;
i_var = 2;

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

    % get variable name
    tmp_var = [tmp_model,char(vars_plot(i_var))];

    % eval to `tmp_z'
    eval(['tmp_z=',tmp_var,';']);

    % get tmp longitude
    eval(['tmp_lon=',tmp_model,'lon;'])

    % eval to get `y$i$j'
    eval(['y',code,'=',tmp_model,'lat;'])

    % sqmean if 3D
    if ndims(tmp_z)==3
      tmp_z = sqmean(tmp_z);
    end

    % eval data_shift to get `z$i$j' and `x$i$j'
    cmd = ['[z',code,',x',code,']=' ...
           'data_shift(tmp_lon,tmp_z);'];
    eval(cmd);

    % outputs some statistics
    cmd=['mystats(z',code,',tmp_var);'];
    eval(cmd);
     
    % eval x_cvec
    cmd = ['[Cvec,NCvec,z',code,'] =', ...
            'x_cvec(z',code,',cvec,opt_x_cvec);'];
    eval(cmd);

    % increment the variable counter
    i_var = i_var + 1;

  end
end
% ----------------------------------------------------------------------

%% Overlay line setup

% if overlay option, set up global mean soil moisture contour
if opt_overlay    
  if Nmodel_plot==1 
    if exist('mbar')
    
    % suffix to 'name'
    old_name = name;
    name = [name,'_OvGM']; 

    % compute global mean soil moisture contour, print it to stdout
    mbar_global = sqmean(make1d(mbar));
    disp(['# Global mean soil moisture in ', model_name]);
    fprintf(1,'  mbar_global: %5.4f \n',mbar_global);

    % 1 contour level, above or below global mean soil moisture
    Ov = (sqmean(mbar) > mbar_global).*Iland;

    % shift coordinates to [-180:180]
    Ov = data_shift(lon,Ov); 

    else
      disp('*** opt_overlay error: mbar undefined');
      break
    end
  else
    disp('*** opt_overlay error: multi-model input not supported');
    break
  end
end      
% ----------------------------------------------------------------------

%% Aesthetics options
%% (careful! theses are highly dependent on one another!!)

frame_thick = 2.75;                      % miller and cbar thickness
splot_vsep = 0;                          % vertical separation 
splot_hsep = 0.005;                      % horiz. separation 
cbar_pos = [0.91,0.2,0.015,0.55,0.04];   % cbar l, b, w, h, tick length
cbar_offset = 0.005;                     % cbar horiz. offset 
annotate_pos = [-3,-0.8];             % on-plot annot. positions
output_size = [35,30];                   % output size in cm
% ----------------------------------------------------------------------

%% Optional plotting arguments

% if requested, color frame to be match with plot_hist2.m output
if exist('opt_frame_col') && opt_frame_col
  load('plotting.mat','frame_color');
  frame_color = [0,0,0; frame_color];
else
  frame_color = [0,0,0; 0,0,0; 0,0,0; 0,0,0; 0,0,0];
end

% if requested, text_annotate
if ~exist('annotate_text') || isempty(annotate_text)
  annotate_text = {'-)','a)','b)','c)','d)'};
end

% if opt_overlay, Ov_color, Ov_width
if opt_overlay
  Ov_width = 0.65;
  if ~isempty(color_handle)
  switch func2str(color_handle)
    case 'color_corr'; 
      Ov_color = [166,216,84]./255;   % green
    case 'color_corr';
      Ov_color = [231,41,138]./255;   % pink
    otherwise;  % including 'color_relerror' 
      Ov_color = [1,0.1,0.1];         % black
  end
  else
    Ov_color = [1,0.1,0.1];
  end
end
% ----------------------------------------------------------------------

%% Disable X-term (must be 1st) & initialize subplot handle vector
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

%% Plot top panel separatly 
x = x0;
y = y0;
z = z0;

h_sub(i_sub) = subaxis(3,2,i_sub, ...
                       'SpacingVert',splot_vsep, ...
                       'SpacingHoriz',splot_hsep, ...
                       'MarginLeft',0);

%% plotting algorithm: choose projection, remove grid, draw data
%% contours and draw coast lines in black:
m_proj('miller','lat',[lat_range(1),lat_range(2)], ...
                'long',[x(1),x(end)]);
m_grid('xtick',[],'ytick',[], ...
      'linewidth',frame_thick, ...
      'color',frame_color(i_sub,:));
hold on
m_contourf(x,y,z,Cvec,'linestyle','none');
m_coast('color',[0 0 0],'linewidth',0.75);

% must set caxis after each panel!
caxis([Cvec(1),Cvec(NCvec)]);
%    colorbar

% add overlay contour  
if opt_overlay
  m_contour(x,y,Ov, ...
            'linestyle','-', ...
            'color',Ov_color, ...
            'linewidth',Ov_width); 
end

% add annotation
text(annotate_pos(1),annotate_pos(2),char(annotate_text(i_sub)), ...
     'fontsize',20,'fontweight','b', ...
     'color',frame_color(i_sub,:));

% shift horizontally (not quite in the middle yet ...)
pos = get(h_sub(1),'Position');
new_pos = pos + [0.25,0,0,0];
set(h_sub(1),'Position',new_pos);

% increment subplot counter
i_sub = i_sub + 1;
% ----------------------------------------------------------------------

%% Looping through the panels of the 2 x 2 block
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
    h_sub(i_sub) = subaxis(3,2,i_sub+1, ...
                           'SpacingVert',splot_vsep, ...
                           'SpacingHoriz',splot_hsep, ...
                           'MarginLeft',0);

    %% plotting algorithm: choose projection, remove grid, draw data
    %% contours and draw coast lines in black:
    m_proj('miller','lat',[lat_range(1),lat_range(2)], ...
                    'long',[x(1),x(end)]);
    m_grid('xtick',[],'ytick',[], ...
          'linewidth',frame_thick, ...
          'color',frame_color(i_sub,:));
    hold on
    m_contourf(x,y,z,Cvec,'linestyle','none');
    m_coast('color',[0 0 0],'linewidth',0.75);

    % must set caxis after each panel!
    caxis([Cvec(1),Cvec(NCvec)]);
%    colorbar

    % add overlay contour  
    if opt_overlay
      m_contour(x,y,Ov, ...
                'linestyle','-', ...
                'color',Ov_color, ...
                'linewidth',Ov_width); 
    end
    
    % add annotation
    text(annotate_pos(1),annotate_pos(2),char(annotate_text(i_sub)), ...
         'fontsize',20,'fontweight','b', ...
         'color',frame_color(i_sub,:));

    % increment subplot counter
    i_sub = i_sub + 1;

  end

end
% ----------------------------------------------------------------------

%% Adjust panels and add color bar

% Shrink all panels horizontally to make room for colorbar 
% (must be done after all panels are generated)
for i=1:Npanel

  %% get position, subtract offset and cbar width, 
  %% add frame margin to the left and re-set position.
  pos = get(h_sub(i),'Position');
  new_pos = pos - [-0.005,0,cbar_offset+cbar_pos(3),0];
  set(h_sub(i),'Position',new_pos);

end

% correction to vertical spacing between panels as
% shrinking in the horizontal increases the vertical spacing
splot_vcor = [0,0.04,0,0];
set(h_sub(1),'Position',get(h_sub(1),'Position')-1.9*splot_vcor);
set(h_sub(2),'Position',get(h_sub(2),'Position')-splot_vcor);
set(h_sub(3),'Position',get(h_sub(3),'Position')-splot_vcor);
splot_hcor = [0.02,0,0,0];
set(h_sub(2),'Position',get(h_sub(2),'Position')+splot_hcor);
set(h_sub(4),'Position',get(h_sub(4),'Position')+splot_hcor);
set(h_sub(1),'Position',get(h_sub(1),'Position')-0.45*splot_hcor);


% add color bar at the specific location --> using my_cbar.m
my_cbar(cvec,Cvec,units,cbar_pos,out_format);
% ----------------------------------------------------------------------

%% Set output size and print 

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
    plot_5panels
    out_format = 'eps';
    plot_5panels;
    out_format = 'both';
end
% ----------------------------------------------------------------------

% ======================================================================

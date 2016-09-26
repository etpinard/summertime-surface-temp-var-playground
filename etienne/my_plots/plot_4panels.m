%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% plot_4panels.m
%
% plotting procedure for 2 by 2 4-miller-map figure,
% outputted as an .eps or .png
%
% Implemented for 1 or multiple models.
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
%   name (model_name is added here if needed), 
%   cvec, opt_x_cvec, color_handle
%   annotate_text (cell array of on-plot annotation *** optional) 
%
%   opt_overlay (0, 1 or 2, [] -> 0) 
%   *** (06/28) only supported when 'mbar' and 'Iland' 
%   ***         exist for all models.
%   (07/09) if =1, 1 contour w.r.t. mbar>20 mm
%           if =2, 1 contour w.r.t. mbar>'global mean mbar'
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

% if opt_overlay does not exist, set to 0
if ~exist('opt_overlay')
  opt_overlay = 0;
end

% suffix to 'name', if opt_overlay
switch opt_overlay
  case 1; name = [name,'_Ov20']; 
  case 2; name = [name,'_OvGM']; 
end
% ----------------------------------------------------------------------

%% Relabel variables, 
%% shift to [-180,180] grid, print some stats,
%% scale arrays if 'cvec' is non-linear (to match colormap)

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
    if strcmp(out_format,'png')
      cmd=['mystats(z',code,',tmp_var);'];
      eval(cmd);
    end
     
    % eval x_cvec
    cmd = ['[Cvec,NCvec,z',code,'] =', ...
            'x_cvec(z',code,',cvec,opt_x_cvec);'];
    eval(cmd);

    % increment the variable counter
    i_var = i_var + 1;

  end
end
% ----------------------------------------------------------------------

%% Overlay computation and relabeling

if opt_overlay

% re-intialize subplot counters
i_model = 1;
i_var = 1;

for i=1:Npanel/2
  for j=1:Npanel/2
 
    % get subplot code and model prefix
    code = [num2str(i),num2str(j)];
    if Nmodel_plot==1;
      tmp_model = '';
    else
      tmp_model = [char(models_plot(i_model)),'_'];
      i_model = i_model + 1;
    end
    
    % get mbar and Iland name
    tmp_mbar_str = [tmp_model,'mbar'];
    tmp_Iland_str = [tmp_model,'Iland'];

    if exist('tmp_mbar_str') && exist('tmp_Iland_str')

      % eval to get tmp_mbar and tmp_Iland
      eval(['tmp_mbar =',tmp_mbar_str,';']);
      eval(['tmp_Iland =',tmp_Iland_str,';']);
  
      switch opt_overlay

      % 1 contour level, above or below 20 mm
      case 1;
        tmp_Ov = (sqmean(tmp_mbar) > 20).*tmp_Iland;

      % 1 contour level, above or below global mean soil moisture 
      case 2;

        % compute global mean soil moisture contour, print it to stdout
        mbar_global = sqmean(make1d(tmp_mbar));
        if strcmp(out_format,'png')
          disp(['# Global mean soil moisture in ', tmp_model]);
          fprintf(1,'  mbar_global: %5.4f \n',mbar_global);
        end

        % 1 contour level, above or below global mean soil moisture
        tmp_Ov = (sqmean(tmp_mbar) > mbar_global).*tmp_Iland;

      end

      % shift coordinates to [-180:180]
      cmd = ['tmp_Ov = data_shift(',tmp_model,'lon,tmp_Ov);'];
      eval(cmd)

      % eval to get `Ov$i$j'
      eval(['Ov',code,'= tmp_Ov;']);

    else

      disp(['*** opt_overlay error: ',tmp_mbar_str,' undefined']);
      break

    end

  end
end

end
% ----------------------------------------------------------------------

%% Aesthetics options
%% (careful! theses are highly dependent on one another!!)

frame_thick = 2.75;                      % miller and cbar thickness
splot_vsep = 0;                          % vertical separation 
splot_hsep = 0.005;                      % horiz. separation 
cbar_pos = [0.91,0.2,0.015,0.55,0.06];   % cbar l, b, w, h, tick length
cbar_offset = 0.005;                     % cbar horiz. offset 
annotate_pos = [-3.05,-0.8];              % on-plot annot. positions
output_size = [35,20];                   % output size in cm
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

%% Display set-up

% Disable X term output (must be 1st) & initialize subplot handle vector
if strcmp(out_format,'png') || strcmp(out_format,'both')
  FIG = figure('visible','off');
elseif strcmp(out_format,'eps')
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
      eval(['Ov = Ov',code,';']);
      m_contour(x,y,Ov, ...
                'linestyle','-', ...
                'color',Ov_color, ...
                'linewidth',Ov_width); 
    end
    
    % add text annotation
    ann_text = char(annotate_text(i_sub));
    if length(ann_text)<9
      ann_fontsize = 20;
    else
      ann_fontsize = 14.5;
    end
    text(annotate_pos(1),annotate_pos(2),ann_text, ...
         'fontsize',ann_fontsize, ...
         'fontweight','b', ...
         'color',frame_color(i_sub,:));

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
  new_pos = pos - [-0.005,0,cbar_offset+cbar_pos(3),0];
  set(h_sub(i),'Position',new_pos);

end

% correction to vertical spacing between panels as
% shrinking in the horizontal increases the vertical spacing
splot_vcor = [0,0.058,0,0];
set(h_sub(1),'Position',get(h_sub(1),'Position')-splot_vcor);
set(h_sub(2),'Position',get(h_sub(2),'Position')-splot_vcor);
splot_hcor = [0.02,0,0,0];
set(h_sub(1),'Position',get(h_sub(1),'Position')+splot_hcor);
set(h_sub(3),'Position',get(h_sub(3),'Position')+splot_hcor);

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
    plot_4panels
    out_format = 'eps';
    plot_4panels;
    out_format = 'both';
end
% ----------------------------------------------------------------------


% ======================================================================

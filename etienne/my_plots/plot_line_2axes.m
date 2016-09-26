function plot_line_2axes(Y_l,Y_r,opt,name,out_format)
%
% Line plot of multiple variable w.r.t. months of the
% year (e.g. JJA, MJJAS, full year) including a measure of the 
% inter-annual spread at each month.
%
% Y_l is a 'multi-sheet' time series, each sheet will be plotted as an
% individual line with respect to the left-hand side axis.
%
% To make a multi-panel figure, send 3-D Y_l and Y_r with 'Npanel' 
% as the first dimension's length.
%
% Y_r same as Y_l but for the right-hand side axis. 
% 'Y_l' and 'Y_r' must equal have Ntime and Nsheet (and Npanel)
%
% Use `box_avg.m' for area averaging and `catsheet.m' for
% concatenating the time series.
%
%
% INPUT: 1) Y_l    , input left-side time series 
%                       (Nsheet x Ntime) or (Npanel x Nsheet x Ntime).
%        2) Y_r    , input right-side time series
%                       (Nsheet x Ntime) or (Npanel x Nsheet x Ntime).
%
%        3) opt{1} , x-axis time series format:
%                     'JJA' or '' : June, July, August,
%                     'JJA_avg' : June, July, August, summer avg.
%                     'MJJAS' : May, JJA, September,
%                     'full' : all 12 months.
%           opt{2} , (must input as cell array { }) 
%                    'mbar_sig_T',
%                    'forc_coeffs'
%
%        4) name        , string for the output file. 
%        5) out_format  , 'png' (by default) , 'eps' or 'both'
%
% 
% *) No support for NaN sheets as of (07/15)
% *) No support for empty opt{2} as of (07/15)
% *) No support for legend_order (07/15)
% *) yvals and ylabel are set here in 'argument-dependent options'
%
% ====================================================================

% Things to improve $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% -) Generalize x-axis offset !!
%
% -) Play around with 'line_width' / 'line_mksize' ?
%
% -) Add line to 'chi' points for 'line_forc_coeffs.m'
%
% -) Build plot for presentation (something like in 'Generating the
%    plot'
%
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%%% Presentation-only options
%
opt_pres = 1; 
% ----------------------------------------------------------------------

  %% General aesthetic options

  axes_thick = 1.75;          % frame thickness
  axes_color = [0,0,0];       % frame color
  line_width = 2.5;           % width of continuous line
  dot_mksize = 20;            % marker size of data dots
  label_fontsize = 14.5;      % label font size
  label_fontweight = 'demi';  % label font wieght
  tick_fontsize = 13;         % tick font size
  tick_fontweight = 'demi';   % tick font weight
  legend_fontweight = 'demi'; % legend font weight
  xlab = {'',''};             % make x-axis label empty for both axes
  
% ----------------------------------------------------------------------

%% presentation options (overwrite)

  if opt_pres 
    tick_fontsize = 16;         % tick font size
  end
% ----------------------------------------------------------------------

  %% Argument-dependent options

  % parse the 'opt' argument into
  % 'opt_x' (for x-axis length and ticks) , 'opt_line_style'
  if iscell(opt)
    opt_x = opt{1};
    opt_line_style = opt{2};
  else
    opt_x = opt;
    opt_line_style = 'none';
  end

  % optional 'out_format' argument 
  if nargin==4 || isempty(out_format);
    out_format = 'png';
  end

  % 'opt_x' argument
  switch opt_x
    case {'JJA',''};
      Nmonth = 3;
      xticklbl = {'Jun','Jul','Aug'};
    case {'JJA_avg',''};
      Nmonth = 4;
      xticklbl = {'Jun','Jul','Aug','Sum. avg.'};
      grid_vert = 3.5;
    case 'MJJAS';
      Nmonth = 5;
      xticklbl = {'May','Jun','Jul','Aug','Sep'};
    case 'full';
      Nmonth = 12;
      xticklbl = {'J','F','M','A','M','J', ...
                  'J','A','S','O','N','D'};
    otherwise;
      disp('*** Unsupported input argument ***')
      return
  end

  % get the x-axis time vector from 'Nmonth'
  x = [1:Nmonth];

  if ndims(Y_l)==3

    % get # of panels, sheets and time entries in 'Y_l' and 'Y_r'
    [Npanel_l,Nsheet_l,Ntime_l] = size(Y_l);
    [Npanel_r,Nsheet_r,Ntime_r] = size(Y_r);
 
  elseif ndims(Y_l)==2

    % get # of sheets and time entries in 'Y_l' and 'Y_r'
    [Nsheet_l,Ntime_l] = size(Y_l);
    [Nsheet_r,Ntime_r] = size(Y_r);

  end

  % both Ntime must be equal
  if Ntime_l~=Ntime_r
    disp(['plot_line_1axes.m:' ...
         'Y_r and Y_l must have same # of time entries']);
    return
  else
    Ntime = Ntime_r;
  end

  % both Nsheet must be equal
  if Nsheet_l~=Nsheet_r
    disp(['plot_line_2axes.m:' ...
         'Y_r and Y_l must have same # of sheets']);
    return
  else
    Nsheet = Nsheet_r;
  end

  % both Npanel must be equal
  if exist('Npanel_l')
    if Npanel_l~=Npanel_r
      disp(['plot_line_2axes.m:' ...
           'Y_r and Y_l must have same # of panels']);
      return
    else
      Npanel = Npanel_r;
    end
  else
    Npanel = 1;
  end


% ----------------------------------------------------------------------

%% 'opt_line_style' arguments

  switch opt_line_style

    case 'none';    
%      legend_str = {'CCSM3.0','NCEP-DOE','HadGEM1','ERA40'};
%      line_style = {'-','--','-','--'};
%      line_color = frame_color; 
%      line_order = [2,4,1,3];
%      legend_order = [1,3,4,2];
      disp('*** Unsupported input argument ***')
      return

    case 'mbar_sig_T';
    load('plotting.mat');
    line_xshift = [];
    grid_vert = [];

    if Npanel==1
      output_size = [20,10];    % output [width,height] in cm
      axes_pos = [0.09,0.11,0.55,0.85];   % axes postision
      legend_fontsize = 10;       % legend font size
      legend_pos = [0.77,0.62,0.2,0.2];   % legend position
      ylab_pos_l = [-0.09,0.5,0];   % l ylab pos
      ylab_pos_r = [1.15,0.5,0];    % r ylab pos
    elseif Npanel==2
      output_size = [25,15];
      axes_pos = [0.22,0.525,0.4,0.45; ...
                  0.22,0.055,0.4,0.45];
      legend_fontsize = 13;       % legend font size
      legend_pos = [0.665,0.44,0.4,0.2];
      ylab_pos_l = [-0.12,1,0];   % from bottom panel
      ylab_pos_r = [1.18,1,0];    % ""
      ann_pos = [0.01,0.75 ; 0.01, 0.28]; % annotation position
      ann_text(1) = {['Box 1:' ... 
                     char(10) 'Central US']};  % annotation text
      ann_text(2) = {['Box 2:' ... 
                     char(10) 'Eastern Europe']};  
    end

    if Nsheet==2
      line_order = [1,1;2,2];     % plotting order, l then r
      line_style_l = {'--','-'};  
      line_style_r = {'d','s'};
      line_color_l = [frame_color(4,:);frame_color(3,:)];
      line_color_r = line_color_l;
      line_width_l = [line_width,line_width];
      line_width_r = line_width_l;
      legend_str = {'ERA-40 mbar','HadGEM1 mbar', ...
                    'ERA-40 Var(T)^{1/2}','HadGEM1 Var(T)^{1/2}'};
      ylab_offset_l = [-0.6,-5,0];
      ylab_offset_r = [0.9,0.3,0];
      ylim_l = [10,24];           % y-axes limits (l and r)
      ylim_r = [1.25,2.25];
      yticks_l = [10:2:22];
      yticks_r = [1.25:0.25:2.25];
      yticklbl_l = {'10','','14','','18','','22'};
      yticklbl_r = {'','1.5','1.75','2',''};
    elseif Nsheet==4
      tmp_color1 = [228,26,28]./255; 
      tmp_color2 = [55,126,184]./255;
      tmp_color3 = [77,175,74]./255;
      tmp_color4 = [152,78,163]./255;
      line_order = [1,1;2,2;3,3;4,4];   % plotting order, l then r
      line_style_l = {'--','--','-','-'};  
      line_style_r = {'d','d','s','s'};
      line_color_l=[tmp_color3;tmp_color4;tmp_color2;tmp_color1; ...
                    tmp_color3;tmp_color4;tmp_color2;tmp_color1];
      line_color_r = line_color_l;
      line_width_l = [line_width,line_width, ...
                      line_width,line_width];
      line_width_r = line_width_l;
      legend_str = {'ERA-40 mbar','NCEP-DOE mbar', ...
                    'HadGEM1 mbar','CCSM3.0 mbar' ...
                    'ERA-40 Var(T)^{1/2}','NCEP-DOE Var(T)^{1/2}',...
                    'HadGEM1 Var(T)^{1/2}','CCSM 3.0 Var(T)^{1/2}'};
      ylim_l = [10,32];           % y-axes limits (l and r)
      ylim_r = [0.5,3];
      yticks_l = [10:2:30];
      yticks_r = [1:0.5:2.5];
      yticklbl_l = {'','12','','16','','20','','24','','28',''};
      yticklbl_r = {'1','1.5','2','2.5'};
    else
      disp('*** Unsupported input argument ***')
      return
    end

    % xlab (empty)
    xlim_l = [0.5,Nmonth+0.5];  % x-axes limits (l and r)
    xlim_r = xlim_l;
    xticks_l = x;               % x-axes tick 
    xticks_r = xticks_l;        
    xticklbl_l = xticklbl;      % x-axes tick labels
    xticklbl_r = repmat({''},Nmonth,1);
    ylab = {'mbar  [mm]','Var(T)^{1/2}  [K]'};
    dot_xshift = 0;          % horiz. shift for data points

    case 'forc_coeffs';
    load('plotting.mat');

    if Npanel==1
      output_size = [20,10];    % output [width,height] in cm
      axes_pos = [0.09,0.11,0.55,0.85];   % axes postision
      legend_fontsize = 10;       % legend font size
      legend_pos = [0.77,0.62,0.2,0.2];   % legend position
      legend_pos = [];  % no legend
      ylab_pos_l = [-0.09,0.5,0];   % l ylab pos
      ylab_pos_r = [1.15,0.5,0];    % r ylab pos
    elseif Npanel==2
      output_size = [25,15];
      axes_pos = [0.22,0.525,0.4,0.45; ...
                  0.22,0.055,0.4,0.45];
      legend_fontsize = 13;       % legend font size
      legend_pos = [0.665,0.44,0.4,0.2];
      ylab_pos_l = [-0.12,1,0];   % from bottom panel
      ylab_pos_r = [1.18,1,0];    % ""
      ann_pos = [0.01,0.75 ; 0.01, 0.28]; % annotation position
      ann_text(1) = {['Box 1:' ... 
                     char(10) 'Central US']};  % annotation text
      ann_text(2) = {['Box 2:' ... 
                     char(10) 'Eastern Europe']};  
    end

    if Nsheet==4
    
      line_xshift = 2;    % x-shift cycles every -- sheets
      line_order = [1,1;2,2;3,3;4,4];   % plotting order, l then r
      line_style_l = {'s','s','d','d'};  
      line_style_r = {'x','x','<','<'};
      line_color_l = [frame_color(4,:); frame_color(3,:); ...
                      frame_color(4,:); frame_color(3,:)];
      line_color_r = line_color_l;
      line_width_l = [line_width,line_width, ...
                      line_width,line_width];
      line_width_r = line_width_l;
      line_mksize_l = [9,9,9,9];
      line_mksize_r = [8,8,5,5];
      legend_str = {['ERA-40 Var(F)^{1/2}', ...
                      char(10),'  non-precip'], ...
                    ['HadGEM1 Var(F)^{1/2}' ...
                      char(10),'  non-precip'], ...
                    ['ERA-40 Var(F)^{1/2}', ...
                      char(10),'  precip'], ...
                    ['HadGEM1 Var(F)^{1/2}', ...
                      char(10),'  precip'], ...
                    'ERA-40 lambda', ...
                    'HadGEM1 lambda', ...
                    'ERA-40 chi', ...
                    'HadGEM1 chi'};
      ylim_l = [8,15];           % y-axes limits (l and r)
      ylim_r = [-0.3,0.75];
      yticks_l = [8:1:14];
      yticks_r = [-0.2:0.1:0.6];
      yticklbl_l = {'8','','10','','12','','14'};
      yticklbl_r = {'-0.2','','0','','0.2','','0.4','','0.6'};

    elseif Nsheet==6

      tmp_color1 = [228,26,28]./255; 
      tmp_color2 = [55,126,184]./255;
      tmp_color3 = [77,175,74]./255;
      line_xshift = 3;    % x-shift cycles every -- sheets
      line_order = [1,1;2,2;3,3;4,4;5,5;6,6];   % plotting order, l then r
      line_style_l = {'s','s','s','d','d','d'};  
      line_style_r = {'x','x','x','<','<','<'};
      line_color_l=[tmp_color3;tmp_color2;tmp_color1; ...
                    tmp_color3;tmp_color2;tmp_color1];
      line_color_r = line_color_l;
      line_width_l = [line_width,line_width,line_width, ...
                      line_width,line_width,line_width];
      line_width_r = line_width_l;
      line_mksize_l = [9,9,9,9,9,9];
      line_mksize_r = [8,8,8,5,5,5];
      legend_str = {['ERA-40 Var(F)^{1/2}', ...
                      char(10),'  non-precip'], ...
                    ['HadGEM1 Var(F)^{1/2}' ...
                      char(10),'  non-precip'], ...
                    ['CCSM3.0 Var(F)^{1/2}' ...
                      char(10),'  non-precip'], ...
                    ['ERA-40 Var(F)^{1/2}', ...
                      char(10),'  precip'], ...
                    ['HadGEM1 Var(F)^{1/2}', ...
                      char(10),'  precip'], ...
                    ['CCSM3.0 Var(F)^{1/2}' ...
                      char(10),'  precip'], ...
                    'ERA-40 lambda', ...
                    'HadGEM1 lambda', ...
                    'CCSM3.0 lambda', ...
                    'ERA-40 chi', ...
                    'HadGEM1 chi', ...
                    'CCSM3.0 chi'};
      ylim_l = [4,23];           % y-axes limits (l and r)
      ylim_r = [-0.3,0.75];
      yticks_l = [6:2:22];
      yticks_r = [-0.2:0.1:0.6];
      yticklbl_l = {'6','','10','','14','','18','','22'};
      yticklbl_r = {'-0.2','','0','','0.2','','0.4','','0.6'};
    else
      disp('*** Unsupported input argument ***')
      return
    end

    % xlab (empty)
    xlim_l = [0.5,Nmonth+0.5];  % x-axes limits (l and r)
    xlim_r = xlim_l;
    xticks_l = x;               % x-axes tick 
    xticks_r = xticks_l;        
    xticklbl_l = xticklbl;      % x-axes tick labels
    xticklbl_r = repmat({''},Nmonth,1);
    ylab = {'Forcings [Wm-2]','TM coefficients [-]'};
    dot_xshift = 0.175;          % horiz. shift for data points

    otherwise;
      disp('*** Unsupported input argument ***')
    return
  end

% ----------------------------------------------------------------------

  %% Display set-up
  
  % close and open window
  if strcmp(out_format,'png') || strcmp(out_format,'both')
    FIG = figure('visible','off');
  elseif strcmp(out_format,'eps')
    FIG = figure('visible','off', ... 
                 'color','none','InvertHardcopy','off');
  end

  % initialize handle vectors (left and right) to be use for the legend
  h_l = zeros(Nsheet,1);
  h_r = zeros(Nsheet,1);

% ----------------------------------------------------------------------

  for k=1:Npanel  %% looping through the panel(s)

  % assign 'Y_l' and 'Y_r' for panel $k
  if Npanel==1
    y_l = Y_l;
    y_r = Y_r;
  else
    y_l = sqz(Y_l(k,:,:));
    y_r = sqz(Y_r(k,:,:));
  end

  %% Generating the plot

  axes('position',axes_pos(k,:));

  % Loop through every sheet
  for i=1:Nsheet

    % get line order index of 'Y_l' 
    ii_l = line_order(i,1);

    % get line order index of 'Y_r'
    ii_r = line_order(i,2);

    % select data
    yy_l = sqz(y_l(ii_l,:));
    yy_r = sqz(y_r(ii_r,:));

    % *) if 'opt_x'=='JJA_avg'
    if strcmp(opt_x,'JJA_avg')
      yy_l = [yy_l,mean(yy_l)];
      yy_r = [yy_r,mean(yy_r)];
    end

%    % *) Show only specific 
%    if ii_r > 0
%      yy_r = repmat(NaN,Nmonth,1);
%    end

    % shift x-axis coords to differenciate fields
    if ~isempty(line_xshift)
      spot = mod(i,line_xshift);
      xx_l = x + (1-spot)*dot_xshift;
      xx_r = xx_l;
    else
      xx_l = x;
      xx_r = x;
    end

    % plot using `plotyy'
    if i==1;

      % if first sheet, plot and save axes and line handles
      [ax, h_l(i), h_r(i)] = plotyy(xx_l, yy_l, xx_r, yy_r);
      ax_l = ax(1);
      ax_r = ax(2);
      hold(ax_l,'on')
      hold(ax_r,'on')

    else
      
      % if not first sheet, plot on existing axes
      h_l(i) = plot(xx_l,yy_l,'Parent',ax_l);
      h_r(i) = plot(xx_r,yy_r,'Parent',ax_r);

    end

    % aesthetics options (for every 'opt_style')
    set(h_l(i),'linestyle',line_style_l{i}, ...
               'color',line_color_l(i,:), ...
               'linewidth',line_width_l(i));
    set(h_r(i),'linestyle',line_style_r{i}, ...
               'color',line_color_r(i,:), ...
               'linewidth',line_width_r(i));
    
    % *) if line, superimpose large dot at each month
    if strcmp(line_style_l{i},'-') || ... 
        strcmp(line_style_l{i},'--') || ...
          strcmp(line_style_l{i},':') 

      plot(xx_l,yy_l,'.', ... 
                'color',line_color_l(i,:), ...
                'markersize',dot_mksize, ...
                'Parent',ax_l);
    end

    if strcmp(line_style_r{i},'-') || ... 
        strcmp(line_style_r{i},'--') || ...
          strcmp(line_style_r{i},':') 

      plot(xx_r,yy_r,'.', ... 
                'color',line_color_r(i,:), ...
                'linewidth',dot_mksize, ...
                'Parent',ax_r);
    end

    % *) change 'markersize' if exist
    if exist('line_mksize_l') || exist('line_mksize_r')
      set(h_l(i),'markersize',line_mksize_l(i));
      set(h_r(i),'markersize',line_mksize_r(i));
    end

  end

% ----------------------------------------------------------------------

  %% Customize frame and axes, add legend, (add grid)

  % turn off box property to not have tick marks appear on both sides
  set(ax_l,'box','off')
  set(ax_r,'box','off')

  % axes style and change xtick labels (both l and r)
  set(ax_l,'tickdir','out', ...
           'linewidth',axes_thick, ...
           'fontsize',tick_fontsize, ...
           'fontname','Helvetica', ...
           'fontweight',tick_fontweight, ...
           'xcolor',axes_color, ...
           'xtick',xticks_l, ...
           'xticklabel',xticklbl_l, ...
           'ycolor',axes_color, ...
           'ytick',yticks_l, ...
           'yticklabel',yticklbl_l);
  set(ax_r,'tickdir','out', ...
           'linewidth',axes_thick, ...
           'fontsize',tick_fontsize, ...
           'fontname','Helvetica', ...
           'fontweight',tick_fontweight, ...
           'xcolor',axes_color, ...
           'xtick',xticks_r, ...
           'xticklabel',xticklbl_r, ...
           'ycolor',axes_color, ...
           'ytick',yticks_r, ...
           'yticklabel',yticklbl_r);

  % add back top box line
  set(ax_r,'xaxislocation','top')

  % axis labels (both l and r), rotate right ylabel
  xlabel(ax_l,xlab{1}, ...
         'fontsize',label_fontsize, ...
         'fontname','Helvetica', ...
         'fontweight',label_fontweight);
  xlabel(ax_r,xlab{2}, ...
         'fontsize',label_fontsize, ...
         'fontname','Helvetica', ...
         'fontweight',label_fontweight);
  ylabel(ax_l,ylab{1}, ...
         'fontsize',label_fontsize, ...
         'fontname','Helvetica', ... 
         'fontweight',label_fontweight, ...
         'Units','Normalized', ...
         'Position',ylab_pos_l);
  ylabel(ax_r,ylab{2}, ...
         'fontsize',label_fontsize, ...
         'fontname','Helvetica', ... 
         'fontweight',label_fontweight, ...
         'rotation',-90, ...
         'Units','Normalized', ...
         'Position',ylab_pos_r);

  % axis limits (l and r)
  xlim(ax_l,xlim_l);
  xlim(ax_r,xlim_r);
  ylim(ax_l,ylim_l);
  ylim(ax_r,ylim_r);

  % add legend, outside frame (l then r) 
  if ~isempty(legend_str) && ~isempty(legend_pos)
    legend([h_l;h_r],legend_str, ...
           'linewidth',frame_thick, ...
           'fontsize',legend_fontsize, ...
           'fontweight',legend_fontweight, ...
           'position',legend_pos);
  end

  % add on-plot grid 
  if ~isempty(grid_vert) 
    gridxy(grid_vert,[], ...
                     'color',[0,0,0], ...
                     'linestyle','-', ...
                     'linewidth',1.3);
  end

  % add multi-panel annotation
  if Npanel==2

    ax_tmp = axes('Position',[0 0 1 1],'Visible','off');
    text(ann_pos(k,1),ann_pos(k,2), ...
         ann_text(k), ...
         'fontsize',label_fontsize, ...
         'fontweight',label_fontweight);

  end

  % remove xticks labels, and y-labels for top panel 
  if Npanel==2 && k==1
    set(ax_l,'xticklabel',repmat({''},length(xticks_l),1));
    ylabel(ax_l,'');
    ylabel(ax_r,'');
  end

% ----------------------------------------------------------------------

  end   %% end panel loop

  %% Output figure

  % add 'line_' to $name 
  name = ['line_',name];

  % select output figure size
  h_fig = gcf;
  set(h_fig,'paperunits','centimeters', ...
            'paperpositionmode','manual');
  set(h_fig,'papersize',output_size);
  set(h_fig,'paperposition',[0,0,output_size]);

  % printing ouptut as as .png or an .eps or both
  switch out_format
    case 'png'
      disp(['Plotting ... ',name,' ... as a png']);
      print('-dpng',['figs/png/',name,'.png'],'-r150');
    case 'eps'
      figure('visible','off','color','none','InvertHardcopy','off');
      plot_print_eps; 
    case 'both'
      disp(['Plotting ... ',name,' ... as a png']);
      print('-dpng',['figs/png/',name,'.png'],'-r150');
      figure('visible','off','color','none','InvertHardcopy','off');
      plot_print_eps; 
  end
  
  % close figure
  close(FIG);

% ----------------------------------------------------------------------

end

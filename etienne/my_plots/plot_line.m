function plot_line(Y,YY,opt,ylab,yvals,name,out_format)
%
% Line plot of multiple variable w.r.t. months of the
% year (e.g. JJA, MJJAS, full year) including a measure of the 
% inter-annual spread at each month.
%
% Y is a 'multi-sheet' time series, each sheet will be plotted as an
% individual line. Sheets filled with NaNs are skipped.
%
% YY is a multi-sheet inter-annual spread time series. 
% - If empty and Y's 'Ntime' ~= 'Nmonth', the inter-annual spread is 
%   the std of Y, plotted as error bars at each month. 
% - If non-empty, each entry is plotted as a cloud of points at each
%   month.
%
% Use `box_avg.m' for area averaging and `catsheet.m' for
% concatenating the time series.
%
%
% INPUT: 1) Y     , input multi-sheet time series (Nsheet x Ntime).
%        2) YY    , multi-sheet spread time series (Nsheet x Ntime),
%                   send [] for default settings.
%
%        3) opt or opt{1} , x-axis time series format:
%                           'JJA' or '' : June, July, August,
%                           'MJJAS' : May, JJA, September,
%                           'full' : all 12 months.
%           opt{2} , (optional, must input as cell array { }) 
%                    'comp_datasets' or [] : a line for each data set,
%                    w/ input ordered as 'ccsm3','ncep_doe','hadgem1',
%                                        'era40'(,'obs').
%                    ' ' ,
%
%        4) ylab  , string for y-axis label (should include units).
%        5) yvals , vertical limits of the y-axis [bottom,top],
%                   put [] for default setting.
%
%        6) name        , string for the output file. 
%        7) out_format  , (optional) 'png' (by default) , 'eps'.
%
% ====================================================================

% Things to improve $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% -) Support for two axes plots!!!! 
%
% -) Line and scatter orderging, gcms over reanalysis 
%    (generalize 'legend order')
%
% -) Highlight summer months in 'full' option.
% 
% -) 'opt_x' -dependent output_size
%
% -) Different symbol for positive and negative YY scater
% -) Change marker size when several 'YY' entries are out of bounds.
%    Also, generalize if yvals does not exist.
%    Place point above frame.
%
% -) error bars and line have the same width when using matlab's
%    'errorbar' , change ?
%
% -) Add support for 'ytick' and gridxy
%
% -) Should I rotate the y-axis label, shift its position, split
%    between variable and units, not in bold ... ?
%
% -) Should I rotate the x-axis ticks?  'xticklabel_rotate.m' messes
%    up the output size 'rotate_XLabels.m' only works with matlab-new
%
% -) Add support for southern hemisphere locations.  
% -) Add a 'both' option for 'out_format'
%
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  %% General aesthetic options

  line_width = 2.5;         % width of continuous line
  sprd_width = 2.0;         % width of error bars
  sprd_xshift = 0.05;       % horiz. shift for errorbars/ pt clouds
  sprd_mksize = 9;          % marker size of pt clouds
  dot_width = 1.9;          % width of data dots
  tick_fontsize = 13;       % tick font size
  legend_fontsize = 10;     % legend font size
  output_size = [20,10];    % output [width,height] in cm
  frame_thick = 1.75;       % frame thickness
  frame_color = [0,0,0];    % frame color
  xlab = [];                % make x-axis label empty
  
% ----------------------------------------------------------------------

  %% Argument-dependent options

  % parse the 'opt' argument into
  % 'opt_x' (for x-axis length and ticks) , 'opt_line_style'
  if iscell(opt)
    opt_x = opt{1};
    opt_line_style = opt{2};
  else
    opt_x = opt;
    opt_line_style = 'comp_datasets';
  end

  % optional 'out_format' argument
  if nargin==6 || isempty(out_format);
    out_format = 'png';
  end

  % 'opt_x' argument
  switch opt_x
    case {'JJA',''};
      Nmonth = 3;
      xticklbl = {'Jun','Jul','Aug'};
    case 'MJJAS';
      Nmonth = 5;
      xticklbl = {'May','Jun','Jul','Aug','Sep'};
    case 'full';
      Nmonth = 12;
%      xticklbl = {'Jan','','Mar','','May','', ...
%                'Jul','','Sep','','Nov',''};
%      xticklbl = {'Jan','Feb','Mar','Apr','May','Jun', ...
%                'Jul','Aug','Sep','Oct','Nov','Dec'};
      xticklbl = {'J','F','M','A','M','J', ...
                  'J','A','S','O','N','D'};
    otherwise;
      disp('*** Unsupported input argument ***')
      return
  end

  % get the x-axis time vector from 'Nmonth'
  x = [1:Nmonth];

  % get # of sheets and time entries in 'Y'
  if ndims(Y)==2
    [Nsheet,Ntime_Y] = size(Y);
  else
    Nsheet = 1;
    Ntime_Y = length(Y);
  end

  % get # of time entries in 'YY' , if defined
  if isempty(YY)
    Ntime_YY = 0;
  else
    if ndims(YY)==2
      [Nsheet,Ntime_YY] = size(YY);
    else
      Ntime_YY = length(YY);
    end
  end

  % 'opt_line_style' optional argument 
  switch opt_line_style
    case 'comp_datasets';    % default
      load('plotting.mat');
      if Nsheet==4
        legend_str = {'CCSM3.0','NCEP-DOE','HadGEM1','ERA40'};
        line_style = {'-','--','-','--'};
        line_color = frame_color; 
        line_order = [2,4,1,3];
        legend_order = [1,3,4,2];
      elseif Nsheet==5
        legend_str = {'CCSM3.0','NCEP-DOE','HadGEM1','ERA40','U.Del'};
        line_style = {'-','--','-','--','--'};
        line_color = [frame_color; 0,0,0];
        line_order = [2,4,5,1,3];
        legend_order = [5,1,3,4,2];
      end
    case 'ad';
      line_order = [1:4];
      legend_order = [4:-1:1];
    otherwise;
      disp('*** Unsupported input argument ***')
      return
    end

  % if input is already as climatological mean, do not compute 
  % monthly average and stds.
  if Ntime_Y==Nmonth
    flag_no_compute = 1;
  else
    flag_no_compute = 0;
  end
 
% ----------------------------------------------------------------------
  
  %% Display set-up
  
  % close and open window
  close;  
  if strcmp(out_format,'png')
    FIG = figure('visible','off');
  else
    FIG = figure('visible','off', ... 
                 'color','none','InvertHardcopy','off');
  end

  % initialize handle vector to be use for the legend
  h = zeros(Nsheet,1);

  % initializing 'good_sheet' and 'i_good' indices 
  % to keep track of NaN sheet
  good_sheet = [1:Nsheet];
  i_good = 0;

% ----------------------------------------------------------------------

  %% Generating the plot

%  axes('box','on');

  % Loop through every sheet
  for i=1:Nsheet

    % line order index
    ii = line_order(i);

    % take in sheet $ii of Y
    y1 = sqz(Y(ii,:));

    % if sheet of NaN, substract from 'good_sheet'
    % if not, add to 'good_i'
    if length(find(isnan(y1)))==Nmonth
      good_sheet = [good_sheet(1:ii-1),good_sheet(ii+1:end)];
      continue;  % skip to next sheet
    else
      i_good = i_good + 1;
    end

    % compute monthly climatology, if needed
    if ~flag_no_compute

      tmp = reshape(y1,[Nmonth Ntime_Y/Nmonth]);
      tmp = tmp';
      y1mean = nanmean(tmp);

      if ~Ntime_YY  % default setting if YY=[]
        y1sprd = nanstd(tmp);
      end

    else 
      y1mean = y1;

      % 1) plot monthly means as line
      h(ii) = plot(x,y1mean, ...
                  line_style{ii}, ... 
                  'color',line_color(ii,:), ...
                  'linewidth',line_width);

    end

    hold on;

    % 2) plot monthly inter-annual spread

%    % line order index (to do!!! split into a different loop)
%    ii = legend_order(i);

    % shift x-axis coords to differenciate data sets
    xx = x+(i_good-3)*sprd_xshift;

    % (default) standard deviation spread as error bars,
    %    add xshift to see all error bars clearly 
    if ~flag_no_compute && ~Ntime_YY
    h(ii) =  errorbar(xx,y1mean,y1sprd, ...
                      line_style{ii}, ... 
                      'color',line_color(ii,:), ...
                      'linewidth',sprd_width);
    end

    % (if YY~=[]) YY plotted as a cloud of points 
    if Ntime_YY
      
      % squeeze and reshape 'YY' to Nmonth x Nyear
      yy1 = sqz(YY(ii,:,:));
      tmp = reshape(yy1,[Nmonth Ntime_YY/Nmonth]);

      for j=1:Nmonth
  
        % squeeze at month $j, built vertical vector
        xx_j = repmat(xx(j),[1 Ntime_YY/Nmonth]);
        yy1_j = sqz(tmp(j,:));

        % set out-of range values to [yvals(1),yvals(2)]
        below = find(yy1_j < yvals(1));
        Nbelow = length(below);
        yy1_j(below) = yvals(1);
        above = find(yy1_j > yvals(2));
        Nabove = length(above);
        yy1_j(above) = yvals(2);
        
        plot(xx_j,yy1_j,'.', ... 
             'color',line_color(ii,:), ...
             'markersize',sprd_mksize);

      end
    end

  end

  % 3) plot monthly means as bold dots, above everything else
  for i=1:Nsheet
    
    % take in sheet $i of Y
    y1 = sqz(Y(i,:));

    % compute monthly climatology, if needed
    if ~flag_no_compute
      tmp = reshape(y1,[Nmonth Ntime_Y/Nmonth]);
      tmp = tmp';
      y1mean = nanmean(tmp);

      if ~Ntime_YY  % default setting if YY=[]
        y1sprd = nanstd(tmp);
      end

    else 
      y1mean = y1;
    end

    plot(x,y1mean,'ks', ... 
         'linewidth',dot_width);

  end

% ----------------------------------------------------------------------

  %% Customize frame and axes, add legend

  % axes style and change xtick labels
  set(gca,'tickdir','out', ...
          'linewidth',frame_thick, ....
          'fontsize',tick_fontsize, ...
          'fontname','Helvetica', ...
          'fontweight','demi', ...
          'xtick',x, ...
          'xticklabel',xticklbl);

%  % rotate xticks using `xticklabel_rotate.m' BAD!
%  xticklabel_rotate(x,45,xticklbl, ...);
%                    'fontsize',tick_fontsize, ...
%                    'fontname','Helvetica', ...
%                    'fontweight','demi');

  % axis labels
  xlabel(xlab, ...
         'fontsize',tick_fontsize, ...
         'fontname','Helvetica', ...
         'fontweight','b');
  ylabel(ylab, ...
         'fontsize',tick_fontsize, ...
         'fontname','Helvetica', ... 
         'fontweight','b');

  % axis limits
  xlim([0.5,Nmonth+0.5]);
  if ~isempty(yvals)
    ylim([yvals(1),yvals(2)]); 
  end

  % add legend, outside frame
  good = find(ismember(legend_order,good_sheet));
  legend_order = legend_order(good);
  hh = h(legend_order);
  legend_strr = legend_str(legend_order);
  legend(hh,legend_strr, ...
         'linewidth',frame_thick, ...
         'fontsize',legend_fontsize, ...
         'fontweight','demi', ...
         -1);

% ----------------------------------------------------------------------

  %% Output figure

  % add 'line_' to $name 
  name = ['line_',name];

  % select output figure size
  h_fig = gcf;
  set(h_fig,'paperunits','centimeters', ...
            'paperpositionmode','manual');
  set(h_fig,'papersize',output_size);
  set(h_fig,'paperposition',[0,0,output_size]);

  % printing ouptut as as .png or an .eps
  if strcmp(out_format,'png')
    disp(['Plotting ... ',name]);
    print('-dpng',['figs/png/',name,'.png'],'-r150');
  else
    plot_print_eps; 
  end
  
  % close figure
  close(FIG);

% ----------------------------------------------------------------------

end

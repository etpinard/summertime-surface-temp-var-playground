function plot_hist2_panels(Z,opt,name,out_format)
%
% Histograms (plotted as probability density function) in the sample
% space. The number of sample points and bin width are computed here.
%
% 'Z' is a 'multi-sheet' time series, each sheet will be plotted as an
% individual line with respect to the left-hand side axis.
%
% To make a multi-panel figure, send 3-D 'Z' with 'Npanel' as the
% first dimension's length.
%
% Use `box_avg.m' for area averaging and `catsheet.m' for
% concatenating the time series.
%
% INPUT: 1) Z     , input variable(s)
%                   (Nsheet x Ntime) or (Npanel x Nsheet x Ntime).
%
%        2) opt{1} , 
%           opt{2} , (optional, must input as cell array { }) 
%                    'comp_datasets' or [] : a line for each data set,
%                    w/ input ordered as 'ccsm3','ncep_doe','hadgem1',
%                                        'era40'(,'obs').
%                    ' ' ,
%
%        3) name        , string for the output file. 
%        4) out_format  , 'png' (by default) , 'eps' or 'both'
%
% 
% *) of 'plot_hist2.m', 'xlab', 'bins', 'yval' are defined here.
% *) No support for NaN sheets as of (07/31)
% *) No support for legend_order (07/31)
%
% ====================================================================

% Things to improve $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% -) Invisible background for .eps figures! (also in plot_line_2axes)
%
% -) How to better handle out of limit sample pts? 
%     -- show fraction of sample on plot? 
%
% -) Make option to show 1 stand dev as a grid line?
%
% -) Difference between 'padding' and 'spacing' for 'subaxis.m' ?
%
% -) Try playing around with variable line width to better
%    differentiate lines. (08/02 looking great!)
%
% -) add 'opt_ann' and 'opt_box' for on plot annotation and 
%    additional 'plot_box_regions' panel.
%
% -) Support for row-wise 'yvals' , 'yticks' ,  ... , 
%    'yticklabel',  'ann_pos'
%
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  %% General aesthetic options

  axes_thick = 1.75;          % frame thickness
  axes_color = [0,0,0];       % frame color
  line_width = 2.5;           % width of continuous line
  label_fontsize = 14.5;      % label font size
  label_fontweight = 'demi';  % label font wieght
  tick_fontsize = 13;         % tick font size
  tick_fontweight = 'demi';   % tick font weight
  legend_fontweight = 'demi'; % legend font weight
  grid_width = 1.3;           % width of on-plot grid
  grid_style = '--';          % line style of on-plot grid
  grid_color = [102,102,102]; % line color of on-plot grid (RBG)
  
% ----------------------------------------------------------------------

  %% Argument-dependent options

  % parse the 'opt' argument into
  % 'opt_sytle' ( ) and ' ' ( )
  if iscell(opt)
    opt_style = opt{1};
    % = opt{2};
  else
    opt_style = opt;
    % = opt{2};
  end

  % optional 'out_format' argument 
  if nargin==3 || isempty(out_format);
    out_format = 'png';
  end

  % get dimensions
  if ndims(Z)==3
    % get # of panels, sheets and time entries in 'Z'
    [Npanel,Nsheet,Ntime] = size(Z);
  elseif ndims(Z)==2
    % get # of sheets and time entries in 'Z'
    [Nsheet,Ntime] = size(Z);
    Npanel = 1;
  end

  % set panel dimensions
  switch Npanel

    case 1;
      output_size = [12,10];      % output [width,height] in cm
      Nrow = 1;  % # of row
      Ncol = 1;  % # of columns
      legend_loc = 'northeast';   % legend location
      legend_fontsize = 10;       % legend font size

    case 3;
      output_size = [20,10];
      Nrow = 1;
      Ncol = 3;
      panel_vsep = 0;             % vertical sep. between panels
      panel_hsep = 0.01;          % horiz. sep. between panels
      panel_lmarg = 0.1;          % margin to leftmost panel
      legend_loc = 'northeast';   
      legend_fontsize = 10;      

    case 8;
      output_size = [24,12];
      Nrow = 2;
      Ncol = 4;
      tick_length = [0.015 0.0];
      xlab_pos = [2.05,-1.3,0];
      ylab_pos = [-0.3,-0.05,0];
      panel_vsep = 0.02;             
      panel_hsep = 0.01;         
      panel_lmarg = 0.1;
      panel_bmarg = 0.15;
      panel_rmarg = 0.1;
      panel_tmarg = 0.15;

      disp(['plot_hist2_panels.m: ' ... 
            'plotting 8 panels on 2 rows, ' ...
            'row major selection in ''Z''']);
      
    otherwise;
      disp('*** Unsupported input argument (Npanel) ***')
      return

  end
      
  % generate panel index array
  i_panel = zeros(Npanel,2);
  k = 1;
  for i=1:Nrow
    for j=1:Ncol
      i_panel(k,1) = i;
      i_panel(k,2) = j;
      k = k + 1;
    end
  end

%    legend_pos = [0.77,0.62,0.2,0.2];   % legend position
%    ylab_pos_l = [-0.09,0.5,0];   % l ylab pos
%    ylab_pos_r = [1.15,0.5,0];    % r ylab pos
%  elseif Npanel==2
%    legend_fontsize = 13;       % legend font size
%    legend_pos = [0.665,0.44,0.4,0.2];
%    ylab_pos_l = [-0.12,1,0];   % from bottom panel
%    ylab_pos_r = [1.18,1,0];    % ""
%    ann_pos = [0.01,0.75 ; 0.01, 0.28]; % annotation position
%    ann_text(1) = {['Box 1:' ... 
%                   char(10) 'Central US']};  % annotation text
%    ann_text(2) = {['Box 2:' ... 
%                   char(10) 'Eastern Europe']};  
%  end

% ----------------------------------------------------------------------

%% 'opt_style' arguments

  load('plotting.mat');   % load colors in 'plotting.mat'

  switch opt_style
      
    case 'tm_T_dist';
        
%      Nbins = 50;   % # of bins
      step = 0.1;   % step length
      ylab = {'Probability [-]'};

      if Nsheet==3

        line_order = [1,2,3];         
        line_style = {'-','-','-'};  
        line_color = [0,0,0; ...
                      frame_color(1,:); ...
                      frame_color(3,:)];
        line_width = [1.25*line_width, ...
                      line_width, ...
                      0.8*line_width];

        xvals = [-5,5];
        xticks = [-5:1:-2,-1.5:0.5:1.5,2:1:5];
%        xticklbl = num2cell(xticks);
        xticklbl = {'','-4','-3','-2','','-1','','0', ...
                    '','1','','2','3','4',''};
        xlab = {'T anomalies [K]'};

        yvals = [0,0.8];           
        yticks = [0:0.1:0.7];
%        yticklbl = num2cell(yticks);
        yticklbl = {'0','','0.2','','0.4','','0.6',''};

        legend_str = {'Obs. T''','Dataset T''','Toy model T'''};
        grid_vert = [0];

      elseif Nsheet==2

        line_order = [1,2];         
        line_style = {'-','-'};  
        line_color = [frame_color(1,:); ...
                      frame_color(3,:)];
        line_width = [1.25*line_width, ...
                      line_width];

        xvals = [-5,5];
        xticks = [-5:1:-2,-1.5:0.5:1.5,2:1:5];
%        xticklbl = num2cell(xticks);
        xticklbl = {'','-4','-3','-2','','-1','','0', ...
                    '','1','','2','3','4',''};
        xlab = {'m anomalies [K]'};

        yvals = [0,0.8];           
        yticks = [0:0.1:0.7];
%        yticklbl = num2cell(yticks);
        yticklbl = {'0','','0.2','','0.4','','0.6',''};

        legend_str = {'Dataset m''','Toy model m'''};
        grid_vert = [0];

      else
        disp('*** Unsupported input argument (Nsheet) ***')
        return
      end

      switch Npanel
        case 8
          legend_pos = [0.86,0.74,0.1,0.05];   
          legend_fontsize = 9;      
          title_name =  {'CCSM3.0','HadGEM1','ERA40','NCEP-DOE'};
          title_fontsize = 11;
          title_pos = [0.5,1.05,0];
          ann_panel = [1,5];
          ann_panel = [1:8];
          ann_text = {'Box dry','Box wet'};
          ann_text = repmat(ann_text,4,1);
          ann_fontsize = 9;
%            ann_pos = [0.2,0.1; 0.5,0.5];
          ann_pos = [-4.5,0.7; -4.5,0.7];
          ann_pos = repmat(ann_pos(1,:),8,1);
      end

    case 'tm_T_dist_no_m';
        
%      Nbins = 50;   % # of bins
      step = 0.1;   % step length
      ylab = {'Probability [-]'};

      if Nsheet==3

        line_order = [1,2,3];         
        line_style = {'-','-','-'};  
        line_color = [frame_color(1,:); ...
                      frame_color(3,:); ...
                      frame_color(2,:);];
        line_width = [1.25*line_width, ...
                      line_width, ...
                      0.8*line_width];

        xvals = [-5,5];
        xticks = [-5:1:-2,-1.5:0.5:1.5,2:1:5];
%        xticklbl = num2cell(xticks);
        xticklbl = {'','-4','-3','-2','','-1','','0', ...
                    '','1','','2','3','4',''};
        xlab = {'T anomalies [K]'};

        yvals = [0,0.8];           
        yticks = [0:0.1:0.7];
%        yticklbl = num2cell(yticks);
        yticklbl = {'0','','0.2','','0.4','','0.6',''};

        legend_str = {'Dataset T''','Toy model T''','T'' w/ m''=0'};
        grid_vert = [0];

      elseif Nsheet==2

        line_order = [1,2];         
        line_style = {'-','-'};  
        line_color = [frame_color(1,:); ...
                      frame_color(2,:);];
        line_width = [1.25*line_width, ...
                      0.8*line_width];

        xvals = [-5,5];
        xticks = [-5:1:-2,-1.5:0.5:1.5,2:1:5];
%        xticklbl = num2cell(xticks);
        xticklbl = {'','-4','-3','-2','','-1','','0', ...
                    '','1','','2','3','4',''};
        xlab = {'T anomalies [K]'};

        yvals = [0,0.8];           
        yticks = [0:0.1:0.7];
%        yticklbl = num2cell(yticks);
        yticklbl = {'0','','0.2','','0.4','','0.6',''};

        legend_str = {'Dataset T''','T'' w/ m''=0'};
        grid_vert = [0];

       end

      switch Npanel
        case 8
          legend_pos = [0.86,0.74,0.1,0.05];   
          legend_fontsize = 9;      
          title_name =  {'CCSM3.0','HadGEM1','ERA40','NCEP-DOE'};
          title_fontsize = 11;
          title_pos = [0.5,1.05,0];
          ann_panel = [1,5];
          ann_panel = [1:8];
          ann_text = {'Box dry','Box wet'};
          ann_text = repmat(ann_text,4,1);
          ann_fontsize = 9;
%            ann_pos = [0.2,0.1; 0.5,0.5];
          ann_pos = [-4.5,0.7; -4.5,0.7];
          ann_pos = repmat(ann_pos(1,:),8,1);
      end

    otherwise;
      disp('*** Unsupported input argument (opt_style)***')
    return

  end

% ----------------------------------------------------------------------

  %% Compute 'bins' vector
  
  % compute step length from 'xvals' and 'Nbins' (if needed)
  if ~exist('step')
    step = (xvals(2)-xvals(1))/Nbins;  
  end

  % span 'bins' 
  bins = [xvals(1):step:xvals(2)];
  Nbins = length(bins);

  % output size to stdo
  disp(['plot_hist2_panels.m: bin size --> ', num2str(step)]);

% ----------------------------------------------------------------------

  %% Display set-up
  
  % close and open window
  close;  
  FIG = figure('visible','off');

  % initialize the panel and sheet handle vector
  h_panel = zeros(Npanel,1);
  h_sheet = zeros(Nsheet,1);

  % to keep track of # of sample pts used in PDFs
  Nsample_full = zeros(Npanel,Nsheet);

  % to keep track of panel to annotate
  ann_cnt = 0;

% ----------------------------------------------------------------------

  for k=1:Npanel  %% looping through the panel(s)

  %% Generating the plot

  % assign 'Z' of panel $k
  if Npanel==1
    z = Z;
  else
    z = sqz(Z(k,:,:));
  end
  
  % position axis of panel $k
  if Npanel>1
    % call 'subaxis' to partition figure
    h_panel(k) = subaxis(Nrow,Ncol, ...
                         i_panel(k,2),i_panel(k,1), ...
                         'SpacingVert',panel_vsep, ...
                         'SpacingHoriz',panel_hsep, ...
                         'MarginLeft',panel_lmarg, ... 
                         'MarginBottom',panel_bmarg, ... 
                         'MarginRight',panel_rmarg, ... 
                         'MarginTop',panel_tmarg);
  else
    h_panel = gca;
%    h_panel = axes('position',[0 0 1 1]);
%  axes('position',axes_pos(k,:));
  end

  % Loop through every sheet
  for i=1:Nsheet

    % get line order index of 'Z'
    ii = line_order(i);

    % select data of sheet $i
    zz = sqz(z(ii,:));

    % find the # of non-NaN values in sample at sheet $i
    Nsample = length(find(~isnan(zz)));

    % save for stats output
    Nsample_full(k,i) = Nsample;
  
    % resetting the bin vector so that it includes the min & max vals
    Bins = bins;    
    if min1d(z) < bins(1); 
      Bins = [bins(1)-step,Bins]; end
    if max1d(z) > bins(Nbins); 
      Bins = [Bins,bins(Nbins)+step]; end

    % computing Probability Density Function using histograms
    [n,x] = hist(zz,Bins);
    n = n/Nsample/step;               % converting to a PDF
  
    % plotting 
    h_sheet(i) = plot(x,n);
    hold on

    % line aesthetics 
    set(h_sheet(i),'linestyle',line_style{i}, ...
                   'color',line_color(i,:), ...
                   'linewidth',line_width(i));

  end

% ----------------------------------------------------------------------

  %% Customization for every panel (frame, axes, grid)

  % axes and ticks style
  set(h_panel(k),'tickdir','out', ...
                 'ticklength',tick_length, ...
                 'linewidth',axes_thick, ...
                 'fontsize',tick_fontsize, ...
                 'fontname','Helvetica', ...
                 'fontweight',tick_fontweight, ...
                 'xtick',xticks, ...
                 'xticklabel',xticklbl, ...
                 'ytick',yticks, ...
                 'yticklabel',yticklbl);

  % axis labels 
  xlabel(h_panel(k),xlab, ...
                    'fontsize',label_fontsize, ...
                    'fontname','Helvetica', ...
                    'fontweight',label_fontweight);

  ylabel(h_panel(k),ylab, ...
                    'fontsize',label_fontsize, ...
                    'fontname','Helvetica', ... 
                    'fontweight',label_fontweight);

  % axis label position 
  if ~isempty(xlab_pos)
    xlabel(h_panel(k),xlab, ...
                      'Units','Normalized', ...
                      'Position',xlab_pos);
  end

  if ~isempty(ylab_pos) 
    ylabel(h_panel(k),ylab, ...
                      'Units','Normalized', ...
                      'Position',ylab_pos);
  end

  % axis limits 
  xlim(h_panel(k),xvals);
  ylim(h_panel(k),yvals);

  % *) Or maybe somwthing like: setting the x-axis to matsh `Bins'
%  xlim([Bins(1)-2*step,Bins(NBins)+2*step]);
  
  % add on-plot grid (after axis limits)
  if ~isempty(grid_vert)
    gridxy(grid_vert,[], ...
                     'color',grid_color./255, ...
                     'linestyle','--', ...
                     'linewidth',1.3);
  end

% ----------------------------------------------------------------------

  %% Customize for some panels (title, label ...

  % remove xtick labels
  if Npanel>1 && Nrow>1 && i_panel(k,1)<Nrow
    set(h_panel(k),'xticklabel',repmat({''},length(xticks),1));
  end
  
  % remove ytick labels
  if Npanel>1 && Ncol>1 && i_panel(k,2)>1
    set(h_panel(k),'yticklabel',repmat({''},length(xticks),1));
  end

  % remove axes labels 
  if Npanel>1 && k>1
    xlabel(h_panel(k),'');
    ylabel(h_panel(k),'');
  end

  % add legend
  if k==Npanel
    if exist('legend_pos')
      legend(h_sheet,legend_str, ...
                     'linewidth',frame_thick, ...
                     'fontsize',legend_fontsize, ...
                     'fontweight',legend_fontweight, ...
                     'position',legend_pos);
    else
      legend(h_sheet,legend_str, ...
                     'linewidth',frame_thick, ...
                     'fontsize',legend_fontsize, ...
                     'fontweight',legend_fontweight, ...
                     'location',legend_loc);
    end
  end

  % add the dataset lanel name (as a panel title)
  if Npanel==8 && i_panel(k,1)<Nrow
    title(h_panel(k),title_name{k}, ...
                     'fontsize',title_fontsize, ...
                     'fontname','Helvetica', ... 
                     'fontweight',label_fontweight, ...
                     'Units','Normalized', ...
                     'Position',title_pos);
  end

  % add multi-panel annotation
  if Npanel==8 && any(ismember(k,ann_panel))
    ann_cnt = ann_cnt + 1;
%    ax_tmp = axes('Position',[0 0 1 1],'Visible','off');
    text(ann_pos(ann_cnt,1),ann_pos(ann_cnt,2), ...
         ann_text(ann_cnt), ...
         'fontsize',ann_fontsize, ...
         'fontweight',label_fontweight);
  end

% ----------------------------------------------------------------------

  end   %% end panel loop

  %% Pring some info to stdout

  % number of points used for PDF
  for k=1:Npanel
    tmp = unique(Nsample_full(k,:));
    disp(['Histogram of panel ', ...
          num2str(i_panel(k,1)),',',num2str(i_panel(k,2)),  ...
          ' is made of ... ',num2str(tmp), ...
          ' points']);
  end

% ----------------------------------------------------------------------

  %% Output figure

  % add 'line_' to $name 
  name = ['hist_',name];

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

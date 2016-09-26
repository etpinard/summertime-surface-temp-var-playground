function plot_hist2(z,bins,xlab,name,yval,out_format)
%
% A function that plots the probability density function of the
% variable z (not necessarily 1 dimensional).
%
% 2nd generation.
%
% INPUT:        z       , function(s) to be plotted  
%                          use addsheet.m or catsheet.m before call
%                          to include several functions.
%               bin     , bin limits or full bin vector 
%               xlab    , string for x label
%               name    , string for the output file    
%                           (NEW! no need to sent ['hist_',name])
%               yval    , height the y axis           
%                           (NEW! axisval x values are determined by
%                           bins)
%               out_format  , (NEW!) 'png' or 'eps'
%                               
% ======================================================================

% Things to improve $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% -) Show percentage of out-of-range points.
% 
% -) an xlab option instead of just leaving it empty. 
%   
% -) automate yval
%
% -) add legend consistent with `annotate_text'
%
% -) make better-looking axis label e.g. rotation y label.
%    with the latex font.
%
% -) Maybe plot around with 'Layer' 'top'
%
% -) make output argument for computing PDF 
%    (aaah ... in a different procedure).
%
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  

  % Specific outputs

  opt_pres = 1;   % bigger tick labels for presentation

  % add if statement!!!

  tmp = dbstack(2);
  parent_func = tmp.name;
  
  switch parent_func
    case 'comp_tm_Var_T_bias'
      opt_comp_tm_Var_T_bias = 1;
      opt_comp_tm_Var_m_bias = 0;
    case 'comp_tm_Var_m_bias'
      opt_comp_tm_Var_T_bias = 0;
      opt_comp_tm_Var_m_bias = 1;
    otherwise
      opt_comp_tm_Var_T_bias = 0;
      opt_comp_tm_Var_m_bias = 0;
    end

% ----------------------------------------------------------------------

  % General aesthetic options
  line_width = 2.5;
  tick_fontsize = 19;
  output_size = [12,10];

  % load from plotting.mat
  load('plotting.mat');
%  line_color = frame_color;

  % new colors (11-05 !!!)
  tmp_color1 = [228,26,28]./255; 
  tmp_color2 = [55,126,184]./255;
  tmp_color3 = [77,175,74]./255;
  tmp_color4 = [152,78,163]./255;
  line_color = [tmp_color1;tmp_color4;tmp_color2;tmp_color3; ...
                tmp_color1;tmp_color4;tmp_color2;tmp_color3];
  
  % optional argument
  if nargin==5 || isempty(out_format);
    out_format = 'png';
  end
% ----------------------------------------------------------------------

  close;
  
  %set(0,'defaultAxesFontName', 'Arial');   DOES NOT WORK !!!!
  %set(0,'defaultTextFontName', 'Arial');  But keep this in mind
  %set(gca, 'Layer','top')
  
  % Disable X term output, transparent background.
  if strcmp(out_format,'png')
    FIG = figure('visible','off');
  else
    FIG = figure('visible','off', ... 
                 'color','none','InvertHardcopy','off');
  end

  % # of sheets inputed
  if ndims(z)==3
    Nsheet = size(z,1);
  else
    Nsheet = 1;
  end

  % initialize handle vector
  h = zeros(Nsheet,1);
  
  % # of sheet inputed, if time series
  if size(z,2)==90
    Nsheet = size(z,1);
  end

  % is `step' defined is input
  Nbins = length(bins);

  if Nbins>3
    tmp = diff(bins); 
    step = tmp(1);      % only works for linear `bins' vector
  else
    step = (bins(2)-bins(1))/200;  % 200 bins in total
    bins = [bins(1):step:bins(Nbins)];
    Nbins = length(bins);
    disp(['plot_hist2.m: bin size --> ', num2str(step)]);
  end

  % Resetting the bin vector so that it includes the min & max vals
  Bins = bins;    

  if min1d(z) < bins(1); 
    Bins = [bins(1)-step,Bins]; end

  if max1d(z) > bins(Nbins); 
    Bins = [Bins,bins(Nbins)+step]; end
  
  % new length of contour vector
  NBins = length(Bins);
  
  % Loop through every sheet
  for i=Nsheet:-1:1

    % make sheet $i a row vector
    if Nsheet>1
      z1 = sqz(z(i,:,:));
    else
      z1 = z;
    end

    z1 = make1d(z1);
 
    % find the # of non-NaN values in sample
    Nsample = length(find(~isnan(z1)));

    %% Computing Probability Density Function using histograms
    [n,x] = hist(z1,Bins);
    n = n/Nsample/step;               % converting to a PDF
  
    % -) plotting and customize
    h(i) = plot(x,n, ...
             'color',line_color(i,:), ...
             'linewidth',line_width);
    hold on

  end

  % -) Customize frame and axes
  set(gca,'tickdir','out', ...
          'linewidth',frame_thick, ....
          'fontsize',tick_fontsize, ...
          'fontname','Helvetica', ...
          'fontweight','normal');

  % -) axis labels
  xlabel(xlab, ...
         'fontsize',tick_fontsize, ...
         'fontname','Helvetica');
  
  % -) setting the x-axis to matsh `Bins'
  xlim([Bins(1)-2*step,Bins(NBins)+2*step]);
  
  % -) setting the y-axis, if yval is non-empty
  if ~isempty(yval)
     ylim([0,yval]);
  end

  %% specific output aesthetics: comp_tm_Var_T_bias.m 
  if opt_comp_tm_Var_T_bias

    output_size = [13,10];    

    if opt_pres 
      xtick_size = 18;
      ytick_size = 18;
    else
      xtick_size = 13;
      ytick_size = 13;
    end

    ylabel('Probability', ... 
           'fontsize',14, ...
           'fontname','Helvetica', ...
           'fontweight','demi', ...
           'rotation',0);
    ylabh = get(gca,'YLabel');
    set(ylabh,'Position',get(ylabh,'Position') + [0.45 1.32 0]);

    yticks = [0:0.5:2.5];
    yticklbl = {'0','0.5','1','1.5','2',''};
    set(gca,'ytick',yticks, ...
            'yticklabel',yticklbl, ...
            'fontsize',ytick_size, ...
            'fontweight','demi');

    xlabel('Var(T) ratio, toy model over dataset  [-]', ...
           'fontsize',14', ... 
           'fontweight','demi');
%    xlabh = get(gca,'XLabel');
%    set(xlabh,'Position',get(xlabh,'Position') + [-0.1 0 0]);
%    output_offset = []
    
    xticks = [0,0.5,0.75,1,1.25,1.5,2,2.5,3,3.5,4];
    xticklbl = {'0','0.5','','1','','1.5','2','','3','','4'};
    set(gca,'xtick',xticks, ...
            'xticklabel',xticklbl, ...
            'fontsize',xtick_size, ...
            'fontweight','demi');

   xlim([0,4.5]);

   gridxy([0.5,1,1.5],[], ...
            'color',[102,102,102]./255, ...
            'linestyle','--', ...
            'linewidth',1.3);

    models_name = {'CCSM3.0','NCEP-DOE','HadGEM1','ERA40'};
    order = [1,3,4,2];
    legend(h(order),models_name(order), ...
             'linewidth',frame_thick, ...
             'fontsize',10, ...
             'fontweight','demi', ...
             'location','northeast');

  end

  %% specific output aesthetics: comp_tm_Var_m_bias.m 
  if opt_comp_tm_Var_m_bias

    output_size = [13,10];    

    ylabel('Probability', ... 
           'fontsize',14, ...
           'fontname','Helvetica', ...
           'fontweight','demi', ...
           'rotation',0);
    ylabh = get(gca,'YLabel');
    set(ylabh,'Position',get(ylabh,'Position') + [0.45 1.52 0]);

    yticks = [0:0.5:2.5];
    yticklbl = {'0','0.5','1','1.5','2',''};
    set(gca,'ytick',yticks, ...
            'yticklabel',yticklbl, ...
            'fontsize',13, ...
            'fontweight','demi');

    ylim([0,2.7]);

    xlabel('Var(m) ratio, toy model over dataset  [-]', ...
           'fontsize',14', ... 
           'fontweight','demi');
%    xlabh = get(gca,'XLabel');
%    set(xlabh,'Position',get(xlabh,'Position') + [-0.1 0 0]);
%    output_offset = []
    
    xticks = [0,0.5,0.75,1,1.25,1.5,2,2.5,3,3.5,4];
    xticklbl = {'0','0.5','','1','','1.5','2','','3','','4'};
    set(gca,'xtick',xticks, ...
            'xticklabel',xticklbl, ...
            'fontsize',13, ...
            'fontweight','demi');

   xlim([0,4.5]);

   gridxy([0.5,1,1.5],[], ...
            'color',[102,102,102]./255, ...
            'linestyle','--', ...
            'linewidth',1.3);

    models_name = {'CCSM3.0','NCEP-DOE','HadGEM1','ERA40'};
    order = [1,3,4,2];
    legend(h(order),models_name(order), ...
             'linewidth',frame_thick, ...
             'fontsize',10, ...
             'fontweight','demi', ...
             'location','northeast');

  end
  
  % -) select output figure size
  h_fig = gcf;
  set(h_fig,'paperunits','centimeters','paperpositionmode','manual');
  set(h_fig,'papersize',output_size);
  set(h_fig,'paperposition',[0,0,output_size]);
  
  % (NEW!) output compatible with `out_format'
  name = ['hist_',name];


  if strcmp(out_format,'png')
    disp(['Plotting ... ',name]);
    print('-dpng',['figs/png/',name,'.png'],'-r150');
  else
    plot_print_eps; 
  end

  close(FIG);

end

function plot_hist(z,bins,Nsample,xlab,name,yval)
%
% A function that plots the probability density function of the
% variable z (not necessarily 1 dimensional).
%
% A histogram is first computed using bins values of $bins.
%	The results are then normalized by $Nsample times the bin width.
%
% INPUT:				z				, function to be plotted 
%								bins		, bin vector (row vector, ordered)
%								Nsample	, # of data points in the sample
%													e.g. Nland for trimmed data
%								xlab		, string for x label
%								name		, string for the output file		
%														(NEW! no need to sent ['hist_',name])
%								yval		,	height the y axis						
%														(NEW! axisval x values are determined by
%														bins)
% ======================================================================

% Things to improve $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%	
%	-) an xlab option instead of just leaving it empty. 
%		
%	-) maybe add some color.
%		 
% -) automate axisval
%
%	-) make better-looking axis label e.g. rotation y label.
%    with the latex font.
%
%	-) Should I keep Nsample as an argument : I could either compute
%		 here or less generally use Nland from global.mat
%
% -) Maybe plot around with 'Layer' 'top'
%
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
	
  % General aesthetic options
  line_width = 2.5;
  line_color = [0,0,0];
  frame_thick = 1.75;
  tick_fontsize = 13;
  output_size = [12,10];
% ----------------------------------------------------------------------

	close;
	
	%set(0,'defaultAxesFontName', 'Arial');		DOES NOT WORK !!!!
	%set(0,'defaultTextFontName', 'Arial');  But keep this in mind
  %set(gca, 'Layer','top')
	
  % Disable X term output, transparent background.
  FIG = figure('visible','off', ... 
             'color','none','InvertHardcopy','off');
	
	% Turning z into a row vector ---> using make1d.m
	z = make1d(z);

	% Resetting the bin vector so that it includes the min & max vals
	Nbins = length(bins);
	step = diff(bins); step = step(1);
	
	Bins = bins;		% Adding the extra bins --> Bins
	if nanmin(z) < bins(1); Bins = [bins(1)-step,Bins]; end
	if nanmax(z) > bins(Nbins); Bins = [Bins,bins(Nbins)+step]; end
	
	% new length of contour vector
	NBins = length(Bins);
	

	%% Computing Probability Density Function using histograms

	[n,x] = hist(z,Bins);
	n = n/Nsample/step;								% converting to a PDF
	
  % -) plotting and customize
	h = plot(x,n, ...
           'color',line_color, ...
           'linewidth',line_width);
	
	%count = histc(z,Bins);	% counting the max bin value maybe to
	%automate axisval
	%count = max(count)/Nsample/step;

  % -) setting the axes, if yval is non-empty
	if ~isempty(yval)
		axisval = [bins(1),bins(Nbins),0,yval];
		axis(axisval);
	end
	
  % -) Customize frame and axes
	set(gca,'tickdir','out', ...
          'linewidth',frame_thick, ....
          'fontsize',tick_fontsize, ...
          'fontname','Helvetica', ...
          'fontweight','demi');

		% -) axis labels
	xlabel(xlab,'fontsize',14,'fontname','Helvetica');

			% better-looking axis label.
	%ylabel('Probability', ... 
	%				'fontsize',25,'fontname','Helvetica');
	%ylabh = get(gca,'YLabel');
	%set(ylabh,'Position',get(ylabh,'Position') -[0.7 0 0]);
		% -) format tick label	(NOT POSSIBLE to change to default ticks)
	%set(gca,'
	%xticknumber=5;
	%yticknumber=4;
	%L = get(gca,'xlim');
	%set(gca,'xtick',linspace(L(1),L(2),xticknumber));
	%L = get(gca,'ylim');
	%set(gca,'ytick',linspace(L(1),L(2),yticknumber));
	
  % -) select output figure size
  h_fig = gcf;
  set(h_fig,'paperunits','centimeters','paperpositionmode','manual');
  set(h_fig,'papersize',output_size);
  set(h_fig,'paperposition',[0,0,output_size]);
	
	% printing to file using plot_print.m
	name = ['hist_',name];
	plot_print; 
  close(FIG);

end

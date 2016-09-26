function scatter_plot(X,Z,xvals,yvals,name,note,opt_line_slope)
%
% The plotting function for location-wise scatter analysis such as
% in evapofrac.m
%
% It generates location-wise scatters plots color-coded 
% by month.
%
% INPUT:				X			,		independent variable (Ntime x 1)
%								Z			,		dependent variable   (Ntime x 1)
%								xvals	,		x-axis values (put [] for automated)
%								yvals	,		y-axis values (put [] for automated)
%								name	,		name for output
%								note	,		string for annotation
%								opt_line_slope 
%											, NEW! to add a line for guidance:
%												Z = opt_line_slope*X (put [] for none)
%												ONLY works if xvals and yvals are non-empty.
% ======================================================================

% Things to improve $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%	
%	-) there is a MATLAB scatter function ... get into that
%
%	-) more general inner looping for $Nmonth~=3.
%		
% -) better automate axisval
%
%	-) make better-looking axis label 
%	
% -) better-looking annotations
%
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
	
	close;

		% loading via global.mat
	load('global.mat','Ntime','Nyear','Nmonth');
	
	FIG = figure('visible','off');		% no term X figure
		
		% -) optional line for guidance (better all other points)
		%		 only works if both xvals and yvals are non-empty
	if ~isempty(opt_line_slope) && ~isempty(xvals) && ~isempty(yvals)
	
		tmpx = linspace(xvals(1),xvals(2));
		tmpy = opt_line_slope*linspace(yvals(1),yvals(2));
		
		plot(tmpx,tmpy,'k:','linewidth',2,'markersize',10); hold on
			
			% There's gotta be a better to do this!

	end

		% creating a time vector
	t = [1:Ntime];							

		%	reshaping dependent variable into a (Nmonth x Nyear) matrix 
	Z = reshape(Z,Nmonth,Nyear);

	% Looping through the years
	for i=1:Nyear
		
			% time vector for a specific year
		tt = t(1+Nmonth*(i-1):Nmonth+Nmonth*(i-1));
		
			% plotting each month seperatly 
		plot(X(tt(1)),Z(1,i),'ro','linewidth',2.5,'markersize',12); hold on;
		plot(X(tt(2)),Z(2,i),'gs','linewidth',2.5,'markersize',12);
		plot(X(tt(3)),Z(3,i),'bd','linewidth',2.5,'markersize',12);

			%% Make this for a general $Nmonth.

	end

		% -) setting the axes
	set(gca,'FontName','Helvetica');
	set(gca,'FontSize',22);
	if ~isempty(xvals); xlim(xvals); end
	if ~isempty(yvals); ylim(yvals); end
		
		% -) put on grid
	grid on

		% -) on-plot annotation (expand this arrays please)
	if ~isempty(note); 
	
		xl = xlim;	xl = xl(2);
		yl = ylim;	yl = yl(2);
		
		tmpx = 0.6*xl;
		tmpy = 0.9*yl;

		text(tmpx,tmpy,note,'fontweight','bold');

	end
		
		% -) thicker frame, tick marks pointing outward	
	set(gca,'linewidth',2,'tickdir','out');

		% -) select output figure size
	set(gcf,'paperunits','centimeter','paperposition',[0,0,20,12]);

	% printing to file using plot_print.m
	name = ['sc',name];											% "sc" for scatter 
	plot_print; close(FIG);

end

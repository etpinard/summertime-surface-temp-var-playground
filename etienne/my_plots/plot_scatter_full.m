function scatter_plot_full(X,Y,xvals,yvals,col,name)
%
% The plotting function for global-domain scatter analysis such as
%	regimes.m
%
% It generates location-wise scatters plots color-coded 
% by month but now for all land points at a time.
%
% INPUT:				X			,	independent variable	(Nlat X Nlon)
%								Y			,	dependent variable  	( " )
%								xvals	,		x-axis values (put [] for automated)
%								yvals	,		y-axis values (put [] for automated)
%								col		,		color for plotting	(put [] for black)
%								name	,		name for output
% ======================================================================

		% Computing the number of elements in X (hence Y)
	Narray = size(X);
	dim = length(Narray);
	N = 1; 
	for i=1:dim; 
		N = N*Narray(i); 
	end

		% Reshaping to row vectors
	X = reshape(X,N,1);
	Y = reshape(Y,N,1);					

		% no term X figure
	FIG = figure('visible','off');	
	
		% default color
	if isempty(col); col = 'k'; end

		% plotting ... it is that easy (maybe use scatter)
	plot(X,Y,'.','color',col,'linewidth',1.3)
	%scatter(X,Y)

		% setting the axes
	if ~isempty(xvals); xlim(xvals); end
	if ~isempty(yvals); ylim(yvals); end

		% axis label
	set(0,'defaultAxesFontName','Helvetica');
	set(gca,'Fontsize',22);
%	xlabel('Moisture Content of the Surface Layer [mm]','fontsize',14);
%	ylabel('Evaporative fraction','fontsize',14);
	

		% put grid on
	grid on;

		% formatting and outputting		
	set(gca,'linewidth',2,'tickdir','out');
	set(gcf,'paperunits','centimeter','paperposition',[0,0,20,12]);
	name = ['sc_',name];						 % "sc" for scatter
	plot_print; close(FIG);

end

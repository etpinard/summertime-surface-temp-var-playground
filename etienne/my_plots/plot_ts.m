function ts_plot(X,Xbar,sig_X,col,name,yval)
%
% A function that plots time series of a vector X (Ntime x 1).
%
%	If specified either Xbar and sig_X both (Nmonth x 1) will also
% be plotted for comparison.
%
%		
%	INPUT:				X				, dependent varible (Ntime X 1)
%								Xbar  	, clim. monthly mean (Nmonths X 1)
%														(put [] if not wanted on plot)
%								sig_X		,	clim. stand. dev. (Nmonths X 1)
%														(put [] if not wanted on plot)
%								col			, line color (e.g. 'k', 'b') for X
%								name		, string for output figure name
%														(NEW! no need to sent ['ts_',name])
%								yval    ,	y axis plotting interval
% =======================================================================

% Things to improve $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%	
%	-) Make an option for Xbar +/- sig_X plots.
%
%	-) Make it more general for field generated by ddt.m
%
%	-) Make x tick marks more general i.e. make it work for 
%		 both the CCSM 3.0 and the GFDL 2.1 ...  maybe add model name in
%		 global.mat 
%
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
		
		% loading via global.mat
	load('global.mat','Nyear','Ntime','Nmonth');

	close; 
	
	FIG = figure('visible','off');		% no term X figure
	

		% Building the time vector
	t = [1:Ntime];			

		% if Xbar is non-empty plot it as solid black lines
	if ~isempty(Xbar);

			% mapping the clim. monthly mean to span(t)
		Xbar = reshape(repmat(Xbar,1,Nyear),Nmonth,Nyear);
	
			% ploting intra-annual continuous lines year by year
		for i=1:Nyear
		
			tt = t(1+Nmonth*(i-1):Nmonth+Nmonth*(i-1));
			plot(tt,Xbar(:,i),'k','linewidth',1.3); hold on

		end
	
	end


		%% if sig_X is non-empty plot +/- as dashed black lines
	if ~isempty(sig_X)

			% mapping the clim. std to span(t)
		sig_X = reshape(repmat(sig_X,1,Nyear),Nmonth,Nyear);
		
			% ploting intra-annual continuous lines year by year
		for i=1:Nyear

			tt = t(1+Nmonth*(i-1):Nmonth+Nmonth*(i-1));
			plot(tt,sig_X(:,i),'k--','linewidth',1.3); hold on
			plot(tt,-sig_X(:,i),'k--','linewidth',1.3); hold on

		end

	end


		%% Plot X on top of Xbar or sig_X
	
		% mapping X to Nmonth*Nyear
	X = reshape(X,Nmonth,Nyear);

		% plot both a continuous line throughout the sample
		% and (circle, squares and diamonds) for the respective
		% months.
	for i=1:Nyear

		tt = t(1+Nmonth*(i-1):Nmonth+Nmonth*(i-1));
		plot(tt,X(:,i),'color',col,'linewidth',1.5);
		plot(tt(1),X(1,i),'ko','linewidth',1.3);
		plot(tt(2),X(2,i),'ks','linewidth',1.3);
		plot(tt(3),X(3,i),'kd','linewidth',1.3);	

	end

		%% the last line in for-loop needs to be commented out for ddt.m
		%% generated data.

		% -) setting the x axis
	xlim([-2,Ntime+Nmonth]);

		% -) setting the y axis, if yval is non-empty
	if ~isempty(yval); 
		ylim(yval);
	end

		% -) setting the x ticks
	xlabs_step = 5;													% step in-between labeled ticks

	%xlabs = [1975:xlabs_step:2000];				% ticks in num GFDL 2.1
	xlabs = [1970:xlabs_step:2000];					% ticks in num CCSM 3.0
	
	Nxlabs = length(xlabs);									%	# of ticks

	xlabs_string = repmat({''},Nyear+1,1);	% intializing string array
	ii = 1;																	% a counter

		% looping through	the labeled tick years
	%for i=xlabs(1)-1971+1:xlabs_step:Nyear			% for GFDL 2.1
	for i=xlabs(1)-1970+1:xlabs_step:Nyear+1			% for CCSM 3.0
		
			% looping to convert to string 
			% leaving blank ticks as ''
		xlabs_string{i} = num2str(xlabs(ii)); 
		ii = ii + 1;

	end

		% a tick for every year, label every $xlabs_step years
	set(gca,'xtick',[1:Nmonth:Nmonth*(Nyear+1)],'xticklabel',xlabs_string);

		% -) thicker frame, tick marks pointing outward
	set(gca,'linewidth',1.2,'tickdir','out');

		% -) select output figure size
	set(gcf,'paperunits','centimeter','paperposition',[0,0,20,9]);
		
	% printing to file using plot_print.m
	name = ['ts',name];
	plot_print; close(FIG);

end

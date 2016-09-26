function ts_plot2(X,Nyear,col,name)
%
% An alternate function that plots time series of the vector X
%		
%	INPUT:				X				, dependent varible (of variable dim)
%								Nyear 	,	# of years in the sample							
%								col			, line color on plot
%								name		, string for output figure name
% =======================================================================

	%close; 
	
	% Setting plotting directories (same as plot_ts)
		%% Make sure that these directories exist 
		%% mkdir -p figs/{eps,png}
	direps = 'figs/eps/';		
	dirpng = 'figs/png/';			% for both .eps and .png outputs
	
	Ntime = length(X);						% total # of time entries
	Nmonth = Ntime/Nyear;			% infer the # of months per year

		% building the time vector
	t = [1:Ntime];			

		% saving min and max before reshaping
	Xmin = min(X);
	Xmax = max(X);

		% mapping X to Nmonth*Nyear (this works even if $Nmonth=1)
	X = reshape(X,Nmonth,Nyear);

	FIG = figure('visible','off');		% no term X figure
	
		% -) plot X
	if Nmonth~=1				% continuous line within years
		for i=1:Nyear
			tt = t(1+Nmonth*(i-1):Nmonth+Nmonth*(i-1));
			plot(tt,X(:,i),'color',col,'linewidth',1.5);
			hold on;
			% hard coded this time ... (make a loop a one point)
				% you could also add this to ts_plot.m
			plot(tt(1),X(1,i),'bo','linewidth',1.3);
			plot(tt(2),X(2,i),'ro','linewidth',1.3);
			plot(tt(3),X(3,i),'go','linewidth',1.3);
		end
	else								% continuous line throughout sample
		plot(t,X,'color',col,'linewidth',1.5);
		hold on;
		plot(t,X,'ko','linewidth',1.3);
	end

		% -) setting the axes
	axis([0,Ntime+1,Xmin-0.3*abs(Xmin),1.3*Xmax]);
		
		% -) setting the ticks		(actually quite complicated)
	xlabs_step = 5;												% step in-between ticks
	xlabs = [1975:xlabs_step:2000];				% ticks in num
	Nxlabs = length(xlabs);								%	# of ticks

	xlabs_string = repmat({''},Nyear,2);		% intializing string array
	ii = 1;																	% counter

	for i=xlabs(1)-1971+1:xlabs_step:Nyear		
			% looping to convert to string leaving blank ticks as ''
		xlabs_string{i} = num2str(xlabs(ii)); ii = ii + 1;
	end
		
		% adding back the first 1971 in the sample
	xlabs_string{1} = '1971';

		% a tick for every year, label every $xlabs_step years
	set(gca,'xtick',[1:Nmonth:Nmonth*Nyear],'xticklabel',xlabs_string);

		% -) thicker frame, tick marks pointing outward
	set(gca,'linewidth',1.2,'tickdir','out');

		% -) select output figure size
	set(gcf,'paperunits','centimeter','paperposition',[0,0,20,9]);
		
		% -) saving to an .eps and .png file
	disp(['Plotting ... ',name]);
	%print('-depsc2',[direps,name,'.eps'],'-zbuffer');
	print('-dpng',[dirpng,name,'.png'],'-zbuffer');

	close(FIG);

end

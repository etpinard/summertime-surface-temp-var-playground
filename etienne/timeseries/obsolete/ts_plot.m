function ts_plot(X,Xbar,sig_X,Nyear,col,name)
%
% A function that plots time series of the vector X
%		
%	INPUT:				X				, dependent varible (Nyear*Nmonths X 1)
%								Xbar  	, clim. monthly mean (Nmonths X 1)
%														(put NaN if not wanted on plot)
%								sig_X		,	clim. stand. dev. (Nmonths X 1)
%								Nyear 	,	# of years in the sample							
%								col			, line color (e.g. 'k', 'b') for X
%								name		, string for output figure name
% =======================================================================

	%close; 
	
	% Setting plotting directories
		%% Make sure that these directories exist 
		%% mkdir -p figs/{eps,png}
	direps = 'figs/eps/';		
	dirpng = 'figs/png/';			% for both .eps and .png outputs
	
	Ntime = length(X);						% total # of time entries
	Nmonth = Ntime/Nyear;					% infer the # of summer months

		% Building the time vector
	t = [1:Ntime];			

		% mapping the clim. monthly mean to span(t) (if it exists)
	if Xbar(1)==Xbar(1)
		Xbar = reshape(repmat(Xbar,1,Nyear),Nmonth,Nyear);
	end

		% same for the clim. stand. dev. (always will be plotted)
	sig_X = reshape(repmat(sig_X,1,Nyear),Nmonth,Nyear);
		
		% mapping X to Nmonth*Nyear
	X = reshape(X,Nmonth,Nyear);

	FIG = figure('visible','off');		% no term X figure
	
		% 1) plot Xbar	(if is exists)
	if Xbar(1)==Xbar(1) 
		for i=1:Nyear
			tt = t(1+3*(i-1):3+3*(i-1));
			plot(tt,Xbar(:,i),'k','linewidth',1.3); hold on
		end
	end

		% 2) plot Xbar+sig_X 
	if Xbar(1)==Xbar(1); 
	%tmp = Xbar+sig_X; 
	else
		tmp = sig_X; %end
		for i=1:Nyear
			tt = t(1+3*(i-1):3+3*(i-1));
			plot(tt,tmp(:,i),'k--','linewidth',1.3); hold on
		end
	end

		% 3) plot Xbar-sig_X 
	if Xbar(1)==Xbar(1); 
	%tmp = Xbar+sig_X; 
	else
		tmp = -sig_X; %end
		for i=1:Nyear
			tt = t(1+3*(i-1):3+3*(i-1));
			plot(tt,tmp(:,i),'k--','linewidth',1.3); hold on
		end
	end

		% 4) plot X
	for i=1:Nyear
		tt = t(1+3*(i-1):3+3*(i-1));
		plot(tt,X(:,i),'color',col,'linewidth',1.5);
		plot(tt(1),X(1,i),'ko','linewidth',1.3);
		plot(tt(2),X(2,i),'ks','linewidth',1.3);
		plot(tt(3),X(3,i),'kd','linewidth',1.3);
	end

		% -) setting the axes
	%axis([1,Ntime+1,min(X)-0.15*abs(min(X)),1.15*max(X)]);
	xlim([-2,Ntime+3]);
	%tmp1 = ylim;
	%ylim([ceil(tmp1)]);

		% -) setting the ticks
	xlabs_step = 5;												% step in-between ticks
	%xlabs = [1975:xlabs_step:2000];				% ticks in num
	xlabs = [1970:xlabs_step:2000];				% ticks in num
	Nxlabs = length(xlabs);								%	# of ticks
	xlabs_string = repmat({''},Nyear+1,1);		% intializing string array
	ii = 1;																% counter
	%for i=xlabs(1)-1971+1:xlabs_step:Nyear			% for GFDL
	for i=xlabs(1)-1970+1:xlabs_step:Nyear+1			% for CCSM
			% looping to convert to string 
				% leaving blank ticks as ''
		xlabs_string{i} = num2str(xlabs(ii)); ii = ii + 1;
	end

		% a tick for every year, label every $xlabs_step years
	set(gca,'xtick',[1:3:3*(Nyear+1)],'xticklabel',xlabs_string);

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

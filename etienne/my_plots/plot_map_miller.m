function plot_map_miller(x,y,Z,cvec,name,color_handle)
%
% A function that plots the 2D function "z" on a Miller projected
% world map. The grid is centered on 0 longitude.
% 
% INPUT:				x				, longitude vector
%								y				, latitude vector
%								Z				, 2D function of (x,y)
%													(NEW!) or multiple 2D functions in a 3D
%													array. The first sheet for color contouring
%													and the remaining for line contouring.
%								cvec		, contour level vector (row vector, ordered)
%								name		, string for the output file
%								color_handle , color map function handle
%
% NOTE:		-)	This function calls data_shift.m if x is in [0:360]
%					-)	The jet colormap is optimal when NCvec = 8
% ====================================================================

% Things to improve $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%	
%	-) Make the cvec argument option i.e. find a good way to 
%		 automatically compute the contour levels
%		 
% -) Make a more general color bar tick string assignment process.
%		 including better '0' tick handling.
%
%	-) Add the cheeky move adding a value > max(cvec) (and/or <
%		 min(cvec) to make the color maps have an outside-range color(s).
%		 --- see regressions/subroutines/regrs_single_plot.m Line 33
%				 for example. like a 'keep above' / 'keep below' or 'keep
%				 both' options.
%		
% -) extend Z options to more than 2 sheets.
%		 and make m_contour better-looking
%
%	-) As the CCSM 3.0 and the HadGEM1 do not use the same latitude
%		 vector, the frame height is slightly diffrent from one model to
%		 the next. Look into how to change that. Oooof I don't know.
%
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

	close;
	
	%% Set default plot options	--- to keep in mind ---
	%set(0,'defaultaxesfontsize',20);
	%set(0,'defaulttextfontsize',20);
	%set(0,'defaultlinelinewidth',1.5);
	
	% load Iland
	load('global.mat','Iland');

	% add path to color maps
	addpath('/home/disk/p/etienne/proj/etienne/my_plots/color_maps/');

	FIG = figure('visible','off');		% no term X figure
	
	% (NEW!) Take first sheet of Z as z if Z is 3D, 
	% the 2D field to be color contoured --> using sqz.m
	if ndims(Z)>2
		z = sqz(Z(1,:,:));
		opt_overlay = 1;
	else
		z = Z;
		opt_overlay = 0;
	end

	% Removes non-land grid boxes (again!) using Iland
	z = Iland.*z;	
		%% Note this must be done before data_shift.m


	% Calls data_shift to shift the grid to [-180:180] if needed
	if (x(1) >= 0) 
		[z,x] = data_shift(x,z);	
	end

	% A simple way to automate cvec
	% However, min and max are often ill-behaved 
	if isempty(cvec)
		z1 = make1d(z);
		step = round((max(z1)-min(z1))/20);
		cvec = [min(z1):step:max(z1)];
	end

	% Expand the contour levels to include outside $cvec values in the
	% the color map and color bar if needed
	Ncvec = length(cvec);
	step = diff(cvec); step = step(1);
	z1 = make1d(z);
	
	Cvec = cvec;		% Adding the extra levels --> Cvec
	if nanmin(z1) < cvec(1); Cvec = [cvec(1)-step,Cvec]; end
	if nanmax(z1) > cvec(Ncvec); Cvec = [Cvec,cvec(Ncvec)+step]; end

	% new length of contour vector
	NCvec = length(Cvec);

	% values outside the extended levels are mapped to $Cvec
	caxis([Cvec(1),Cvec(NCvec)]);

	% Custom color map if color_handle exists
	check = 'color_handle';
	if exist(check) && ~isempty(color_handle);
	
			% compute the color map using the handle function
		cmap = color_handle(Cvec);

			% apply it to plot
		colormap(cmap)

	else

		colormap(jet(NCvec-1));			% 1 color less than contour levels 
		%colormap(hsv(NCvec-1));		% or alternatively

	end		
	
	% (NEW!) set all out-of-bounds values to end contour(s)
	toosmall = find(z<Cvec(1));
	z(toosmall)=Cvec(1);
	toobig = find(z>Cvec(NCvec));
	z(toobig) = Cvec(NCvec);

	% One every two tick will be blanked 
	step = 2;
	c_string = repmat({''},Ncvec,1);		% intializing string array
	for i=1:2:Ncvec
		if cvec(i) >= 0				% adding an extra white space 
			c_string{i} = [' ',num2str(cvec(i))];
		else
			c_string{i} = num2str(cvec(i));
		end
	end


	%% Using the m_map set of procedures (~/proj/m_map/)
		
		% -) select projection type
	m_proj('miller','lat',[-55,77],'lon',[x(1),x(end)]);		
	%m_proj('miller','lat',[-90,90],'lon',[x(1),x(end)]);		
		
		% -) remove grid, thicker box
	m_grid('xtick',[],'ytick',[],'linewidth',1.2); hold on
		
		% -) plot data (without contour lines)
	m_contourf(x,y,z,Cvec,'linestyle','none');
		
		% -) (if given) plot additional overlay contour(s)
	if opt_overlay
		o = sqz(Z(2,:,:));
		o = data_shift(x,o);	
		m_contour(x,y,o, ...
				'linestyle','-','color',[0.1,0.1,0.1],'linewi',0.25);

		% and add suffix to output name
		name = [name '_Ov'];
	end

		% -) draw coast lines 
	m_coast('color',[0 0 0],'linewidth',0.75);
		
		% -) add color bar
	caxis([Cvec(1),Cvec(NCvec)]);
	h = colorbar('ticklength',[0.06 0.06], ... 
				'ytick',cvec,'yticklabel',c_string, ... 
				'fontsize',12,'fontname','Helvetica');

		% -) thicker frame
	set(h,'linewidth',1.2);

		% -) select output figure size
	set(gcf,'paperunits','centimeter','paperposition',[0,0,20,10]);

		% printing ouptut using plot_print.m
	plot_print; close(FIG);

end

%%% Plotting the temperautre damping term and its residual
	% versus various field for the locations.
	% These fields include temperature, moisture ...
	%
	% Here, plot_scatter_locs is used to facilitate looping
	% across all the locations.
% ======================================================================
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m , locations.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%% Plot the projection coefficient of HH on TT vs. Tbar (like David)

X = sqmean(Tbar);								% Nlat X Nlon
[tmp,junk] = regrs(HH,TT);				% W/m^2/K
Y = sqmean(tmp);
mystats(X)
mystats(Y)

plot_scatter_full(X,Y,[260,320],[-10,50],[],'kappa-Tbar');
% ======================================================================


%% old stuff below %%

break

%% Damping residual

%% Plotting normalized H0H0 w.r.t normalized mm

X = mm./xmonth(mbar);
Z = H0H0./xmonth(Hbar);
xvals = [-1,1];	yvals = [-0.15,0.15];
note_before = 'mbar = ';
note_eval = 'num2str(nanmean(sqz(mbar(:,ilat,ilon))))';
name = 'H0H0-Hbar_mm-mbar';

plot_scatter_locs;
% ======================================================================

%% Plotting normalized H0H0 w.r.t normalized PP

X = PP./xmonth(Pbar);
Z = H0H0./xmonth(Hbar);
xvals = [-1.5,1.5];	yvals = [-0.15,0.15];
note_before = 'Pbar = ';
note_eval = 'num2str(nanmean(sqz(Pbar(:,ilat,ilon)))*secinday)';
name = 'H0H0-Hbar_PP-Pbar';

plot_scatter_locs;
% ======================================================================

%% Plotting normalized HH w.r.t normalized PcPc (convective precip)
	
	% extract Pc from netCDF file using getnewvar.m
if ~exist('Pc') || ~exist('Pcbar') || ~exist('PcPc') || ~exist('sig_Pc')
	[Pc,Pcbar,PcPc,sig_Pc] = getnewvar('prc');
end

X = PcPc./xmonth(Pcbar);
Z = H0H0./xmonth(Hbar);
xvals = [-1.5,1.5];	yvals = [-0.15,0.15];
note_before = 'Pcbar = ';
note_eval = 'num2str(nanmean(sqz(Pcbar(:,ilat,ilon)))*secinday)';
name = 'H0H0-Hbar_PcPc-Pcbar';

plot_scatter_locs;
% ======================================================================

break

%% (full) Damping term.

%% Plotting normalized HH w.r.t normalized TT

X = TT./xmonth(Tbar);
Z = HH./xmonth(Hbar);
xvals = [-0.04,0.04];	yvals = [-0.4,0.4];
note_before = 'Tbar = ';
note_eval = 'num2str(nanmean(sqz(Tbar(:,ilat,ilon))))';
name = 'HH-Hbar_TT-Tbar';

plot_scatter_locs;
% ======================================================================

%% Plotting normalized HH w.r.t normalized mm

X = mm./xmonth(mbar);
Z = HH./xmonth(Hbar);
xvals = [-1,1];	yvals = [-0.4,0.4];
note_before = 'mbar = ';
note_eval = 'num2str(nanmean(sqz(mbar(:,ilat,ilon))))';
name = 'HH-Hbar_mm-mbar';

plot_scatter_locs;
% ======================================================================

%% Plotting normalized HH w.r.t normalized PP

X = PP./xmonth(Pbar);
Z = HH./xmonth(Hbar);
xvals = [-1.5,1.5];	yvals = [-0.4,0.4];
note_before = 'Pbar = ';
note_eval = 'num2str(nanmean(sqz(Pbar(:,ilat,ilon)))*secinday)';
name = 'HH-Hbar_PP-Pbar';

plot_scatter_locs;
% ======================================================================

%% Plotting normalized HH w.r.t normalized PcPc (convective precip)
	
	% extract Pc from netCDF file using getnewvar.m
if ~exist('Pc') || ~exist('Pcbar') || ~exist('PcPc') || ~exist('sig_Pc')
	[Pc,Pcbar,PcPc,sig_Pc] = getnewvar('prc');
end

X = PcPc./xmonth(Pcbar);
Z = HH./xmonth(Hbar);
xvals = [-1.5,1.5];	yvals = [-0.4,0.4];
note_before = 'Pcbar = ';
note_eval = 'num2str(nanmean(sqz(Pcbar(:,ilat,ilon)))*secinday)';
name = 'HH-Hbar_PcPc-Pcbar';

plot_scatter_locs;
% ======================================================================

break

%% Plotting H0H0 w.r.t mm ...

X = mm./xmonth(mbar);
Z = L*E./F;
xvals = [-1,1];	yvals = [0,0.3];
note_before = 'mbar = ';
note_eval = 'num2str(nanmean(sqz(mbar(:,ilat,ilon))))';
name = 'LE-F_mm-mbar';

plot_scatter_locs;
% ======================================================================

for i=1:Nlocs			% looping through the locations

	ilat = Ilat(i); ilon = Ilon(i);		% coordinate of location $i

		% allocating for HH and mm at locations $i
	tmpH = squeeze(H0H0(:,ilat,ilon));
	tmpm = squeeze(mm(:,ilat,ilon));
	
		% HH vs mm
	name = ['H0H0_mm', num2str(i)];
	scatter_plot(tmpm,tmpH,Nyear,[],[-50,50],name,[]);

end
% ======================================================================

break

%% Plotting H vs m and HH vs mm ...

for i=1:Nlocs			% looping through the locations

	ilat = Ilat(i); ilon = Ilon(i);		% coordinate of location $i

		% allocating for H and m at locations $i
	tmpH = squeeze(H(:,ilat,ilon));
	tmpm = squeeze(m(:,ilat,ilon));
	
		% H vs m
	name = ['H_m', num2str(i)];
	scatter_plot(tmpm,tmpH,Nyear,[],[350,700],name,[]);
		
		% allocating for HH and mm at locations $i
	tmpH = squeeze(HH(:,ilat,ilon));
	tmpm = squeeze(mm(:,ilat,ilon));
	
		% HH vs mm
	name = ['HH_mm', num2str(i)];
	scatter_plot(tmpm,tmpH,Nyear,[],[-150,150],name,[]);

end
% ======================================================================

%% Plotting H vs T and HH vs TT ...

for i=1:Nlocs			% looping through the locations

	ilat = Ilat(i); ilon = Ilon(i);		% coordinate of location $i

		% allocating for H and T at locations $i
	tmpH = squeeze(H(:,ilat,ilon));
	tmpT = squeeze(T(:,ilat,ilon));
	
		% H vs T
	name = ['H_T', num2str(i)];
	scatter_plot(tmpT,tmpH,Nyear,[275,315],[350,700],name,[]);
		
		% allocating for HH and TT at locations $i
	tmpH = squeeze(HH(:,ilat,ilon));
	tmpT = squeeze(TT(:,ilat,ilon));
	
		% HH vs TT
	name = ['HH_TT', num2str(i)];
	scatter_plot(tmpT,tmpH,Nyear,[-10,10],[-150,150],name,[]);

end
% ======================================================================

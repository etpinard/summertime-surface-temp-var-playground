%%% Computing and plotting the evaporation fraction as a function of
	% soil moisture (top and bottom layers) for the locations.
	%
	% Here, plot_scatter_locs is used to facilitate looping
	% across all the locations.
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m , locations.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

X = m;
Z = L*E./F;
xvals = [0,40];
yvals = [0,0.3];
note_before = 'mbar = ';
note_eval = 'num2str(nanmean(sqz(mbar(:,ilat,ilon))))';
name = 'LE-F_m';

plot_scatter_locs;
% ======================================================================

if ~exist('Hs')
	[Hs,Hsbar,HsHs,sig_Hs] = getnewvar('hfss',opt_anom_Var); end

X = m;
Z = Hs./F;
xvals = [0,40];
yvals = [0,0.3];
note_before = 'mbar = ';
note_eval = 'num2str(nanmean(sqz(mbar(:,ilat,ilon))))';
name = 'Hs-F_m';

plot_scatter_locs;
% ======================================================================

break

%% Transitional (dry) to wet soil regime threshold
m_crit = 20;		% in mm
% ======================================================================

%% Wet regimes, what controls E when LE/F is a constant (or even a
 % negative function) of m. 

% Remove wet entries
wet = find(m > m_crit);
EE_dry = EE;
EE_dry(wet) = NaN;

X = F0F0;
Z = L*EE_dry;
xvals = [-125,125];	yvals = [-125,125];
note_before = []; note_eval = [];
name = 'LEEdry_F0F0';

plot_scatter_locs;

X = mm;
Z = L*EE_dry;
xvals = [-20,20];	yvals = [-125,125];
name = 'LEEdry_mm';

plot_scatter_locs;
% ======================================================================

break

%% Wet regimes, what controls E when LE/F is a constant (or even a
 % negative function) of m. 

% Remove dry entires
dry = find(m < 20);
EE_wet = EE;
EE_wet(dry) = NaN;

X = F0F0;
Z = L*EE_wet;
xvals = [-125,125];	yvals = [-125,125];
note_before = []; note_eval = [];
name = 'LEEwet_F0F0';

plot_scatter_locs;

X = mm;
Z = L*EE_wet;
xvals = [-20,20];	yvals = [-125,125];
name = 'LEEwet_mm';

plot_scatter_locs;
% ======================================================================

break

%% Top-layer soil moisture.

%% Plotting the evaporative fraction w.r.t normalized top-layer moisture
 % anomalies i.e m'/mbar

X = mm./xmonth(mbar);
Z = L*E./F;
xvals = [-1,1];	yvals = [0,0.3];
note_before = 'mbar = ';
note_eval = 'num2str(nanmean(sqz(mbar(:,ilat,ilon))))';
name = 'LE-F_mm-mbar';

plot_scatter_locs;
% ======================================================================

%% Plotting the evaporative fraction w.r.t soil moisture 

X = m;
Z = L*E./F;
xvals = [0,40];	yvals = [0,0.3];
note_before = 'mbar = ';
note_eval = 'num2str(nanmean(sqz(mbar(:,ilat,ilon))))';
name = 'LE-F_m';

plot_scatter_locs;
% ======================================================================

break

%% Bottom-layer soil moisture

%% Plotting the evaporative fraction w.r.t normalized bottom-layer 
 % moisture anomalies i.e m'/mbar

X = mbmb./xmonth(mbbar);
Z = L*E./F;
xvals = [-0.1,0.1];	yvals = [0,0.3];
note_before = 'm_bbar = ';
note_eval = 'num2str(nanmean(sqz(mbbar(:,ilat,ilon))))';
name = 'LE-F_mbmb-mbbar';

plot_scatter_locs;
% ======================================================================

%% Plotting the evaporative fraction w.r.t bottom-layer soil moisture 

X = mb;
Z = L*E./F;
xvals = [400,1200];	yvals = [0,0.3];
note_before = 'm_bbar = ';
note_eval = 'num2str(nanmean(sqz(mbbar(:,ilat,ilon))))';
name = 'LE-F_mb';

plot_scatter_locs;
% ======================================================================


break

%% Evaporative flux L*E w.r.t m

z = L*tmpE;
name = ['LE_m', num2str(i)];
evapofrac_plot(tmpm,z,Nyear,[0,40],[0,170],name);

%% Evaporative flux w.r.t F
	
z = L*tmpE;
name = ['LE_F', num2str(i)];
evapofrac_plot(tmpF,z,Nyear,[400,700],[0,170],name);
		
%% Eaporative flux w.r.t (Fm)
z = L*tmpE;
name = ['LE_Fm', num2str(i)];
evapofrac_plot(tmpF.*tmpm,z,Nyear,[],[0,170],name);

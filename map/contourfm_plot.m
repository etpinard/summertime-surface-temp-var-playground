function [cs,h]=contourfm_shift(lon,lat,data,v)
% this function takes an array of data on the 0 360 grid and shifts it
% to the -180 180 grid
   cst = load('coast');
%clf;
  %  axesm('mapprojection', 'giso', 'maplatlimit', [-60 90], ...
 axesm('mapprojection', 'eqdcylin', 'maplatlimit', [-60 90], ...
               'maplonlimit', [0 360], 'origin',[0 0]);
 plotm(cst.lat, cst.long, 'color', [.3 .3 .3], 'linewidth', 1); hold on; ...
     axis tight;
 hold on;
 
 % since we want the GM in the center of the plot, we need to add an extra
 % row of numbers,so we don't get a white strip of missing data at the GM
 
 lon = [lon' lon(1)+360];
 data=[data data(:,1)];

 if (nargin == 4)
%     [cs,h]=contourm(lat,lon,data_shift,v);
  [cs, h] = contourfm(lat, lon, data,v);

 else
     cs=[];h=[];
  contourfm(lat, lon, data);
 end

	set(gca,'FontSize',18)
    colorbar('FontSize',18)
% gridm on; % set to off to delete grid
 axis tight;
hold off;
end


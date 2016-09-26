function [Y,Iland,Nland] = land_only(X,mbar,m_range,lat,lat_range)
% 
% A function that trims (i.e. replace original values for NaNs) 
% the array X	to land only excluding ocean, lake, glacier
%	and "saturated" grid boxes.
%
%	Precisely, it 1) Removes ocean grid boxes using a soil moisture 
%									 variable as guidance.
%								2) Removes lakes and/or staturated grid boxes using 
%									 mean soil moisture (either top, bottom or full
%									 depending on the model). That is, X which are 
%									 < m_range(1) and > m_range(2) are trimmed.
%								3) Removes very high-latitude grid boxes (consistently
%									 with plot_map_miller.m).
% 
% INPUT:	  X					, variable to trim	(Ntime X Nlat X Nlon)
%						mbar			, mean soil moisture (Nmonth X Nlat X Nlon)
%												OR soil moisture (Ntime X Nlat X Nlon) in
%												which mbar is computed here.
%												It can either be m , m_b or m_f depending on 
%												what works best for a given model. 
%												See distribution2/dist.m for analysis.
%						m_range		,	min and max of mbar for trimming
%						lat				, latitude vector
%						max_lats	, min (SH) and max (NH) latitudes for trimming
%
% OUTPUT:		Y					, output trimmed array (Ntime X Nlat X Nlon)
%						Iland			, indices of land only grid boxes (Nlat x Nlon)
%												filled with NaNs and 1s
%						Nland			, number of land only grid boxes
%
% Note: I purposely do not call global.mat in case the trim.m call
%				occurs before save('global.mat' ...) in some script.
%				This is probably not needed. You can append .mat files.
% ====================================================================

		
		% initializing the output array	with X
	out = X;

		% if mbar is (Ntime X Nlat X Nlon) , or (Nmonth X Nlat X Nlon)
	if size(mbar,1)==size(X,1)

			% 1) remove ocean grid boxes for all time entry
		notland = find(isnan(mbar));
		out(notland) = NaN;
	
	else

			% expand mbar to (Ntime X Nlat X Nlon)
		tmp = repmat(mbar,size(X,1),1);
	
			% 1) remove ocean grid boxes
		notland = find(isnan(tmp));
		out(notland) = NaN;

	end

		% compute the summer mean soil moisture 
	mbar = sqmean(mbar);				% Nlat X Nlon

		%% Note that this is equivalent to sqmean(anomaly(mbar))


		% 2) remove lakes and saturated grid boxes

		% -) then trim less than values
	[notgood2,notgood3] = find(mbar<m_range(1));	
	N = length(notgood2);		% same as notgood3
	for i=1:N; 
		out(:,notgood2(i),notgood3(i)) = NaN; 
	end

		% -) first trim greater than values
	[notgood2,notgood3] = find(mbar>m_range(2));
	N = length(notgood2);		% same as notgood3
	for i=1:N; 
		out(:,notgood2(i),notgood3(i)) = NaN; 
	end


		% 3) remove high latitude using lat
	
		% -) first for SH
	notgood = find(lat<lat_range(1));
	out(:,notgood,:) = NaN; 
	
		% -) then for NH			
	notgood = find(lat>lat_range(2));
	out(:,notgood,:) = NaN; 
	

		% outputting Y
	Y = out;

	if nargout>1		% to speed startup_full.m
	
			% find land indices (Nlat X Nlon)
		[tmpx,tmpy] = find(~isnan(sqz(Y(1,:,:))));		% just one sheet
		
			% fill in array such that Iland 
		Iland = repmat(NaN,[size(X,2),size(X,3)]);
		Nland = length(tmpx);		% same as tmpy
		for i=1:Nland; 
			Iland(tmpx(i),tmpy(i)) = 1; 
		end

	end

end

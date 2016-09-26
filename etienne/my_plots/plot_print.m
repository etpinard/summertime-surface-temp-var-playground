%%% Printing procedure included in all plotting functions.
	% Uses '-zbuffer' when the X11 terminal is enable.
	% For screen sessions without X11, the resolution is 
	% set manually. 
% ====================================================================


	% load model_name from global.mat
	if ~exist('model_name') 
		load('global.mat','model_name'); end

	% Setting plotting directories
		%% Make sure that these directories exist 
		%% mkdir -p figs/{eps,png}
	direps = 'figs/eps/';		
	dirpng = 'figs/png/';			% for both .eps and .png outputs

	% Setting the resolution 
		% I could automate this using the env. var. in Matlab.
	%reso = '-zbuffer';
	reso = '-r150';

	% If wanted, add $model_name to $name
	if ~opt_print_no_name
		name = [model_name,'_',name];
	end

	% print to screen
	disp(['Plotting ... ',name]);

	% save as .png 
	%print('-depsc2',[direps,name,'.eps'],'-painters');
	print('-dpng',[dirpng,name,'.png'],reso);


%	% print in file which model the outputs used	***NO!
%	if ~exist([dirpng,'/WHICHMODEL'],'file')			% make for direps too!
%		fid = fopen([dirpng,'WHICHMODEL'],'wt');
%	else
%		fid = fopen([dirpng,'WHICHMODEL']);
%		ftmp = fopen('tmp');
%		while ~feof(fid)
%			tline = fgetl(fid);
%				if 
%				%% STILL A WORK IN PROGRESS ... fscanf fgetl ...
%		end
%	end
%	fprintf(fid,'%s\r\n', [name,' : ',model_name]);
%	fclose(fid);

% ====================================================================

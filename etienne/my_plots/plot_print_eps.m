%%% Printing procedure for .eps outputs.
% ====================================================================

  % (maybe) margin trimming commands here

  % (maybe) transparency command

	% load model_name from global.mat
%	if ~exist('model_name')
%		load('global.mat','model_name'); end

	% plotting directories, make sure that it exist;
	direps = 'figs/eps/';		

	% add $model_name to $name
	%name = [model_name,'_',name];

	% print to screen
	disp(['Plotting ... ',name, ' ... as an .eps']);

	% save as .eps -- must use painters for 'true' .eps output
	print(FIG,'-depsc2',[direps,name,'.eps'],'-painters');
  %export_fig tmp.eps -transparent -painters

% ====================================================================

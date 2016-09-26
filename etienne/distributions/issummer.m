%%% My Matlab programme that verifies if summer is indeed JJA 
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m , dist.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

name = 'issummer';
xlab = 'Summer mean surface temperatures  [C]';		

% Setting plotting directories
	%% Make sure that these directories exist 
	%% mkdir -p figs/{eps,png}
direps = 'figs/eps/';		
dirpng = 'figs/png/';			% for both .eps and .png outputs

z1 = squeeze(Tbar(1,:,:))-273.15;
z2 = squeeze(Tbar(2,:,:))-273.15;
z3 = squeeze(Tbar(3,:,:))-273.15;
colors = {'b','r','k'};

% Turning "z" into a row vector
nx = size(z1,2); 
ny = size(z1,1);
N = nx*ny;
z1 = reshape(z1,N,1);	
z2 = reshape(z2,N,1);	
z3 = reshape(z3,N,1);	

% Resettint the bin vector so that it includes the min & max vals
bins = [-10:40];
step = diff(bins);
step = step(1);
bvec = [min([z1;z2;z3]):step:max([z1;z2;z3])];

FIG = figure('visible','off');		% no term X figure

for i=1:3

	eval(['z = z' char(num2str(i)) ';']);

		% -) histogram from data
	[n,x] = hist(z,bvec);
	
		% -) building a CDF
	count = histc(z,bvec);
	cdf = repmat(NaN,length(bvec),1);
	for k=1:length(bvec); cdf(k) = sum(count(1:k)); end
	cdf = cdf/Nland/step;
	
		% -) Plotting
	plot(x,cdf,'color',char(colors(i)),'linewidth',1.5); hold on

end

	% -) setting the axes back to the original bins vector
axis([bins(1),bins(end),0,1.05]);

	% -) thicker frame, tick marks pointing outward
set(gca,'linewidth',1.2,'tickdir','out');

	% -) axis labels
xlabel(xlab,'fontsize',14,'fontname','Helvetica');
ylabel('Cumulative Probability', ... 
				'fontsize',14,'fontname','Helvetica');

	% -) legend
legend('First','Second','Third','location','northwest');

	% -) select output figure size
set(gcf,'paperunits','centimeter','paperposition',[0,0,12,10]);


plot_print;
close(FIG);

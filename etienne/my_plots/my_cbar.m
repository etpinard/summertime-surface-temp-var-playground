function my_cbar(cvec,Cvec,units,c_pos,out_format)
%
% My customized colorbar function.
%
% Custom, tick marks and labels are implemented.
% Custom alignment and other aesthetic modification are also found here.
%
% (07/02) Support for non-linear (jointly with `x_cvec.m') 'cvec' !
%
% INPUT:  cvec  , given contour vector (used for tick marks)
%         Cvec  , expanded contour vector (see x_cvec.m)
%         units , (NEW! 05/27) unit string
%         c_pos , color bar position in standard MATLAB notation:
%                 [left bottom width height tick_length] 
%                 in current frame in normalized units.
%         out_fomat, 'png' or 'eps' , changes the tick label alignment
%
% ======================================================================

% Things to improve $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%	
% -) Make a more general color bar tick string assignment process.
%		 including better '0' tick handling, and units position.
%
% -) Variable `tick_fontsize' in different context. 
%
% -) Tick lengths compability.
%
% -) More general dimensions ... ooof
%
% -) *** Try an horizontal color bar at the bottom of miller maps.
%
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  %% Aesthetic options for color bar.

  frame_thick = 1.75;
  tick_fontsize = 20;
  yl_fontsize = 18;
  tick_fontweight = 'normal';
%  tick_fontsize = 16;
%  tick_fontweight = 'demi';
  opt_label_ontick = 0; % =1: units on tick, =0 units below color bar
% ----------------------------------------------------------------------
  
  %% Optional arguments and definitions

  % needs special care when called from `plot_map_miller2.m'
  tmp = dbstack(1);
  parent_func = tmp.name;
  if strcmp(parent_func,'plot_map_miller2')
    tick_fontsize = 16;
    yl_fontsize = 14;
  end
  if strcmp(parent_func,'plot_scatter_ccols')
    tick_fontsize = 16;
    yl_fontsize = 14;
  end

  % if tick_length is given or not
  if nargin>=4
    tick_length = [c_pos(5),c_pos(5)];
    c_pos = c_pos(1:4);
  else
    tick_length = [0.06,0.06];
  end

  % optional `out_format' argument
  if nargin<5 
    out_format = 'png'; end

  % optional `units' argument
  if nargin<3
    units = ''; end

  % Input lengths
  Ncvec = length(cvec);
  NCvec = length(Cvec);

  % If cvec (or should this be Cvec) has too many entries,
  % only 1 tick out of 2 will be labeled. 
  if Ncvec>11
    string_step = 2;
  else
    string_step = 1;
  end

  % special care for plot_5panels and plot_6panels
  tmp = dbstack(1);
  parent_func = tmp.name;
  if strcmp(parent_func,'plot_5panels') || ...
       strcmp(parent_func,'plot_6panels')
    string_step = 1;
  end

  % a '-' is 2 characters in .eps and 1 in .png
  if strcmp(out_format,'eps')
    offset = '  ';
  else
    offset = ' ';
  end
% ----------------------------------------------------------------------

  % Very simply, here the tick marks are the `cvec' entries.
  c_tick = cvec;

  % Fill in the tick labels in `c_string'. 
  c_string = repmat({''},Ncvec,1);
  
  % 1) Add extra whitespace for negative and postive tick to line up.
  for i=1:string_step:Ncvec

    % add `offset' if positive
    if cvec(i) >= 0				
      c_string{i} = [' ',offset,num2str(cvec(i))];
    else
      c_string{i} = [' ',num2str(cvec(i))];
    end

  end

  if opt_label_ontick

  % 2) Add unit to first c_string entry if cvec(:) > 0 
  % or the zero entry otherwise
  % (06/04) could be better ...
  neg = find(cvec < 0);
  if isempty(neg)
    c_string{1} = [' ',offset,num2str(cvec(1)),' ',units];
  else
    tmp = find(cvec==0.0);
    c_string{tmp} = [' ',offset,num2str(cvec(tmp)),'  ',units];
  end

  end

  % 3a) Add '+' to last c_string entry if Cvec(NCvec) > cvec(Ncvec)
  if Cvec(NCvec) > cvec(Ncvec)
    c_string{Ncvec} = [' ',offset,num2str(cvec(Ncvec)),'+'];
  end

  % 3b) Add '-' to first c_string entry if Cvec(1) < cvec(0)
  if Cvec(1) < cvec(1)
    if cvec(1) >= 0
      c_string{1} = [' ',offset,num2str(cvec(1)),'-'];
    else
      c_string{1} = [' ',num2str(cvec(1)),'-'];
    end
  end

% ----------------------------------------------------------------------

  %% Print the colorbar

  % Set colorbar axis limits
	caxis([Cvec(1),Cvec(NCvec)]);

  % *** However, in a multi-panel plot, 
  %     one must set it after each panel!
    
  % Print colorbar, save handle
  h = colorbar;
  
  % Set position (must be before every other aethestic options!)
  if nargin>=4
    set(h,'position',c_pos); end

  % Set ylim to include all of Cvec even if cvec is odd.
  set(h,'ylim',[Cvec(1),Cvec(NCvec)]);
  
  % Find tick positions (pre-07/02, this was simply 'cvec')
  c_tick_pos = Cvec;
  test = (abs(c_tick_pos(1)-cvec(1))<=eps(cvec(1)));
  if ~test
    c_tick_pos = c_tick_pos(2:end); end
  test = abs(c_tick_pos(end)-cvec(end)<=eps(cvec(end)));
  if ~test
    c_tick_pos = c_tick_pos(1:end-1); end

  % Customize using `c_tick', `c_string' and many more ...
  set(h,'ticklength',tick_length, ... 
        'ytick',c_tick_pos, ...
        'yticklabel',c_string, ...
        'fontsize',tick_fontsize, ...
        'fontname','Helvetica', ...
        'fontweight',tick_fontweight, ...
        'linewidth',frame_thick);

  if ~opt_label_ontick && nargin>=4 && ~isempty('units')
 
  % 2') Place units below color bar
  h_yl = ylabel(h,units, ...
                'rotation',0, ...
                'fontsize',yl_fontsize, ...
                'fontweight','demi');
  pos_yl = get(h_yl,'position');

  % shift label in function of input c_pos(2)
  switch c_pos(2)
    % for plot_{2,3,6}panels.m
    case {0.25,0.3}; c_pos_shift = [1.25,-0.35];
    % for plot_{4,5}panels.m , plot_sc_miller.m
    case {0.2,0.18}; c_pos_shift = [1.25,-0.25];
    otherwise; 
      disp('missing length in my_cbar.m'); c_pos_shift = 0;
  end
      
  pos_yl = c_pos(1:2) + c_pos_shift;
   
  set(h_yl,'units','normalized', ...
           'verticalalignment','top', ...
           'horizontalalignment','center', ...
           'position',pos_yl);
  
  end

% ----------------------------------------------------------------------

% ======================================================================
% ======================================================================
% ======================================================================

%  % Add triangle if *look at cbarf* 
%  fill([0 1 .5],[L(end) L(end) L(end)+diff(yl)/15],cor,'clipping','off');
%
%       % 'position',[c_pos(1)+0.1,c_pos(2:4)], ...
%       %        'ytick',cvec, ...
%       %        'yticklabel',c_string);
  
%  %% old 'ccols' code
%  else  % if a color-coded scatter plot 
%
%    drawnow;
%
%    %% Here we need to scale `cvec' to an [0,1] interval, the set
%    %% colorbar interval for MATLAB's scatter function.
%
%    % first initialize the, to be rescaled, tick vector
%    c_tick = zeros(NCvec,1);   
%
%    % Get step distance and normalize them
%    steps = diff(Cvec);
%    steps_rs = steps/(Cvec(NCvec)-Cvec(1));
%    
%    % Build rescaled cvec into c_tick
%    for i=1:NCvec-1
%      c_tick(i+1) = c_tick(i) + steps_rs(i); end
%
%    %% Now, we also need to expand 'c_string' the associated 
%    %% string label array so that it corresponds to `c_tick'.
%
%    % intialization, notice that it has NCvec entries!
%    c_string = repmat({''},NCvec,1);
%
%    % if Cvec includes a 'below' value than it will always be blanked
%    if cvec(1)~=Cvec(1)
%      c_string{1} = ['']; 
%      icc = 1;                % index offset
%    else
%      icc = 0;
%    end
%    
%    % Similarly, if Cvec includes an 'above' value ...
%    if cvec(Ncvec)~=Cvec(NCvec)
%      c_string{NCvec} = ['']; end
%    
%    % loop as for c_string, adding white spaces to match negative
%    % tick labels. 
%    for i=1:string_step:Ncvec
%      if cvec(i) >= 0				
%        c_string{i+icc} = ['   ',num2str(cvec(i))];
%      else
%        c_string{i+icc} = [' ', num2str(cvec(i))];
%      end
%    end
%
%  % done.
%
%  end
%  

%  ax=gca;
%  pos=get(gca,'position')
%  opos=get(gca,'outerposition')
%  %set(gca,'pos',[pos(1) pos(2) pos(3) pos(4)*0.95]);
%  %pos=get(gca,'pos');
%
%  return
%
%  h = colorbar('ticklength',[0.06 0.06], ... 
%				'ytick',cvec,'yticklabel',c_string, ... 
%				'fontsize',13,'fontname','Helvetica', ...
%        'location','eastoutside');
%        %'position',[pos(1)+pos(3),pos(2),0.05,pos(4)]);
%
%  %set(h,'xaxisloc','top');
%	set(h,'linewidth',1.5);
%  c_pos = get(h,'position')
%  c_opos = get(h,'outerposition')
%
%  text(c_pos(1),c_pos(2),'shiit','horizontalalignment','right');
%
%  %# y tick positions
%  yticks = get(h,'ytick')
%
%  %# get the y tick labels as cell array of strings
%  ylabels = cellstr(get(h,'yticklabel'));
%
%  set(h,'yticklabel',[]) %# remove the labels from axes
%  n = numel(ylabels);
%  yl = get(h,'position')
%  idx1 = 1:2:n; %# 1st set of ticks
%  idx2 = 2:2:n; %# 2nd set
%
%  t1 = text(repmat(yl(1),numel(idx1),1),yticks(idx1),ylabels(idx1), ...
%    'HorizontalAlignment','center','VerticalAlignment','top');
%  t2 = text(repmat(yl(1),numel(idx2),1), yticks(idx2), ylabels(idx2), ...
%    'HorizontalAlignment','center','VerticalAlignment','top');
%  set(t2,'FontWeight','bold') %# make the 2nd set bold 
%
%  text(yl(1),yl(2)+yl(4),'shiit')

end

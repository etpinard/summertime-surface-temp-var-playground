function [Cvec,NCvec,zz] = x_cvec(z,cvec,opt_cvec)
%
% A function that expand a given contour (or color) vector to
% include out-of-range values.
%
% Alternatively, if `cvec' is empty, it will be generated here.
% Before 03/28, this was implemented inside plot_map_miller.m
%
% Also, output a rescaled data array from input 'z'. Out-of-range
% values are brought in the computed 'Cvec'.
%
% (07/02) Support for non-linear 'cvec' !
%
%
%	INPUT:		z         , data array to be plotting
%           cvec      , given contour vector
%           opt_x     , (OPT.) set output regardless of data:
%                       []: (default) computed expansion
%                       'below': add below range values
%                       'above': add above range values
%                       'add_both': add both
%                       'none': no expansion and restrict data to
%                               input 'cvec' 
%
%	OUTPUT: 	Cvec      , expanded (and/or scaled) contour vector
%           NCvec     , # of elements in expanded contour vector
%           zz        , set all out-of-bounds values with respect
%                       to Cvec to Cvec(1) or Cvec(NCvec).
%						
% *** Maybe find a way to better automate cvec generation from the
%     data directly. Perhaps using hist.
% ======================================================================

%% Automate 'cvec'

	% A simple way to automate cvec
	% However, min and max are often ill-behaved 
	if isempty(cvec)
		z1 = make1d(z);
		step = round((max(z1)-min(z1))/20);
		cvec = [min(z1):step:max(z1)];
	end
% ----------------------------------------------------------------------

%% Default option

  % set default opt_cvec
  if nargin<3
    opt_cvec = 'default'; end
	
  % get 'cvec's length
	Ncvec = length(cvec);

% ----------------------------------------------------------------------

%% Test if 'cvec' is non-linear, define 'tmp', the 'Cvec' output embryo

  test = linspace(cvec(1),cvec(end),Ncvec);
  test = test(:)';
  is_nonlinear = ~all(abs(test-cvec)<=eps(cvec));

  if is_nonlinear
    disp('x_cvec.m : Be careful! Non-linear cvec -> array is re-scaled')
    tmp = test;
  else
    tmp = cvec;
  end

% ----------------------------------------------------------------------

%% Add extra contours!

  % The extra contours levels one step in cvec (tmp_lin)
	steps = diff(tmp);
  addstep = steps(1);   % add the same size
  
  % make `z' 1D for upcoming comparisons
	z1 = make1d(z);


  % Add below range value, regardless of `z'
  if strcmp(opt_cvec,'below') || strcmp(opt_cvec,'add_both')
      
    tmp = [tmp(1)-addstep,tmp];

  else  % or use `z'

    if nanmin(z1) < cvec(1); 
      tmp = [tmp(1)-addstep,tmp]; end
  
  end

  % Add above range value, regardless of `z'
  if strcmp(opt_cvec,'above') || strcmp(opt_cvec,'add_both')
    
    tmp = [tmp,tmp(end)+addstep];

  else  % or use `z'
	    
    if nanmax(z1) > cvec(Ncvec); 
      tmp = [tmp,tmp(end)+addstep]; end

  end

  % Force 'tmp' to 'cvec', regardless of `z' (and roundoff errors)
  if strcmp(opt_cvec,'none')

%    tmp = cvec;

  end

% ----------------------------------------------------------------------

%% Rescale data array 

  % set all 'still' out-of-bounds values to tmp(1) or tmp(end)
  tmp_zz = z;

  % get 'tmp's length
  Ntmp = length(tmp);
  
  % first below tmp(1)
	toosmall = find(z<tmp(1));
	tmp_zz(toosmall) = tmp(1)+eps(tmp(1));
  
  % above tmp(Ntmp)
  Ntmp = length(tmp);
	toobig = find(z>tmp(Ntmp));
	tmp_zz(toobig) = tmp(Ntmp)-eps(tmp(Ntmp));

% ----------------------------------------------------------------------

%% Rescale data w.r.t non-linear 'cvec'

for i=1:Ncvec-1

  bot = cvec(i);
  top = cvec(i+1);
 
  if i<Ncvec-1
    inside = find( z >= bot & z < top );
  else
    inside = find( z >= bot & z <= top );
  end
 
  midpt = (test(i)+test(i+1))/2;
 
  tmp_zz(inside) = midpt;
 
end
% ----------------------------------------------------------------------

% ----------------------------------------------------------------------

  % output new contour vector
  Cvec = tmp;

	% new length of contour vector
	NCvec = Ntmp;
  
  % output resecaled array
  zz = tmp_zz;


end

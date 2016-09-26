function out = catsheet(varargin)
%
% Concatenate multiple 1D or 2D arrays of different sizes (using NaNs)
% into multiple 'sheets'.
%
% If input arguments have same size, use addsheet.m for efficiency.
% (... but catsheet.m quite fast regardless)
%
% INPUT:		'varargin' , all arrays to cat from one after the other
% 
% OUTPUT:		out   , output array with extra sheet
% ====================================================================


  % # of input arrays
  N = length(varargin);

  % assign name to input variables
  for i=1:N
    cmd = ['a',num2str(i),' = varargin{i};'];
    eval(cmd);
  end

  % find maximum size of all input arrays
  cmd_1 = 'N1 = max([';
  cmd_2 = 'N2 = max([';
  for i=1:N
    cmd_1 = [cmd_1,'size(a',num2str(i),',1)'];
    cmd_2 = [cmd_2,'size(a',num2str(i),',2)'];
    if i<N
      cmd_1 = [cmd_1,','];
      cmd_2 = [cmd_2,','];
    end
  end
  cmd_1 = [cmd_1,']);'];
  cmd_2 = [cmd_2,']);'];

  eval(cmd_1);
  eval(cmd_2);
  

  %% if 1 array is 2D
  if N1>1

    % intialize output with NaNs
    tmp = repmat(NaN,[nargin,N1,N2]);

    % fill in $tmp
    for i=1:N
    
      % get a$i
      eval(['a = a',num2str(i),';']);

      % size of a$1
      [n1,n2] = size(a);

      % fill in $tmp
      tmp(i,1:n1,1:n2) = a;

    end

  else  %% if all arrays are 1D 

    % intialize output with Nans
    tmp = repmat(NaN,[nargin,N2]);

    % fill in $tmp
    for i=1:nargin
    
      % get to_add$i
      eval(['a = a',num2str(i),';']);

      % size of a$i
      [n2] = length(a);

      % fill in $tmp
      tmp(i,1:n2) = a;

    end

  end
  
  out = tmp;

end

function out = relabel(str_array,prefix)
%
% Add prefix to each element of a given string array;
% 
% INPUT:      str_array     , string in question
%             prefix        , prefix to be added
% 
% OUTPUT:     out   , output string array
%             
% ====================================================================

  % initilize output array
  N = length(str_array);
  tmp = repmat({''},N,1);

  % loop through the elements
  for j=1:N;

    tmp{j} = [prefix,'_',char(str_array{j})];

  end


  % output results
  out = tmp;

end

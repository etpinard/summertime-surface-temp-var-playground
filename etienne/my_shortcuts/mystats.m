function mystats(X,title)
%
% Displays the outputs of max1d, min1d, mean1d and std1d
%
% INPUT:				X			, array in question
%								title , optional title (a string)
% ===================================================================
	

	% display title (if given)
	if nargin==2
		disp(['# ' title ':']);
	end
	
	% compute statistic and store in row array
	stuff = [min1d(X),max1d(X),mean1d(X),std1d(X)];

	% initialize the format array
	fmt = repmat({''},4,1);

	% loop through the statistics to find correct format
	for i=1:4

		if abs(stuff(i)) < 1e5 && abs(stuff(i)) > 1e-3 
			fmt{i} =  '%8.4f';

		elseif abs(stuff(i))==0

			fmt{i} = '%1.1f';

		else

			fmt{i} = '%5.4e';
		end

	end

	% output the results with the correct format
	fprintf(1,['  minimum: ' fmt{1} '\n'],stuff(1))
	fprintf(1,['  maximum: ' fmt{2} '\n'],stuff(2))
	fprintf(1,['  mean:    ' fmt{3} '\n'],stuff(3))
	fprintf(1,['  std:     ' fmt{4} '\n'],stuff(4))

end

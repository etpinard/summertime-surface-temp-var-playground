%%% Program that compares the magnitude of the two 
	% components of the net surface energy forcing 
	% (= F0 - alpha P) and the regression parameter alpha
	%
% ======================================================================

% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%% maybe add ratios with the full F' for comparison ...
%% as well as other ratio for alpha with e.g. beta lambda ... as the
%% new toy model takes shapes.

%% scale of alpha*P' to F_0'

cvec = [0:0.2:2]; color_handle = [];
bins = [-0.1:0.01:3]; yval = 4;

name = 'scale_alphaP-F0';
Z = abs(alpha.*sig_P./sig_F0);
%Z = (alpha.^2.*sig_P.^2./sig_F0.^2);
plot_summeravg;
% ======================================================================

%%  alpha/L 

cvec = [-0.2:0.1:1]; color_handle = [];
bins = [-0.5:0.01:1.5]; yval = 2;

name = 'scale_alpha-L';
Z = alpha/L;
plot_summeravg;
% ======================================================================

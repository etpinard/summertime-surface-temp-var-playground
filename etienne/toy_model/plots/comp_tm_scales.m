% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%% Run startup.m and DO NOT clear variables
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
% comp_tm_scales.m
%
% --> plot_comp_datasets.m <--
% --> plot_compsc_datasets.m <-- (really ?)
%
% Cross-datasets comparison of toy model scalings
%
% ======================================================================

%%% output alternative coeffs, or not
opt_tilde = 1;
% ----------------------------------------------------------------------

%name_add = 'alt';
clear name_add
out_format = 'both';
opt_overlay = 0;
opt_frame_col = 0;

comp_cmd = [ ...
'beta = [];' ...  % variables, not functions
'gamma = [];' ...
'alpha = [];' ...
'tm_param_full;' ...
'fact_P = alpha.*(1-lambda)+chi.*(1+alpha.*lambda-beta);' ...
'fact_P_tilde = ' ...
  'alpha.*(1-lambda-eta)+chi_tilde.*(1+alpha.*lambda-beta);' ...
'fact_F0 = (1-lambda.*(1-chi));' ...
'fact_F0_tilde = (1-lambda.*(1-chi)-eta);' ...
'scale_F0_P = fact_F0.^2.*Var_F0./(L^2*fact_P.^2.*Var_P);' ...
'scale_F0_P_tilde = ' ...
  'fact_F0_tilde.^2.*Var_F0./(L^2*fact_P_tilde.^2.*Var_P);' ...
];

case_cmd = [ ...
'case {1,2,4,5};' ...
  'cvec=[0:0.2:1]; opt_x_cvec=''add_both'';' ...
  'units=''[-]''; color_handle = @color_myhot;' ...
'case {3,6};' ...
  'cvec=[0,0.1,0.25,0.5,0.8,1,1.25,2,4,10]; opt_x_cvec=''above'';' ... 
  'units=''[-]''; color_handle = @color_scale;' ...
];
% ----------------------------------------------------------------------

%% Call plot_comp_datasets.m
if ~opt_tilde
  vars_req = {'lon','lat', ...
              'fact_P','fact_F0', ...
              'scale_F0_P'};
else
  vars_req = {'lon','lat', ...
              'fact_P','fact_F0', ...
              'scale_F0_P', ...
              'fact_P_tilde','fact_F0_tilde', ...
              'scale_F0_P_tilde'};
end

plot_comp_datasets;
% ----------------------------------------------------------------------

%% old stuff 
%{

comp_cmd = [ ...
'beta = [];' ...  % variables, not functions
'gamma = [];' ...
'alpha = [];' ...
'tm_param_full;' ...
'scale_1 = (L^2*alpha.^2.*Var_P)./Var_F0;' ... % (07/21) done as F_decomp
'scale_2 = alpha.*(1-lambda) + chi.*(1+alpha.*lambda-beta);' ...
'scale_3 = (1-lambda.*(1-chi));' ...
'den = gamma.^2./tm_Var_T;' ...
'term_1 = Var_F0./den;' ...
'term_11 = ((1-lambda.*(1-chi)).^2.*Var_F0)./den;' ...
'term_2 = L^2*alpha.^2.*Var_P./den;' ...
'term_22 = ' ...
'L^2*(alpha.*(1-lambda)+chi.*(1+alpha.*lambda-beta)).^2.*Var_P./den;' ...
];

case_cmd = [ ...
  'case 1;' ...
  'cvec=[0:0.25:4]; opt_x_cvec=''above''; units=''[-]'';' ...
  'bins=[-0.1:0.01:6]; yval = 3; color_handle=@color_ltone2;'...
  'case {2,3};' ...
  'cvec=[-1:0.1:1]; opt_x_cvec=''add_both''; units=''[-]'';' ...
  'bins=[-2:0.02:2]; yval = 5; color_handle=@color_posneg;' ...
  'case {4,5,6,7};' ...
  'cvec=[0:0.1:1.2]; opt_x_cvec=''above''; units=''[-]'';' ...
  'bins=[-0.1:0.01:5]; yval = 5; color_handle=[];' ...
  ];
%}
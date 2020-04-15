%% CT mediated separation and recombination model rate equations. 
%% According to Howard et al. JACS 2010, 132:14866 
%% (equations (1), visualized in Figure 1, presented as "Braun Onsager Model")
% 2019-10-08 JG: Yop!

function dy = BraunOnsagerRates(y, k_CTGS, k_CTSSC, gamma, lambda_plus_1)
% y contains the densities of bound charges (y(1)) and separated (y(2))
% charges

dy = zeros(2,1);

dy(1) = - k_CTGS*y(1) - k_CTSSC*y(1) + gamma*y(2)^ lambda_plus_1;
dy(2) = k_CTSSC*y(1) - gamma*y(2)^ lambda_plus_1;

end
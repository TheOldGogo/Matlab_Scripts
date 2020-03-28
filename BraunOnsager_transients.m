%% Simulated CT mediated separation and recombination transients
%% Using rate equations.
%% Presented by Howard et al. JACS 2010, 132:14866 
%% as "Braun Onsager Model", (Figure 1 and set of equations (1))
% JG: Yop!

function Transients = BraunOnsager_transients(params, t, num_fluences, N0, draw)

%explicit the parameters & scaling (+ potentially adding scaling if Isee the point one day):
k_CTGS = params(1)*10^8;
k_CTSSC = params(2)*10^8;
gamma = 10^params(3);
lambda_plus_1 = params(4);

%preassigning conc
conc = zeros(size(t,2),2,num_fluences);

for k=1:num_fluences
    [TOUT, conc(:,:,k)] = ode15s(@(tin,y) BraunOnsagerRates(y,k_CTGS, k_CTSSC, gamma, lambda_plus_1),t,[N0(k), 0]);
end

%explicit the densities

CT =  squeeze(conc(:,1,:));
SSC = squeeze(conc(:,2,:));
charges = CT + SSC;


%plot the densities

if draw == 1

   % figure(1)
   % figure(2)
   % figure(3)


    for k=1:num_fluences

        figure();
        loglog(t,CT(:,k));
        hold on
        loglog(t,SSC(:,k));
     
        
        figure(1)
        loglog(t,charges(:,k),'k','linewidth', 1.5)
        hold on

        figure(2)
        loglog(t,charges(:,k)/max(charges(:,k)),'k','linewidth', 1.5)
        hold on
 
        figure(3)
        semilogx(t,charges(:,k)/max(charges(:,k)),'k','linewidth', 1.5)
        hold on
 
    end
end

% Return the simulated transients

Transients = charges;

end
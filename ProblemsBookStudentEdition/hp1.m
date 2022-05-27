% hp1.m
% Set parameters and intialize arrays
tot_time = 5.;         % total time
N        = 1000;       % number of increments
dt       = tot_time/N; % increment in time
time     = zeros(N,1); % time
epsilon  = zeros(N,1); % strain 
sigma    = zeros(N,1); % stress 
g1       = zeros(N,1); % contribution to stress  
A        = 2.;         

% Loop over time and evaluate
for i=2:N
    time(i) = time(i-1)+dt;
    % Eval strain
    if (time(i) <= 0.)         
       epsilon(i) =  0.;       
    elseif (time(i) <= 1.)         
       epsilon(i)  =  exp(time(i)/2.d0);       
    elseif (time(i) <= 2.)        
       epsilon(i)  = - (time(i)/A)^2 + time(i)/A;       
    else 
       epsilon(i) = 0.d0;
    end 
    
    % Eval HP recursion
    de = epsilon(i) - epsilon(i-1);
    g1(i) = exp(-dt/1)*g1(i-1) + (1/dt)*(1- exp(-dt/1))*de;
    sigma(i) = epsilon(i) + g1(i);
end  
   
% Plot results
figure(1);
plot(time,epsilon,'k-.','LineWidth',2);
hold on;
plot(time,sigma,'k-','LineWidth',2);
xlabel('$t$','FontSize',20,'Interpreter','latex'); 
ylabel('$\sigma$, $\epsilon$','FontSize',20,...
    'Interpreter','latex'); 
legend_handle = legend('$\epsilon$','$\sigma$');
set(legend_handle,'FontSize',20,'Interpreter','latex',...
  'Location','NorthEast');

% Cross plot
figure(2);
plot(epsilon,sigma,'k-','LineWidth',2);
xlabel('$\epsilon$','FontSize',20,'Interpreter','latex');
ylabel('$\sigma$','FontSize',20,'Interpreter','latex');
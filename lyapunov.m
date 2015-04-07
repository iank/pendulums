clear all
close all

%% Estimate Lyapunov time for chaotic damped driven pendulum
% I want to estimate global LCE on a particular attractor, so not local
% exponent for some x_0 - so simulate for a while & skip transient
% behaviour

% See Tancredi/Sanchez (2001) but I want to estimate using a second
% trajectory very close to initial for good estimate, but not so close
% as to have precision issues

% See my notes misc/2015-04-06(1)

% chaotic regime
g = 1.15; q=4; omega_d = 0.6667;
param = [q, g, omega_d];

% Initial conditions
IC = [0, -2*pi/3 + rand(1,1)*0.01, 0]; % run this many times to verify
                                       % convergence of estimate of LCE
                                       % ('LCI', per Tancredi/Sanchez)

%% Skip transient
[t, X] = ode45(@damped_driven_ode, [0, 1000], IC, [], param);
% Wrap theta between -pi, pi
X(:,2) = wrapToPi(X(:,2));

omega = X(end, 1);
theta = X(end, 2);
phi = X(end, 3);

%% Estimate LCE
Tau = 100; % Renormalization step
k = 1000; % number of renormalizations
d0 = 10^-7;
dist = zeros(k, 1);  % gamma (=apx=) lim Chi[k] as k->inf, d0->0

omega2 = omega - (d0/sqrt(2));
theta2 = theta - (d0/sqrt(2));

figure
% Use stiff solver 15s for these
for q=1:k
    % First particle
    [t1, X1] = ode15s(@damped_driven_ode, [0, Tau], [omega, theta, phi], [], param);

    % Shadow particle
    [t2, X2] = ode15s(@damped_driven_ode, [0, Tau], [omega2, theta2, phi], [], param);

    % Update

    omega = X1(end, 1);
    theta = X1(end, 2);
    phi = X1(end, 3);
    omega2 = X2(end, 1);
    theta2 = X2(end, 2);

    dist(q) = sqrt((omega - omega2)^2 + (theta - theta2)^2);

    % Renormalize shadow particle by Benettin et al method (scale difference
    % vector down to d0)

    diff = [omega, theta] - [omega2, theta2];
    diff = diff / norm(diff) * d0;
    omega2 = omega - diff(1);
    theta2 = theta - diff(2);
    
    disp(sprintf('(q/k) = (%d/%d), dist = %f', q, k, dist(q)));
end

Chi = zeros(k,1);
for q=1:k
    % Per Benettin, Galgani, Strelcyn (1976)
    Chi(q) = 1/(q*Tau) * sum(log2(dist(1:q)/d0));
end

plot(2:k, Chi(2:k));
title('Convergence(?) of LCE estimate');
xlabel(sprintf('Time k*Tau, (Tau = %f)', Tau))
ylabel('Chi(k)')

disp(sprintf('gamma estimate: %f', Chi(end)));
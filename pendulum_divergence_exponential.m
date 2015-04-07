clear all
close all

%% Show that the divergence of two nearby trajectories in phase space
% is exponential (if the lyapunov exponent estimation is not
% convincing...)

% Note that the chaotic region in phase space is bounded so exponential
% divergence only holds for small separations

% chaotic regime
g = 1.15; q=4; omega_d = 0.6667;
param = [q, g, omega_d];

% Initial conditions
IC = [0, -2*pi/3, 0];
%% Skip transient
[t, X] = ode45(@damped_driven_ode, [0, 1000], IC, [], param);

omega1 = X(end, 1);
theta1 = X(end, 2);
phi1 = X(end, 3);

d0 = 1e-7;

omega2 = omega1;
theta2 = theta1 - (d0/sqrt(2));
phi2 = phi1;
omega2 = omega1 - (d0/sqrt(2));

Tau = 10000;

[t, Xdiv] = ode45(@damped_driven_ode_parallel, [0, Tau], [omega1, theta1, phi1, omega2, theta2, phi2], [], param);

%Xdiv(:,2) = wrapToPi(X2(:,2));

figure
hold on
plot(t, Xdiv(:,2), 'bla-')
plot(t, Xdiv(:,5), 'red.-')
legend('\theta 1', '\theta 2')
title('Divergence of damped driven pendulum with initial displacement \Delta \theta = 1e-7');
xlabel('Time')
ylabel('Angle (rad)')


idx = find(t <= 200);
t = t(idx);
Xdiv = Xdiv(idx, :);

figure
delta = abs(Xdiv(:,2) - Xdiv(:,5));
plot(t, delta, 'bla-')
% Compute lyapunov exponent like this and compare with the
% more-carefully estimated version

minidx = 1;
maxidx = find(delta == max(delta));  % visually verify this is smooth..

% defn of lyapunov exp (base 2 here) is
% divergence = initial divergence * 2^(lambda1*t)
% log2(d1 / d0) / t_diff = lambda1
t_diff = t(maxidx) - t(minidx);
lambda1 = log2(max(delta) / d0) / t_diff

hold on
plot(t, d0*2.^(lambda1*t));

title(sprintf('Exponential divergence and (shady) estimate of max Lyapunov exponent %f', lambda1));
xlabel('time');
ylabel('\Delta \theta');
legend('Actual difference', 'd_0 2^{(\lambda_1*t)}')
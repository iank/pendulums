clear all
close all

%% Show divergence of two nearby trajectories

% chaotic regime
g = 1.15; q=4; omega_d = 0.6667;
param = [q, g, omega_d];

% Initial conditions
IC = [0, -2*pi/3, 0];
%% Skip transient
[t, X] = ode45(@damped_driven_ode, [0, 1000], IC, [], param);
% Wrap theta between -pi, pi
X(:,2) = wrapToPi(X(:,2));

omega = X(end, 1);
theta = X(end, 2);
phi = X(end, 3);

d0 = 1e-7;

omega2 = omega;
theta2 = theta + d0;
omega2 = omega - (d0/sqrt(2));

Tau = 1000;

% First
[t1, X1] = ode45(@damped_driven_ode, [0, Tau], [omega, theta, phi], [], param);
% Shadow
[t2, X2] = ode45(@damped_driven_ode, [0, Tau], [omega2, theta2, phi], [], param);

%X1(:,2) = wrapToPi(X1(:,2));
%X2(:,2) = wrapToPi(X2(:,2));

figure
hold on
plot(t1, X1(:,2), 'bla-')
plot(t2, X2(:,2), 'red.-')
legend('Path 1', 'Path 2')
title('Divergence of damped driven pendulum with initial displacement \Delta \theta = 1e-7');
xlabel('Time')
ylabel('Angle (rad)')
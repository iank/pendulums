clear all
close all

% Demonstrate fixed point attractor regardless of initial state

g = 0;q = 2;omega_d = 0.6667;
param = [q, g, omega_d];

[t1, X1] = ode45(@damped_driven_ode, [0, 1000], [-.3, -2*pi/3, 0], [], param);
[t2, X2] = ode45(@damped_driven_ode, [0, 1000], [1, pi/3, 0], [], param);
[t3, X3] = ode45(@damped_driven_ode, [0, 1000], [0, -pi+0.01, 0], [], param);
[t4, X4] = ode45(@damped_driven_ode, [0, 1000], [0.1, 3*pi/2, 0], [], param);

% Wrap theta between -pi, pi
X1(:,2) = wrapToPi(X1(:,2));
X2(:,2) = wrapToPi(X2(:,2));
X3(:,2) = wrapToPi(X3(:,2));
X4(:,2) = wrapToPi(X4(:,2));

figure
hold on
plot(X1(:,2), X1(:,1), 'bla.-', 'linewidth', 2)
plot(X2(:,2), X2(:,1), 'red-', 'linewidth', 2)
plot(X3(:,2), X3(:,1), 'gre--', 'linewidth', 2)
plot(X4(:,2), X4(:,1), 'blu-.', 'linewidth', 2)
ylabel('omega (ang. velocity)');
xlabel('theta (angle)');
title('Fixed-point attractor damped driven pendulum');


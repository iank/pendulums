clear all
close all

% http://www.thphys.uni-heidelberg.de/~gasenzer/index.php?n1=teaching&n2=chaos

% damped oscillator

%g = 0;q = 2;omega_d = 0.6667;
% transient, then periodic
%g = 1.35; q=2; omega_d = 0.6667; % use [2 0, 0] init cond
% chaotic
g = 1.15; q=4; omega_d = 0.6667;

param = [q, g, omega_d];

[t, X] = ode45(@damped_driven_ode, [0, 1000], [0, -2*pi/3, 0], [], param);

% Wrap theta between -pi, pi
%X(:,2) = wrapToPi(X(:,2));

figure
plot(X(:,2), X(:,1))
ylabel('omega (ang. velocity)');
xlabel('theta (angle)');
title('Chaotic behaviour in damped driven pendulum');

% Now take poincare diagram by selecting only points corresponding to
% our angular frequency omega_d

% We need a LOT of points for this. solve the ODE in sections and
% throw away extraneous points each time

figure
hold on
ylabel('omega (ang. velocity)');
xlabel('theta (angle)');
title('Poincare section in phase with driving force');
omega = 0;
theta = -2*pi/3;
phi = 0;
for i=1:10000
    g = 1.15; q=4; omega_d = 0.6667;

    param = [q, g, omega_d];
    
    [t, X] = ode45(@damped_driven_ode, [0, 200*(1/omega_d)], [omega, theta, phi], [], param);

    % Wrap theta between -pi, pi
    X(:,2) = wrapTo2Pi(X(:,2));
    
    % plot in-phase points
    poincare = find(sin(X(:,3)) > 0.99995);

    plot([X(poincare,2)], [X(poincare,1)], '.')
    omega = X(end, 1);
    theta = X(end, 2);
    phi = X(end, 3);
    pause(0.01);
end


l = 1;   % m
g = 1.35; % m/s^2
q = 2;
omega_d = 0.6667; % rad/s
F_d = 1;

param = [l, g, q, omega_d, F_d];

[t, X] = ode45(@damped_driven_ode, [0, 2000], [-pi/3, 0], [], param);

plot(X(:,1), X(:,2))
xlabel('position');
ylabel('velocity');
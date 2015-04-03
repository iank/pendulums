% Simple nonlinear pendulum in phase space
% See Ochs et al 2011

dt = 0.0001; % s
l = 1;   % m
g = 9.8; % m/s^2
% Angle offset from -y axis
phi_0 = -pi/3;
dphi_0 = 0;

% phi'' + g/l*sin(phi) = 0

d2phi_0 = -1*g/l*sin(phi_0);

niter = 100000;
state = zeros(3, niter);
state(1,1) = phi_0;
state(2,1) = dphi_0;
state(3,1) = d2phi_0;

for i=2:niter;
    % Update phi using dphi
    state(1, i) = state(1, i-1) + state(2, i-1)*dt;
    
    % Update angular velocity using d2phi
    state(2, i) = state(2, i-1) + state(3, i-1)*dt;
    
    % Compute new second derivative using the diffeq
    % phi'' + g/l*sin(phi) = 0
    
    state(3, i) = -1*g/l*sin(state(1,i));
    
    if (i >= 10000 && i <= 10050) % Give it a kick on a few iterations to demonstrate stability
        state(3, i) = 30;
    end
end

plot(state(2,:), state(3,:))
title('Simple pendulum in state space')
xlabel('velocity')
ylabel('acceleration')
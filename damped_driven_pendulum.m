% theta'' = -g/l sin(theta) - q theta' + Fd*sin(omega_d*t)

% F_d amplitude of periodic driving force
% theta_d frequency of same
% q is damping constant

dt = 0.0001; % s

l = 1;   % m
g = 1.35; % m/s^2
q = 2;
omega_d = 0.6667; % rad/s
F_d = 1;

% Angle offset from -y axis
phi_0 = -pi/3;
dphi_0 = 0;

% phi'' + g/l*sin(phi) = 0

d2phi_0 = -1*g/l*sin(phi_0);

niter = 100000000;
state = zeros(4, niter);
state(1,1) = phi_0;
state(2,1) = dphi_0;
state(3,1) = d2phi_0;
state(4,1) = 0; % time

for i=2:niter;
    % update time
    state(4,i) = state(4,i-1)+dt;
    
    % Update phi using dphi
    state(1, i) = state(1, i-1) + state(2, i-1)*dt;
    
    % Update angular velocity using d2phi
    state(2, i) = state(2, i-1) + state(3, i-1)*dt;
    
    % Compute new second derivative using the diffeq
    % theta'' = -g/l sin(theta) - q theta' + Fd*sin(omega_d*t)
    
    state(3, i) = -1*g/l*sin(state(1,i)) - q*state(2,i) + F_d*sin(omega_d*state(4,i));
    
 %   if (i >= 10000 && i <= 10050) % Give it a kick on a few iterations to demonstrate stability
 %       state(3, i) = 30;
 %   end
end


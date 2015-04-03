% theta'' = -g/l sin(theta) - q theta' + Fd*sin(omega_d*t)

% http://www.thphys.uni-heidelberg.de/~gasenzer/index.php?n1=teaching&n2=chaos

% Rewrite in dimensionless form 
% theta''

% rewrite as system of 1st order ODEs where

% x1dot(t) = x2(t)
% x2dot(t) = -g/l*sin(x1(t)) - q*x2(t) + F_d*sin(omega_d, t)

% Now note x1 = theta, x2 = theta', x2dot = theta''

% F_d amplitude of periodic driving force
% theta_d frequency of same
% q is damping constant

function xdot = damped_driven_ode( t, x, param)
l = param(1);
g = param(2);
q = param(3);
omega_d = param(4);
F_d = param(5);

    x1dot = x(2);
    x2dot = -g/l*x(1) - q*x(2) + F_d*sin(omega_d*t);
    xdot = [x1dot; x2dot];
end


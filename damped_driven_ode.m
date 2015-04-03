%% TODO: write out math here. for now marked page in my notebook

function xdot = damped_driven_ode( t, x, param)
    % wdot, thetadot, phidot as functions of w, theta, phi
    % params q, g, omega_d

    q = param(1);
    g = param(2);
    omega_d = param(3);

    omega = x(1);
    theta = x(2);
    phi = x(3);
    
    omegadot = -1/q*omega - sin(theta) + g*cos(phi);
    thetadot = omega;
    phidot = omega_d;
    
    xdot = [omegadot; thetadot; phidot];
end


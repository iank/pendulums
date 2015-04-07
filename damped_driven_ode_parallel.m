%% Same as the single version except solve two (not coupled) in
% in parallel so we get the same timesteps out of the solver

function xdot = damped_driven_ode( t, x, param)
    % wdot, thetadot, phidot as functions of w, theta, phi
    % params q, g, omega_d

    q = param(1);
    g = param(2);
    omega_d = param(3);

    omega1 = x(1);
    theta1 = x(2);
    phi1 = x(3);

    omega2 = x(4);
    theta2 = x(5);
    phi2 = x(6);

    
    omegadot1 = -1/q*omega1 - sin(theta1) + g*cos(phi1);
    thetadot1 = omega1;
    phidot1 = omega_d;

    omegadot2 = -1/q*omega2 - sin(theta2) + g*cos(phi2);
    thetadot2 = omega2;
    phidot2 = omega_d;

    
    xdot = [omegadot1; thetadot1; phidot1; omegadot2; thetadot2; phidot2];
end


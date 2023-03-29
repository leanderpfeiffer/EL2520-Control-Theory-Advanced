%% Exercise 4.1.1
s = tf('s');

G = 3*(-s+1)/( (5*s+1) * (10*s + 1));

p_m = 30; % [deg]
w_c = 0.4; % [rad/s]

[m, p] = bode(G, crossoverFrequency);
phase_recover = -180 + p_m - p + 360

beta = 0.68

tau_d = 1/(w_c * sqrt(beta))

F_lead = (tau_d * s + 1)/(beta * tau_d * s + 1) 

[m_k, ] = bode(G*F_lead, w_c);

K = 1/m_k;

F_lead = K * (tau_d * s + 1)/(beta * tau_d * s + 1) 

tau_i = 10/w_c;
gamma = 0;

F_lag = (tau_i * s + 1) / (tau_i*s + gamma);
F = F_lead * F_lag;

bode(F*G)

closed_loop = (F*G)/(F*G+1);

%% Exercise 4.1.2
resp = stepinfo(closed_loop);

bandwith = bandwidth(closed_loop);
M_T = getPeakGain(closed_loop);

risetime = resp.RiseTime;
overshoot = resp.Overshoot;


%% Exercise 4.1.3

p_m = 50

[m, p] = bode(G, crossoverFrequency);
phase_recover = -180 + p_m - p + 360

beta = 0.31

tau_d = 1/(w_c * sqrt(beta))

F_lead = (tau_d * s + 1)/(beta * tau_d * s + 1) 

[m_k, ] = bode(G*F_lead, w_c);

K = 1/m_k;

F_lead = K * (tau_d * s + 1)/(beta * tau_d * s + 1) 

tau_i = 10/w_c;
gamma = 0;

F_lag = (tau_i * s + 1) / (tau_i*s + gamma);
F = F_lead * F_lag;

bode(F*G)

closed_loop = (F*G)/(F*G+1);

resp = stepinfo(closed_loop);

bandwith = bandwidth(closed_loop);
M_T = getPeakGain(closed_loop);

risetime = resp.RiseTime;
overshoot = resp.Overshoot;

%% 4.2 Disturbance attenuation



%% Minimum-Phase Case
G = minphase;
w_c = 0.1;
W2 = ss(tf(eye(2)));
W1 = inv(dcgain(G));

G_tilde = W1*G*W2;
bode(G_tilde)

%% PI
pm = pi/3;
w_c = 0.1 ;
s = tf("s");

[~, arg] = bode(G_tilde(1,1), w_c);
T_i1 = 1/w_c * tan(-pi/2+pm - arg/180*pi);
l_11 = G_tilde(1,1)* (1 + 1/(T_i1*s));

[mar, ~] = bode(l_11, w_c);

f_1 = 1/mar* (1 + 1/(T_i1*s));

[~, arg] = bode(G_tilde(2,2), w_c);
T_i2 = 1/w_c * tan(-pi/2+pm - arg/180*pi);
l_22 = G_tilde(2,2)* (1 + 1/(T_i2*s));

[mar, ~] = bode(l_22, w_c);

f_2 = 1/mar* (1 + 1/(T_i2*s));

F_tilde = [f_1 0 ; 0 f_2];

F = W1*F_tilde;

%% Sensitivity

S = inv(eye(2)+G*F);
T = inv(eye(2)+G*F)*G*F;

figure(1)
sigma(S);
figure(2)
sigma(T);

%% Simulation
F=F;
G=G;
closedloop

%% Dynamic Decoupling
G_wc = evalfr(G,w_c);
rga = G_wc.*inv(G_wc)'

G_tf = tf(G);

W1 = [1,-G_tf(1,2)/G_tf(1,1);-G_tf(2,1)/G_tf(2,2),1];
W2 = eye(2);

G_tilde = G*W1;

bode(G_tilde)

%% PI
pm = pi/3;
w_c = 0.1 ;
s = tf("s");

[~, arg] = bode(G_tilde(1,1), w_c);
T_i1 = 1/w_c * tan(-pi/2+pm - arg/180*pi);
l_11 = G_tilde(1,1)* (1 + 1/(T_i1*s));

[mar, ~] = bode(l_11, w_c);

f_1 = 1/mar* (1 + 1/(T_i1*s));

[~, arg] = bode(G_tilde(2,2), w_c);
T_i2 = 1/w_c * tan(-pi/2+pm - arg/180*pi);
l_22 = G_tilde(2,2)* (1 + 1/(T_i2*s));

[mar, arg] = bode(l_22, w_c);

f_2 = 1/mar* (1 + 1/(T_i2*s));

F_tilde = [f_1 0 ; 0 f_2];

F = W1*F_tilde;
%% Sensitivity

S = inv(eye(2)+G*F);
T = inv(eye(2)+G*F)*G*F;

figure(1)
sigma(S);
figure(2)
sigma(T);

%% Simulation
F=F;
G=G;

sim('closedloop')
plot(uout)
hold on
plot(yout)
hold off
legend('u1','u2','y1','y2')
xlabel('t [s]')
title('')
ylabel('')

%% Glover
alpha = 1.1;
L0 = G*W1*F_tilde;
bode(L0)
[Fr, gam] = rloop(L0,alpha);

%% Simulation
F=W1*F_tilde*Fr;
G=G;

sim('closedloop')
plot(uout)
hold on
plot(yout)
hold off
legend('u1','u2','y1','y2')
xlabel('t [s]')
title('')
ylabel('')
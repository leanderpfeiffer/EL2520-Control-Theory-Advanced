function [A,B,C,D] = GMFController(G, w_c, pm, phase)

G_tf = tf(G);

s = tf("s");
if phase == "min"
    W1 = [1,-G_tf(1,2)/G_tf(1,1);-G_tf(2,1)/G_tf(2,2),1];
elseif phase == "nonmin"
    W1 = [-G_tf(2,2)/G_tf(2,1),1;1,-G_tf(1,1)/G_tf(1,2)];
    W1 = W1*ss(10*w_c/(s+10*w_c));
end
G_tilde = G*W1;


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

alpha = 1.1;
L0 = G*W1*F_tilde;
[Fr, gam] = rloop(L0,alpha);

if gam > 4
    error("Not working")
end

F=W1*F_tilde*Fr;

F = ss(F,'min');
[A,B,C,D] = ssdata(F);

sim('closedloop')

figure
plot(uout)
hold on
plot(yout)
hold off
legend('u1','u2','y1','y2')
xlabel('t [s]')
title('GMF '+ phase)
ylabel('')
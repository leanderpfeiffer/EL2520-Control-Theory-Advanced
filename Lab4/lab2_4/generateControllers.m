
w_c_min = 0.1;
pm = pi/3;
G_min = minphase;

[A,B,C,D] = decentralizedController(G_min, w_c_min, pm, "min");

save regulator_dec_min.MAT A B C D
%%

w_c_min = 0.1;
pm = pi/3;
G_min = minphase;

[A,B,C,D] = GMFController(G_min, w_c_min, pm, "min");

save regulator_GMF_min.MAT A B C D


%%

w_c_nonmin = 0.02;
pm = pi/3;
G_nonmin = nonminphase;

[A,B,C,D] = decentralizedController(G_nonmin, w_c_nonmin, pm, "nonmin");

save regulator_dec_nonmin.MAT A B C D


%%

w_c_nonmin = 0.02;
pm = pi/3;
G_nonmin = nonminphase;

[A,B,C,D] = GMFController(G_nonmin, w_c_nonmin, pm, "nonmin");

save regulator_GMF_nonmin.MAT A B C D


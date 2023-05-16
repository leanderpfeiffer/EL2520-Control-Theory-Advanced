
% Cross section areas
A1 = 15.5179;   % cm^2
A2 = 15.5179;   % cm^2
A3 = 15.5179;   % cm^2
A4 = 15.5179;   % cm^2

% Sensor proportional constant
kc = 0.2;       % V/cm

% Acceleration of gravity
g = 981;        % cm/s^2

% Time constants
T1 = A1/a1*sqrt(2*h10/g);   % s
T2 = A2/a2*sqrt(2*h20/g);   % s
T3 = A3/a3*sqrt(2*h30/g);   % s
T4 = A4/a4*sqrt(2*h40/g);   % s

% System matrices
A = [-1/T1 0 A3/(A1*T3) 0
     0 -1/T2 0 A4/(A2*T4)
     0 0 -1/T3 0
     0 0 0 -1/T4];
   
B = [gam1*k1/A1 0
     0 gam2*k2/A2
     0 (1-gam2)*k2/A3
     (1-gam1)*k1/A4 0];
  
C = [kc 0 0 0 
      0 kc 0 0];

D = zeros(2,2);

% Create state-space model
sys = ss(A,B,C,D);
   

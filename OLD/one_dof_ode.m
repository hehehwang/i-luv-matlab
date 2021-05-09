function dxdt = one_dof_ode(t,x,para)

m = para(1);
k = para(2);
c = para(3);
F0 = para(4);
frq_e = para(5);
F = F0*sin(2*pi*frq_e*t);

%VDP1  Evaluate the van der Pol ODEs for mu = 1
%
%   See also ODE113, ODE23, ODE45.

%   Jacek Kierzenka and Lawrence F. Shampine
%   Copyright 1984-2014 The MathWorks, Inc.

dxdt = zeros(2,1);

dxdt(1) = x(2);
dxdt(2) = (-k*x(1)-c*x(2)+F)/m;
function dy = TwoMassNoDamp_EOM(t,y,para)

m1 = para.m1;
m2 = para.m2;
k1 = para.k1;
k2 = para.k2;

dy = zeros(4,1);
dy(1) = y(2);
dy(2) = -(k1+k2)/m1*y(1) + k2/m1*y(3);
dy(3) = y(4);
dy(4) = k2/m2*y(1) - k2/m2*y(3);

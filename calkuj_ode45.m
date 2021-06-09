function calkuj_ode45(dt,q0,dq0)

tic
t0=0;

Y0=[q0;dq0];

[t,Y]=ode45(@H,[t0,dt],Y0);

toc
m=size(Y,1);
qK=Y(m,1:n)';
dqK=Y(m,(n+1):(2*n))';
q_dq=[qK dqK]

%dziwny ruch - nwm czy do konca dobrze
F=Fi(qK,t,ParyObrotowe, ParyPostepowe, WymuszeniaParametry);
norm_F=norm(F);

end
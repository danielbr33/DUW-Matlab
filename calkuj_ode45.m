function calkuj_ode45(tk)
[q0, UkladyWspolrzednych, ParyObrotowe, ParyPostepowe] = ReadStartData;
WymuszeniaParametry = WczytajWymuszenia();
[Masy, Bezwladnosci, Macierz] = WczytajMasyBezwladnosci;
dq0 = zeros(length(q0), 1);

%disp(q0);
%disp(dq0);

%tic
t0=0;
Y0=[q0;dq0];

[t,Y]=ode45(@H,[t0,tk],Y0);

%toc
n=size(Y,1);
m = length(q0);
qK=Y(n,1:m)';
dqK=Y(n,(m+1):(2*m))';
q_dq=[qK dqK]

%dziwny ruch - nwm czy do konca dobrze
F=Fi(qK,t,ParyObrotowe, ParyPostepowe, WymuszeniaParametry);
norm_F=norm(F);

end
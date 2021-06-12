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

[t,Y]=ode45(@H,t0:0.1:tk,Y0);

%toc
n=size(Y,1); % Liczba wierszy w tablicy wynik�w
err_F(n)=0; err_dF(n)=0; err_d2F(n)=0; % Niespe�nienie wi�z�w - deklaracja d�ugo�ci wektor�w 
m = length(q0);
for i=1:n
    q=Y(i,1:m)'; dq=Y(i,m+1:2*m)';  % Po�o�enia i pr�dko�ci w i-tym stablicowanym kroku
    FI=Fi(q,t,ParyObrotowe, ParyPostepowe, WymuszeniaParametry);
    FQ=Jakobian(q, ParyObrotowe, ParyPostepowe, WymuszeniaParametry);
    G=Gamma(q,dq, ParyObrotowe, ParyPostepowe, WymuszeniaParametry,t);
    M = Macierz;
    Q = Sily(q, dq, ParyPostepowe, Masy);
    
    A=[M,FQ';FQ,zeros(28,28)];     
    b=[Q;G];                   
    x=A\b;                           
    d2q=x(1:m,1);

    % Obliczenie miar rozerwania wi�z�w
    err_F(i)=norm(FI);               % B��d wi�z�w dla po�o�e�
    err_dF(i)=norm(FQ*dq);          % B��d wi�z�w dla pr�dko�ci
    err_d2F(i)=norm(FQ*d2q-G);      % B��d wi�z�w dla przyspiesze�
end
plot(t,err_F,'b','LineWidth',2); hold on;
plot(t,err_dF,'g','LineWidth',2);
plot(t,err_d2F,'r','LineWidth',2);
grid;
legend('Po�o�enia','Pr�dko�ci','Przyspieszenia'); hold off;

end
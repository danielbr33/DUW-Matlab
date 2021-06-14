function calkuj_ode45(tk)
[q0, UkladyWspolrzednych, ParyObrotowe, ParyPostepowe] = ReadStartData;
WymuszeniaParametry = WczytajWymuszenia();
[Masy, Bezwladnosci, Macierz] = WczytajMasyBezwladnosci;
dq0 = zeros(length(q0), 1);
Om = [0 -1;1 0];
%disp(q0);
%disp(dq0);

%tic
t0=0;
Y0=[q0;dq0];

[t,Y]=ode45(@H,t0:0.01:tk,Y0);

%toc
n=size(Y,1); % Liczba wierszy w tablicy wyników
err_F(n)=0; err_dF(n)=0; err_d2F(n)=0; % Niespełnienie więzów - deklaracja długości wektorów 
m = length(q0);
ddq(n,m)=0;
Polozenia=zeros(3,length(n));
Predkosci=zeros(3,length(n));
Przyspieszenia=zeros(3,length(n));

for i=1:n
    q=Y(i,1:m)'; dq=Y(i,m+1:2*m)';  % Położenia i prędkości w i-tym stablicowanym kroku
    FI=Fi(q,t,ParyObrotowe, ParyPostepowe, WymuszeniaParametry);
    FQ=Jakobian(q, ParyObrotowe, ParyPostepowe, WymuszeniaParametry);
    G=Gamma(q,dq, ParyObrotowe, ParyPostepowe, WymuszeniaParametry,t);
    M = Macierz;
    Q = Sily(q, dq, ParyPostepowe, Masy);
    
    A=[M,FQ';FQ,zeros(28,28)];     
    b=[Q;G];                   
    x=A\b;                           
    d2q=x(1:m,1);
    ddq(i,:)=x(1:m,1);
    
   
    % Obliczenie miar rozerwania więzów
    err_F(i)=norm(FI);               % Błąd więzów dla położeń
    err_dF(i)=norm(FQ*dq);          % Błąd więzów dla prędkości
    err_d2F(i)=norm(FQ*d2q-G);      % Błąd więzów dla przyspieszeń
    
    
    k=10;                     %numer wybranego czlonu
    rA=[2;0.4];           %pozycja analizowanego punktu w ukladzie globalnym danego czlonu
    sA=rA-q0(3*k-2:3*k-1);     %pozycja analizowanego pumktu w ukladzie lokalnym
    Polozenia(1:2,i)=q(3*k-2:3*k-1)+Rot(q((3*k)))*sA;
    Polozenia(3,i)=q((3*k));
    Predkosci(1:2,i)=dq(3*k-2:3*k-1)+Om*Rot(dq(3*k))*sA*dq(3*k);
    Predkosci(3,i)=dq(3*k);
    Przyspieszenia(1:2,i)=d2q(3*k-2:3*k-1)+Om*Rot(q(3*k))*sA*d2q(3*k)-Rot(q(3*k))*sA*dq(3*k)*dq(3*k);
    Przyspieszenia(3,i)=d2q(3*k);

    
end
%plot(t,err_F,'b','LineWidth',2); hold on;
%plot(t,err_dF,'g','LineWidth',2);
%plot(t,err_d2F,'r','LineWidth',2);
%grid;
%legend('Położenia','Prędkości','Przyspieszenia'); hold off;

%plot(t,Y(:,28));


    
    
%wyswietlanie wynikow dla punktu
subplot(3,3,1); 
plot(t,Polozenia(1,:));
title('polozenie na x');
xlabel('czas [s]');
ylabel('polozenie [m]'); 
grid on;
subplot(3,3,2);
plot(t,Polozenia(2,:));
title('polozenie na y');
xlabel('czas [s]');
ylabel('polozenie [m]');
grid on;
subplot(3,3,3);
plot(t,Polozenia(3,:));
title('kat obrotu');
xlabel('czas [s]');
ylabel('kat obrotu [rad]'); 
grid on;
subplot(3,3,4); 
plot(t,Predkosci(1,:));
title('predkosc na x');
xlabel('czas [s]');
ylabel('predkosc [m/s]');
grid on;
subplot(3,3,5);
plot(t,Predkosci(2,:));
title('predkosc na y');
xlabel('czas [s]');
ylabel('predkosc [m/s]');
grid on;
subplot(3,3,6); 
plot(t,Predkosci(3,:));
title('predkosc katowa');
xlabel('czas [s]');
ylabel('predkosc katowa [rad/s]');
grid on;
subplot(3,3,7); 
plot(t,Przyspieszenia(1,:));
title('przyspieszenie na x');
xlabel('czas [s]');
ylabel('przyspieszenie [m/s^2]');
grid on;
subplot(3,3,8); 
plot(t,Przyspieszenia(2,:));
title('przyspieszenie na y');
xlabel('czas [s]');
ylabel('przyspieszenie [m/s^2]');
grid on;
subplot(3,3,9);
plot(t,Przyspieszenia(3,:));
title('przyspieszenie katowe');
xlabel('czas [s]');
ylabel('przyspieszenie katowe [rad/s^2]');
grid on;
sgtitle('Wyniki') 
end

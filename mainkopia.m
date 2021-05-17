DT = 0.1;
T_MAX = 30;

[Q, UkladyWspolrzednych, ParyObrotowe, ParyPostepowe] = ReadStartData;
wymuszeniaParametry = WczytajWymuszenia();

n=1;                    %numer wybranego czlonu
rA=[0.2;0.4];           %pozycja analizowanego punktu w ukladzie globalnym danego czlonu
sA=rA-Q(3*n-2:3*n-1);   %pozycja analizowanego pumktu w ukladzie lokalnym

Om=[0 -1;1 0];
DQ=zeros(length(Q),1);
DDQ=zeros(length(Q),1);

Polozenia=zeros(3,300);
Predkosci=zeros(3,300);
Przyspieszenia=zeros(3,300);

%tu sa tablice do zbierania danych
T=zeros(1,(T_MAX/DT));
Q_tab=zeros(length(Q),(T_MAX/DT));
DQ_tab=zeros(length(Q),(T_MAX/DT));
DDQ_tab=zeros(length(Q),(T_MAX/DT));

i=1;

for t=0:DT:T_MAX

    FI=Fi(Q, t, ParyObrotowe, ParyPostepowe, wymuszeniaParametry);
    FIq = Jakobian(Q, ParyObrotowe, ParyPostepowe, wymuszeniaParametry);
    FI_dt = Fi_dt(Q,t, wymuszeniaParametry);
    
    %obliczanie polozen
    Q=Q+DQ*DT+DDQ*DT*DT/2;  
    Q=NewRaph(Q,t,ParyObrotowe, ParyPostepowe, wymuszeniaParametry);    
   
    %obliczanie predkosci
    FIq = Jakobian(Q, ParyObrotowe, ParyPostepowe, wymuszeniaParametry);
    FI_dt = Fi_dt(Q,t, wymuszeniaParametry);
    DQ = -FIq \ FI_dt;                                                  
    
    %obliczanie przyspieszen
    GAMMA = Gamma(Q,DQ, ParyObrotowe, ParyPostepowe, wymuszeniaParametry,t);
    DDQ = FIq\GAMMA;
    
    %zapisywanie wartosci do tablic
    T(1,i)=t;
    Q_tab(:,i)=Q;
    DQ_tab(:,i)=DQ;
    DDQ_tab(:,i)=DDQ;
    
    
    %obliczenia dla konkretnego punktu
    Polozenia(1:2,i)=Q_tab(3*n-2:3*n-1,i)+Rot(Q_tab((3*n),i))*sA;
    Polozenia(3,i)=Q_tab((3*n),i);
    Predkosci(1:2,i)=DQ_tab(3*n-2:3*n-1,i)+Om*Rot(Q_tab(3*n,i))*sA*DQ_tab(3*n,i);
    Predkosci(3,i)=DQ_tab(3*n,i);
    Przyspieszenia(1:2,i)=DDQ_tab(3*n-2:3*n-1,i)+Om*Rot(Q_tab(3*n,i))*sA*DDQ_tab(3*n,i)-Rot(Q_tab(3*n,i))*sA*DQ_tab(3*n,i)*DQ_tab(3*n,i);
    Przyspieszenia(3,i)=DDQ_tab(3*n,i);
    
    i=i+1;
    
end




%wyswietlanie wynikow dla punktu
subplot(3,3,1); 
plot(T,Polozenia(1,:));
title('polozenie na x');
xlabel('czas [s]');
ylabel('polozenie [m]'); 
grid on;
subplot(3,3,2);
plot(T,Polozenia(2,:));
title('polozenie na y');
xlabel('czas [s]');
ylabel('polozenie [m]');
grid on;
subplot(3,3,3);
plot(T,Polozenia(3*n,:));
title('kat obrotu');
xlabel('czas [s]');
ylabel('kat obrotu [rad]'); 
grid on;
subplot(3,3,4); 
plot(T,Predkosci(1,:));
title('predkosc na x');
xlabel('czas [s]');
ylabel('predkosc [m/s]');
grid on;
subplot(3,3,5);
plot(T,Predkosci(2,:));
title('predkosc na y');
xlabel('czas [s]');
ylabel('predkosc [m/s]');
grid on;
subplot(3,3,6); 
plot(T,Predkosci(3*n,:));
title('predkosc katowa');
xlabel('czas [s]');
ylabel('predkosc katowa [rad/s]');
grid on;
subplot(3,3,7); 
plot(T,Przyspieszenia(1,:));
title('przyspieszenie na x');
xlabel('czas [s]');
ylabel('przyspieszenie [m/s^2]');
grid on;
subplot(3,3,8); 
plot(T,Przyspieszenia(2,:));
title('przyspieszenie na y');
xlabel('czas [s]');
ylabel('przyspieszenie [m/s^2]');
grid on;
subplot(3,3,9);
plot(T,Przyspieszenia(3*n,:));
title('przyspieszenie katowe');
xlabel('czas [s]');
ylabel('przyspieszenie katowe [rad/s^2]');
grid on;
sgtitle('Wyniki') 
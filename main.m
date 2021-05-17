DT = 0.1;
T_MAX = 30;

[Q, UkladyWspolrzednych, ParyObrotowe, ParyPostepowe] = ReadStartData;
wymuszeniaParametry = WczytajWymuszenia();

DQ=zeros(length(Q),1);
DDQ=zeros(length(Q),1);

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
    
    i=i+1;  
end

    [q, dq, ddq] = liczPunkt(Q,DQ,DDQ, UkladyWspolrzednych, [1.85  0.45]', 10);


%wyswietlanie wynikow dla czlonu 10
subplot(3,3,1); plot(T,Q_tab(28,:));
title('polozenie na x');
xlabel('czas [s]');
ylabel('polozenie [m]'); 
subplot(3,3,2); plot(T,Q_tab(29,:));
title('polozenie na y');
xlabel('czas [s]');
ylabel('polozenie [m]'); 
subplot(3,3,3); plot(T,Q_tab(30,:));
title('kat obrotu');
xlabel('czas [s]');
ylabel('kat obrotu [rad]'); 
subplot(3,3,4); plot(T,DQ_tab(28,:));
title('predkosc na x');
xlabel('czas [s]');
ylabel('predkosc [m/s]');
subplot(3,3,5); plot(T,DQ_tab(29,:));
title('predkosc na y');
xlabel('czas [s]');
ylabel('predkosc [m/s]');
subplot(3,3,6); plot(T,DQ_tab(30,:));
title('predkosc katowa');
xlabel('czas [s]');
ylabel('predkosc katowa [rad/s]');
subplot(3,3,7); plot(T,DDQ_tab(28,:));
title('przyspieszenie na x');
xlabel('czas [s]');
ylabel('przyspieszenie [m/s^2]');
subplot(3,3,8); plot(T,DDQ_tab(29,:));
title('przyspieszenie na y');
xlabel('czas [s]');
ylabel('przyspieszenie [m/s^2]');
subplot(3,3,9); plot(T,DDQ_tab(30,:));
title('przyspieszenie katowe');
xlabel('czas [s]');
ylabel('przyspieszenie katowe [rad/s^2]');
sgtitle('Czlon 10') 
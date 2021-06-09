DT = 0.01;
T_MAX = 5;
time=0:DT:T_MAX;

[Q0, UkladyWspolrzednych, ParyObrotowe, ParyPostepowe] = ReadStartData;
wymuszeniaParametry = WczytajWymuszenia();

%do wpisania:
n=10;                     %numer wybranego czlonu
rA=[1.85;0.45];           %pozycja analizowanego punktu w ukladzie globalnym danego czlonu

sA=rA-Q0(3*n-2:3*n-1);     %pozycja analizowanego pumktu w ukladzie lokalnym

Om=[0 -1;1 0];

Q=Q0;
DQ0=zeros(length(Q),1);
DQ=DQ0;
DDQ=zeros(length(Q),1);
Y0=[Q0;DQ0];                

Polozenia=zeros(3,length(time));
Predkosci=zeros(3,length(time));
Przyspieszenia=zeros(3,length(time));

%tu sa tablice do zbierania danych
T=zeros(1,(T_MAX/DT));
Q_tab=zeros(length(Q),(T_MAX/DT));
DQ_tab=zeros(length(Q),(T_MAX/DT));
DDQ_tab=zeros(length(Q),(T_MAX/DT));

%tic
%t0=0;
options=odeset('RelTol', 1e-6, 'AbsTol', 1e-9);
[t,Y]=ode45(@H,time,Y0,options);

%toc

Y = Y';       
dY = zeros(size(Y));      %z paczki

for i=i:length(t)
	dY(:,i) = H( t(i), Y(:,i), ParyObrotowe, ParyPostepowe, WymuszeniaParametry,Masy, Bezwladnosci, Fi, FiDQ_DQ, Gamma,Sily,WczytajMasyBezwladnosci );
end


qK=[Y(1:n,:)];
dqK=[Y((n+1):(2*n),:)];
%q_dq=[qK dqK]
ddqK=[dY((n+1):(2*n),:)];

%dziwny ruch - nwm czy do konca dobrze i czy jest konieczny - w paczce
%chyba brak, w skrypcie jest
%F=Fi(qK,t,ParyObrotowe, ParyPostepowe, WymuszeniaParametry);
%norm_F=norm(F);


%i=1;

%for t=0:DT:T_MAX

    %FI=Fi(Q, t, ParyObrotowe, ParyPostepowe, wymuszeniaParametry);
    %FIq = Jakobian(Q, ParyObrotowe, ParyPostepowe, wymuszeniaParametry);
    %FI_dt = Fi_dt(Q,t, wymuszeniaParametry);
    
    %obliczanie polozen
    %Q=Q+DQ*DT+DDQ*DT*DT/2;  
    %Q=NewRaph(Q,t,ParyObrotowe, ParyPostepowe, wymuszeniaParametry);    
   
    %obliczanie predkosci
    %FIq = Jakobian(Q, ParyObrotowe, ParyPostepowe, wymuszeniaParametry);
    %FI_dt = Fi_dt(Q,t, wymuszeniaParametry);
    %DQ = -FIq \ FI_dt;                                                  
    
    %obliczanie przyspieszen
    %GAMMA = Gamma(Q,DQ, ParyObrotowe, ParyPostepowe, wymuszeniaParametry,t);
    %DDQ = FIq\GAMMA;
    
    %zapisywanie wartosci do tablic
    %T(1,i)=t;
    Q_tab=qK;
    DQ_tab=dqK;
    DDQ_tab=ddqK;
    
    
    %obliczenia dla konkretnego punktu
    Polozenia(1:2,:)=Q_tab(3*n-2:3*n-1,:)+Rot(Q_tab((3*n),:))*sA;
    Polozenia(3,:)=Q_tab((3*n),:);
    Predkosci(1:2,:)=DQ_tab(3*n-2:3*n-1,:)+Om*Rot(Q_tab(3*n,:))*sA*DQ_tab(3*n,:);
    Predkosci(3,:)=DQ_tab(3*n,:);
    Przyspieszenia(1:2,:)=DDQ_tab(3*n-2:3*n-1,:)+Om*Rot(Q_tab(3*n,:))*sA*DDQ_tab(3*n,:)-Rot(Q_tab(3*n,:))*sA*DQ_tab(3*n,:)*DQ_tab(3*n,:);
    Przyspieszenia(3,:)=DDQ_tab(3*n,:);
    
    %i=i+1;
    
%end




%wyswietlanie wynikow dla punktu
% subplot(3,3,1); 
% plot(T,Polozenia(1,:));
% title('polozenie na x');
% xlabel('czas [s]');
% ylabel('polozenie [m]'); 
% grid on;
% subplot(3,3,2);
% plot(T,Polozenia(2,:));
% title('polozenie na y');
% xlabel('czas [s]');
% ylabel('polozenie [m]');
% grid on;
% subplot(3,3,3);
% plot(T,Polozenia(3*n,:));
% title('kat obrotu');
% xlabel('czas [s]');
% ylabel('kat obrotu [rad]'); 
% grid on;
% subplot(3,3,4); 
% plot(T,Predkosci(1,:));
% title('predkosc na x');
% xlabel('czas [s]');
% ylabel('predkosc [m/s]');
% grid on;
% subplot(3,3,5);
% plot(T,Predkosci(2,:));
% title('predkosc na y');
% xlabel('czas [s]');
% ylabel('predkosc [m/s]');
% grid on;
% subplot(3,3,6); 
% plot(T,Predkosci(3*n,:));
% title('predkosc katowa');
% xlabel('czas [s]');
% ylabel('predkosc katowa [rad/s]');
% grid on;
% subplot(3,3,7); 
% plot(T,Przyspieszenia(1,:));
% title('przyspieszenie na x');
% xlabel('czas [s]');
% ylabel('przyspieszenie [m/s^2]');
% grid on;
% subplot(3,3,8); 
% plot(T,Przyspieszenia(2,:));
% title('przyspieszenie na y');
% xlabel('czas [s]');
% ylabel('przyspieszenie [m/s^2]');
% grid on;
% subplot(3,3,9);
% plot(T,Przyspieszenia(3*n,:));
% title('przyspieszenie katowe');
% xlabel('czas [s]');
% ylabel('przyspieszenie katowe [rad/s^2]');
% grid on;

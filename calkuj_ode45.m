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

[t,Y]=ode45(@H,t0:0.01:tk,Y0);

%toc
n=size(Y,1); % Liczba wierszy w tablicy wynik�w
err_F(n)=0; err_dF(n)=0; err_d2F(n)=0; % Niespe�nienie wi�z�w - deklaracja d�ugo�ci wektor�w 
m = length(q0);
ddq(n,m)=0;
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
    ddq(i,:)=x(1:m,1);
    
   
    % Obliczenie miar rozerwania wi�z�w
    err_F(i)=norm(FI);               % B��d wi�z�w dla po�o�e�
    err_dF(i)=norm(FQ*dq);          % B��d wi�z�w dla pr�dko�ci
    err_d2F(i)=norm(FQ*d2q-G);      % B��d wi�z�w dla przyspiesze�
end
%plot(t,err_F,'b','LineWidth',2); hold on;
%plot(t,err_dF,'g','LineWidth',2);
%plot(t,err_d2F,'r','LineWidth',2);
%grid;
%legend('Po�o�enia','Pr�dko�ci','Przyspieszenia'); hold off;

plot(t,Y(:,28));


Polozenia=zeros(3,length(n));
Predkosci=zeros(3,length(n));
Przyspieszenia=zeros(3,length(n));

%obliczenia dla konkretnego punktu
n=9;                     %numer wybranego czlonu
rA=[1.55;0.8];           %pozycja analizowanego punktu w ukladzie globalnym danego czlonu
sA=rA-q0(3*n-2:3*n-1);     %pozycja analizowanego pumktu w ukladzie lokalnym
    Polozenia(1:2,:)=Y(:,3*n-2:3*n-1)'+Rot(Y(:,(3*n))')*sA;
    Polozenia(3,:)=Y(:,(3*n))';
    Predkosci(1:2,:)=Y(:,30+3*n-2:30+3*n-1)'+Om*Rot(Y(:,30+3*n)')*sA*Y(:,30+3*n)';
    Predkosci(3,:)=Y(:,30+3*n)';
    Przyspieszenia(1:2,:)=ddq(:,3*n-2:3*n-1)'+Om*Rot(Y(:,3*n)')*sA*ddq(:,3*n)'-Rot(Y(:,3*n)')*sA*Y(:,30+3*n)'*Y(:,30+3*n)';
    Przyspieszenia(3,:)=ddq(:,3*n)';
    
    
    
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
plot(t,Polozenia(3*n,:));
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
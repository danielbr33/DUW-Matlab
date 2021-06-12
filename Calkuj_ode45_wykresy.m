function Calkuj_ode45_wykresy(tK)
% Calkuj_ode45_wykresy
% Ca³kowanie równañ ruchu metod¹ Rungego-Kutty - ode45
% Przedzia³ czasu o d³ugoœci tK
% Brak stabilizacji wiêzów
% Po wykonaniu obliczeñ utworzenie wykresów dok³adnoœci spe³nienia wiêzów

if nargin == 0; tK=5; end

% Przedzia³ ca³kowania
t0=0;  % t0 - pocz¹tek, tK - koniec

% Warunki pocz¹tkowe
q0=[0 0 0 1/sqrt(2) -1/sqrt(2) pi/4]';
dq0=zeros(6,1);
Y0=[q0;dq0];

% Ca³kowanie (bez stabilizacji wiêzów)
[t,Y]=ode45(@H,t0:0.1:tK,Y0); % Wyniki tablicowane co 0.1 sekundy

% Wykresy dok³adnoœci spe³nienia wiêzów
n=size(Y,1); % Liczba wierszy w tablicy wyników
err_F(n)=0; err_dF(n)=0; err_d2F(n)=0; % Niespe³nienie wiêzów - deklaracja d³ugoœci wektorów 
for i=1:n
    q=Y(i,1:6)'; dq=Y(i,7:12)';  % Po³o¿enia i prêdkoœci w i-tym stablicowanym kroku
    [F,Fq,G,M,Q]=Macierze(q,dq);
    % Ponowne obliczenie przyspieszeñ [procedura ode_45 ich nie przechowuje :( ]
    A=[M,Fq';Fq,zeros(4,4)];     
    b=[Q;G];                   
    x=A\b;                           
    d2q=x(1:6,1);
    % Obliczenie miar rozerwania wiêzów
    err_F(i)=norm(F);               % B³¹d wiêzów dla po³o¿eñ
    err_dF(i)=norm(Fq*dq);          % B³¹d wiêzów dla prêdkoœci
    err_d2F(i)=norm(Fq*d2q-G);      % B³¹d wiêzów dla przyspieszeñ
end
% Tworzenie wykresów
plot(t,err_F,'b','LineWidth',2); hold on;
plot(t,err_dF,'g','LineWidth',2);
plot(t,err_d2F,'r','LineWidth',2);
grid;
legend('Po³o¿enia','Prêdkoœci','Przyspieszenia'); hold off;
end


function dY=H(t,Y)
%Funkcja podca³kowa
q=Y(1:6,:);                   % Czytelne nazwy po³o¿eñ i prêdkoœci
dq=Y(7:12,:);
[F,Fq,G,M,Q]=Macierze(q,dq);  % Obliczenia dla aktualnych po³o¿eñ i prêdkoœci
A=[M,Fq';Fq,zeros(4,4)];      % Macierz uk³adu równañ
b=[Q;G];                      % Prawa strona uk³adu równañ
x=A\b;                        % Obliczenie przyspieszeñ i mno¿ników Lagrange'a
dY(1:6,1)=dq;                 % Obliczenie wektora prawych stron równania ró¿niczkowego
dY(7:12,1)=x(1:6,1);
end

clear all;
clc;

%% Wczytanie danych - utworzenie czlonow

xc0=[0 0; 0.15 0.7; 0.7 0.85; 0.15 0.3; 0.05 0.1; 0.45 0.55; 0.15 0.45; 0.85 0.55; 0.95 0.7; 1.55 0.8; 1.85 0.45];
xs{1}=[0 0 0 0.4 0 0.7];
xs{2}=[0.2 0.4 0 0.7 0 0.8 0.3 1];
xs{3}=[0.3 1 1.1 0.7];
xs{4}=[0.2 0.4];
xs{5}=[0 0];
xs{6}=[0.6 0.6];
xs{7}=[0 0.4];
xs{8}=[0 0.8 0.9 0.6 1.7 0.2];
xs{9}=[0.6 0.6 0.9 0.6 1.1 0.7 1.2 0.9];
xs{10}=[1.2 0.9 1.9 0.7];
xs{11}=[1.7 0.2 2 0.4 1.9 0.7];

for i=1:11
    
    czlon{i}=Utworz_czlon(xc0(i,:),0.5*length(xs{i}),xs{i});
    
end

%% Utworzenie par kinematycznych i wektora Fi

Dane_PO=[1 5 1 1; 1 7 2 1; 1 2 3 2; 2 3 4 1; 2 4 1 1; 2 8 3 1; 3 9 2 3; 6 9 1 1;8 9 2 2; 8 11 3 1;...
    9 10 4 1; 10 11 2 3];
Dane_PP=[4 5 1 1; 6 7 1 1];
Dane_PPD=[4 5 1 1; 6 7 1 1];

% Fi=RHS(czlon,Dane_PO,Dane_PP,Dane_PPD,t);
% 
% J=Jakobian(czlon,Dane_PO,Dane_PP,Dane_PPD,t,Fi);

%% Rozwiazanie

T=10;
dt=0.01;
t=0:dt:T;

iter=1;

Q=zeros(size(t,2),3*(length(czlon)-1));
DQ=zeros(size(t,2),3*(length(czlon)-1));
D2Q=zeros(size(t,2),3*(length(czlon)-1));

while iter<=size(t,2)
   
    % Metoda Newtona Raphsona
    czlon=NewRaph(czlon,Dane_PO,Dane_PP,Dane_PPD,t(iter));
    q=Readq(czlon);
    
    % Zagadnienie znajdywania predkosci
    
    VelRHS=VRHS(t(iter));
    F=RHS(czlon,Dane_PO,Dane_PP,Dane_PPD,t(iter));
    F=F';
    Fq=Jakobian(czlon,Dane_PO,Dane_PP,Dane_PPD,t(iter),F);
    dq=Fq\VelRHS;
    
    % Zagadnienie znajdywania przyspieszen
    
    G=Gamma(czlon,Dane_PO,Dane_PP,Dane_PPD,t(iter),dq)';
    d2q=Fq\G;
    
    q=q+dt*dq+0.5*dt*dt*d2q;
    czlon=Writeq(czlon,q);
    
    % Zapis danych do macierzy
    
    Q(iter,:)=q';
    DQ(iter,:)=dq';
    D2Q(iter,:)=d2q';
    
    % Inkrementacja wskaznika
    
    iter=iter+1;
    
end


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
    
    Q=Q+DQ*DT+DDQ*DT*DT/2;  
    Q=NewRaph(Q,t,ParyObrotowe, ParyPostepowe, wymuszeniaParametry);
   
    FIq = Jakobian(Q, ParyObrotowe, ParyPostepowe, wymuszeniaParametry);
    FI_dt = Fi_dt(Q,t, wymuszeniaParametry);
    DQ = -FIq \ FI_dt;
    
    GAMMA = Gamma(Q,DQ, ParyObrotowe, ParyPostepowe, wymuszeniaParametry,t);
    DDQ = FIq\GAMMA;
    
    T(1,i)=t;
    Q_tab(:,i)=Q;
    DQ_tab(:,i)=DQ;
    DDQ_tab(:,i)=DDQ;
    
    i=i+1;
    
end
plot(T,DDQ_tab(28,:))
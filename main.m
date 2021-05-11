%tbh gubie sie w oznaczeniach :') i w sumie tak sobie mysle - w petli for
%dobrze by bylo aktualizowac wartosci jakichs zmiennych "chwilowych" i
%zapisywac je do konkretnych tablic

%przyspieszenia jeszcze nie sa liczone

DT = 0.1;
T_MAX = 30;

[q, UkladyWspolrzednych, ParyObrotowe, ParyPostepowe] = ReadStartData;

Q=q;
DQ=zeros(length(Q),1);
DDQ=zeros(length(Q),1);

%tu sa tablice do zbierania danych
T=zeros(1,(T_MAX/DT));
Q_tab=zeros(length(Q),(T_MAX/DT));
DQ_tab=zeros(length(Q),(T_MAX/DT));
DDQ_tab=zeros(length(Q),(T_MAX/DT));

for t=0:DT:T_MAX
    i=1
    FI=Fi(Q, t, ParyObrotowe, ParyPostepowe);
    jakobian = Jakobian(Q, ParyObrotowe, ParyPostepowe);
    
    Q=Q+DQ*DT+DDQ*DT*DT/2   
    
    Q=NewRaph(Q,t,ParyObrotowe,ParyPostepowe);
    DQ=Predkosci(Q, ParyObrotowe, ParyPostepowe,t, Fi_dt);
    DDQ=Przyspieszenia(DQ,Q,ParyObrotowe,ParyPostepowe,t);
    
    T(i)=t;
    Q_tab(i)=Q1;
    DQ_tab(i)=DQ1;
    DDQ_tab(i)=DDQ1;
    
    i=i+1;
    
end

DT = 0.1;
T_MAX = 30;

[q, UkladyWspolrzednych, ParyObrotowe, ParyPostepowe] = ReadStartData;

Q=q;
DQ=zeros(length(Q),1);
DDQ=zeros(length(Q),1);

for t=0:DT:T_MAX
    FI=Fi(Q, t, ParyObrotowe, ParyPostepowe);
    jakobian = Jakobian(Q, ParyObrotowe, ParyPostepowe);
end
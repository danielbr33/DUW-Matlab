DT = 0.1
T_MAX = 30

[q, UkladyWspolrzednych, ParyObrotowe, ParyPostepowe] = ReadStartData;

Q=q;
DQ=zeros(length(Q),1);
DDQ=zeros(length(Q),1);
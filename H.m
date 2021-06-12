function dY=H(t,Y)

[Q0, UkladyWspolrzednych, ParyObrotowe, ParyPostepowe] = ReadStartData;
WymuszeniaParametry = WczytajWymuszenia();
[Masy, Bezwladnosci, Macierz] = WczytajMasyBezwladnosci;

temp = fopen('DanePliki/UkladyWspolrzednych.txt', 'r');
number = str2num(fgetl(temp));
fclose(temp);
n=number*3;

q=Y(1:n);
dq=Y((n+1):(2*n));

F=Fi(q,t,ParyObrotowe, ParyPostepowe, WymuszeniaParametry);
Fq=Fidq_dq(q,dq,t,ParyObrotowe, ParyPostepowe, WymuszeniaParametry)
G=Gamma(q,dq, ParyObrotowe, ParyPostepowe, WymuszeniaParametry,t);
M = Macierz;
Q = Sily(q, dq, ParyPostepowe, Masy);



A=[M Fq';Fq zeros(28,28)];
b=[Q;G];
x=A\b;

dY(1:n,1)=dq;
dY((n+1):(2*n),1)=x(1:n,1); %przyspieszenia

end
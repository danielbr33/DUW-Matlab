function dY=H(t,Y, M, ParyObrotowe, ParyPostepowe, WymuszeniaParametry,Masy, Bezwladnosci)

q=Y(1:n,:);
dq=Y((n+1):(2*n),:);

F=Fi(q,t,ParyObrotowe, ParyPostepowe, WymuszeniaParametry);
Fq=FiDQ_DQ(q,dq,t,ParyObrotowe, ParyPostepowe, WymuszeniaParametry);
G=Gamma(q,dq, ParyObrotowe, ParyPostepowe, WymuszeniaParametry,t);
M=WczytajMasyBezwladnosci();    %tu idk jak powinno byc
Q=Sily(q, dq, UkladyWspolrzednych, ParyPostepowe, Masy, Bezwladnosci);

A=[M,Fq'; Fq, zeros(4,4)];
b=[Q;G];
x=A\b;

dY(1:n,1)=dq;
dY((n+1):(2*n),1)=x(1:n,1); %przyspieszenia

end
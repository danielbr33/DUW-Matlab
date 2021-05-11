function F = Gamma(Q,dQ)

 temp = fopen('DanePliki/UkladyWspolrzednych.txt', 'r');
 ncz = str2num(fgetl(temp)); 
 fclose(temp);
 temp = fopen('DanePliki/ParyObrotowe.txt', 'r');
 nobr = str2num(fgetl(temp));
 fclose(temp);
 temp = fopen('DanePliki/ParyPostepowe.txt', 'r');
 npos = str2num(fgetl(temp));
 fclose(temp);
 temp = fopen('DanePliki/Wymuszenia.txt', 'r');
 nwym = str2num(fgetl(temp));
 fclose(temp);
 
 Om=[0 -1;1 0];
 Fq=zeros(2*(nobr+npos)+nwym,3*ncz);      %deklaracja rozm macierzy
 k=0; 
 
%%Pary obrotowe, wz�r 2.42
for m=1:1:nobr
    i=3*ParyObrotowe(m,1);
    j=3*ParyObrotowe(m,2);
    if j==0
        kat_j = 0;
    else
        kat_j = q(j);
    end
    if i==0
        kat_i = 0;
    else
        kat_i = q(i);
    end
    s_a = ParyObrotowe(m,3:4)';
    s_b = ParyObrotowe(m,5:6)';
    if i==0
        F(k+1:k+2)=F(k+1:k+2) - Rot(Q(j))*s_b*dQ(j)*dQ(j);
    elseif j==0
        F(k+1:k+2)=F(k+1:k+2) + Rot(Q(i))*s_a*dQ(i)*dQ(i);
    else
        F(k+1:k+2)=F(k+1:k+2) + Rot(Q(i))*s_a*dQ(i)*dQ(i) - Rot(Q(j))*s_b*dQ(j)*dQ(j);
    end
    k=k+2;
end

%%Pary postepowe, wz�r  2.59
F(k+1) = F(k+1);

%% Wymuszenia, wz�r 2.59, opis na stronie 52
  temp = fopen('DanePliki/Wymuszenia.txt', 'r');
  number = str2num(fgetl(temp));
  for m=1:1:number
    dane = str2num(fgetl(temp));
    i=3*dane(1);
    j=3*dane(2);
     uj = Rot(dane(10))*[1 0]';
     vj = ParyPostepowe(m,4:5)';
     F(k+1)=F(k+1) + (Rot(Q(j))*uj)'*(2*Om*(dQ(j-2:j-1)-dQ(i-2:i-1))*dQ(j)+(Q(j-2:j-1)-Q(i-2:i-1))*dQ(j)*dQ(j)) + LiczWymuszenia;
    k=k+1;
 end
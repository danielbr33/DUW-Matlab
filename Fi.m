function F=Fi(Q,t,ParyObrotowe, ParyPostepowe);

 temp = fopen('DanePliki/ParyObrotowe.txt', 'r');
 nobr = str2num(fgetl(temp));
 fclose(temp);
 
 temp = fopen('DanePliki/ParyPostepowe.txt', 'r');
 npos = str2num(fgetl(temp));
 fclose(temp);
 
 temp = fopen('DanePliki/Wymuszenia.txt', 'r');
 nwym = str2num(fgetl(temp));
 fclose(temp);
 
 k=0;                         %licznik równań więzów
 F=zeros(2*(nobr+npos)+nwym,1);    %deklaracja rozmiaru wektora
    
 %% na podstawie wzoru 2.18
 for m=1:nobr
        i=3*ParyObrotowe(m,1);
        j=3*ParyObrotowe(m,2);
        s_a = ParyObrotowe(m,3:4)';
        s_b = ParyObrotowe(m,5:6)';
        if i == 0
            F(k+1:k+2)=F(k+1:k+2) + s_a - Q(j-2:j-1)-Rot(Q(j))*s_b;
        elseif j == 0
            F(k+1:k+2)=F(k+1:k+2) + Q(i-2:i-1)+Rot(Q(i))*s_a-s_b;
        else
            F(k+1:k+2)=F(k+1:k+2) + Q(i-2:i-1)+Rot(Q(i))*s_a-Q(j-2:j-1)-Rot(Q(j))*s_b;
        end
        k=k+2;
 end
 
 %% Na podstawie wzor�w 2.19 i 2.22
 for m=1:npos
     i=3*ParyPostepowe(m,1);
     j=3*ParyPostepowe(m,2);
     fi0 = ParyPostepowe(m,3);
     s_b = ParyPostepowe(m,8:9)';
     s_a = ParyPostepowe(m,6:7)';
     vj = ParyPostepowe(m,4:5)';
     if j==0
         rj == [0 0]';
         kat_j = 0;
     else
         rj = Q(j-2:j-1);
         kat_j = Q(j);
     end
     if i==0
         ri == [0 0]';
         kat_i = 0;
     else
         ri = Q(i-2:i-1);
         kat_i = Q(i);
     end
        
     F(k+1)=F(k+1) + kat_i-kat_j-fi0; 
     F(k+2)=F(k+2) + (rj+Rot(kat_j)*s_b-ri-Rot(kat_i)*s_a)'*Rot(kat_j)*vj;
     
     k=k+2;
 end
 
  %% Wiezy dynamiczne na podstawie wzor�w 2.28
  %Punkty A i B w srodkach czlonow, wiec sa i sb zerowe
  temp = fopen('DanePliki/Wymuszenia.txt', 'r');
  number = str2num(fgetl(temp));
  for m=1:1:number
    dane = str2num(fgetl(temp));
    i=3*dane(1);
    j=3*dane(2);
    uj = Rot(dane(10))*[1 0]';
    f_AB = norm(LiczWymuszenia(Q, t, 1, m));
    F(k+1) = F(k+1) + (Rot(Q(j))*uj)' * (Q(j-2:j-1) - Q(i-2:i-1)) - f_AB;
    k = k+1;
  end
  fclose(temp);
end
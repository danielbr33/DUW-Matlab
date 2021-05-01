function F=Fi(q,t,ParyObrotowe, ParyPostepowe);

 temp = fopen('Dane/ParyObrotowe.txt', 'r');
 nobr = str2num(fgetl(temp));
 
 temp = fopen('Dane/ParyPostepowe.txt', 'r');
 npos = str2num(fgetl(temp));
 
 k=0                         %licznik równań więzów
 F=zeros(2*(nobr+npos),1)    %deklaracja rozmiaru wektora
    
 %%na podstawie wzoru 2.18
 for m=1:nobr
        i=3*ParyObrotowe(m,1);
        j=3*ParyObrotowe(m,2);
        s_a = ParyObrotowe(m,3:4)';
        s_b = ParyObrotowe(m,5:6)';
        if i == 0
            F(k+1:k+2)=s_a - q(j-2:j-1)-Rot(q(j))*s_b;
        elseif j == 0
            F(k+1:k+2)=q(i-2:i-1)+Rot(q(i))*s_a-s_b;
        else
            F(k+1:k+2)=q(i-2:i-1)+Rot(q(i))*s_a-q(j-2:j-1)-Rot(q(j))*s_b;
        end
        k=k+2;
 end
 
 %% Na podstawie wzor�w 2.19 i 2.22
 %NIE WIEM CO ROBI�? I CZY TO JEST DOBRZE - NIEKSONCZONE - problemy z: fi0
 %oraz vj
 %+ czy trzeba tu rozważać te przypadki if else?
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
         rj = q(j-2:j-1);
         kat_j = q(j);
     end
     if i==0
         ri == [0 0]';
         kat_i = 0;
     else
         ri = q(i-2:i-1);
         kat_i = q(i)
     end
        
     F(k+1)=kat_i-kat_j-fi0; 
     F(k+2)=(rj+Rot(kat_j)*s_b-ri-Rot(kat_i)*s_a)'*Rot(kat_j)*vj;
     
     k=k+2;
 end
      
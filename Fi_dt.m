function F=Fi_dt(Q,t);

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
 for m=1:(nobr+npos)
     k=k+2;
 end
 for m=1:nwym
     F(k+1) = norm(LiczWymuszenia(Q, t, 1, m));
     k=k+1;
 end
 
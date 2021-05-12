function Fq = Fidq_dq(Q,dQ,t,ParyObrotowe, ParyPostepowe);

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
 
 %% Obliczenie czesci dla par obrotowych 4.36-4.39
for m=1:1:nobr
    i=3*ParyObrotowe(m,1);
    j=3*ParyObrotowe(m,2);
    if j==0
        katJ = 0;
        katJdt = 0;
    else
        katJ = Q(j);
        katJdt = dQ(j);
    end
    if i==0
        katI = 0;
        katIdt = 0;
    else
        katI = Q(i);
        katIdt = dQ(i);
    end
    if i~=0
        Fq(k+1:k+2,i-2:i)=Fq(k+1:k+2,i-2:i) + [zeros(2,2) Om*Om*Rot(katI)*ParyObrotowe(m,3:4)'*katIdt];
    end
    if j~=0
        Fq(k+1:k+2,j-2:j)=Fq(k+1:k+2,j-2:j) + [zeros(2,2) -Om*Om*Rot(katJ)*ParyObrotowe(m,5:6)'*katJdt];
    end
        k=k+2;
end

%% Obliczenie czesci dla par postepowych 2.47 i 2.54-2.57
for m=1:npos
    i=3*ParyPostepowe(m,1);
    j=3*ParyPostepowe(m,2);
    vj = ParyPostepowe(m, 4:5)';
    if j==0
        katJdt = 0;
    else
        katJdt = dQ(j);
    end
    if i==0
        katIdt = 0;
    else
        katIdt = dQ(i);
    end
    
    if i~=0
        Fq(k+1,i-2:i)=Fq(k+1,i-2:i) + [zeros(1,2) 1];
        Fq(k+2,i-2:i-1)=Fq(k+2,i-2:i-1) + (Rot(katJ)*vj)'*Om*katJdt;
        Fq(k+2,i) = Fq(k+2,i) + 0;
    end
    if j~=0
        Fq(k+1,j-2:j)=Fq(k+1,j-2:j) + [zeros(1,2) -1];
        Fq(k+2,j-2:j-1)=Fq(k+2,j-2:j-1) - (Rot(katJ)*vj)'*Om*katJdt;
        Fq(k+2,j) = Fq(k+2,j) + (dQ(j-2:j-1)-dQ(i-2:i-1)+Om*Q(i-2:i-1)*katJdt-Om*Q(j-2:j-1)*katJdt)'*Om*Rot(katJ)*vj;
    end
    k=k+2;
end

%% Obliczenie czesci dla par dynamicznych
%wedlug opisu na stronie 52 to samo co dla par 
%postepowych tylko uj zamiast vj
 temp = fopen('DanePliki/Wymuszenia.txt', 'r');
 liczba = str2num(fgetl(temp));
 Om=[0 -1;1 0];
 for m=1:1:liczba
     dane = str2num(fgetl(temp));
     i = dane(1);
     j = dane(2);
     uj = Rot(dane(10))*[1 0]';
     vj = ParyPostepowe(m,4:5)';
     
     if i~=0
         Fq(k+1,i-2:i-1)=Fq(k+1,i-2:i-1) + (Rot(katJ)*uj)'*Om*katJdt;
         Fq(k+1,i) = Fq(k+1,i) + 0;
     end
     if j~=0
         Fq(k+1,j-2:j-1)=Fq(k+1,j-2:j-1) - (Rot(katJ)*uj)'*Om*katJdt;
         Fq(k+1,j) = Fq(k+1,j) + (dQ(j-2:j-1)-dQ(i-2:i-1)+Om*Q(i-2:i-1)*katJdt-Om*Q(j-2:j-1)*katJdt)'*Om*Rot(katJ)*uj;
     end
     k = k+1;
 end
 fclose(temp);



function Fq = FiDQ_DQ(Q,DQ,t,ParyObrotowe, ParyPostepowe, WymuszeniaParametry);

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
        katJdt = DQ(j);
    end
    if i==0
        katI = 0;
        katIdt = 0;
    else
        katI = Q(i);
        katIdt = DQ(i);
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
        rj = [0 0]';
        katJ=0;
        drj = [0 0]';
    else
        katJdt = DQ(j);
        rj = Q(j-2:j-1);
        katJ = Q(j);
        drj = DQ(j-2:j-1);
    end
    if i==0
        katIdt = 0;
        ri = [0 0]';
        katI=0;
        dri = [0 0]';
    else
        katIdt = DQ(i);
        ri = Q(i-2:i-1);
        katI=Q(i);
        dri = DQ(i-2:i-1);
    end
    sa = ParyPostepowe(m,3:4)';
    sb = ParyPostepowe(m,5:6)'
    
    Fq(k+1,i-2:i)=Fq(k+1,i-2:i) + [zeros(1,2) 1];
    Fq(k+2,i-2:i-1)=Fq(k+2,i-2:i-1) + (Rot(katJ)*vj)'*Om*katJdt;
    Fq(k+2,i) = Fq(k+2,i) + (Rot(katJ)*vj)'*Rot(katI)*sa*(katIdt-katJdt);

    Fq(k+1,j-2:j)=Fq(k+1,j-2:j) + [zeros(1,2) -1];
    Fq(k+2,j-2:j-1)=Fq(k+2,j-2:j-1) - (Rot(katJ)*vj)'*Om*katJdt;
    Fq(k+2,j) = Fq(k+2,j) + (-dri-Om*Rot(katI)*sa*katIdt+drj-Om*(rj-ri-Rot(katI)*sa)*katJdt)' *Om*Rot(katJ)*vj;
        
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
         if j==0
        fiJdt = 0;
        rj = [0 0]';
        fiJ=0;
        drj = [0 0]';
    else
        fiJdt = DQ(j);
        rj = Q(j-2:j-1);
        fiJ = Q(j);
        drj = DQ(j-2:j-1);
    end
    if i==0
        fiIdt = 0;
        ri = [0 0]';
        fiI=0;
        dri = [0 0]';
    else
        fiIdt = DQ(i);
        ri = Q(i-2:i-1);
        fiI=Q(i);
        dri = DQ(i-2:i-1);
    end
    sa = WymuszeniaParametry(m, 8:9)';
    sb = WymuszeniaParametry(m, 10:11)';
    
    kat = WymuszeniaParametry(m, 7);
     uj = Rot(kat)*[1 0]';

     if i~=0
        Fq(k+1,i-2:i-1)=Fq(k+1,i-2:i-1) + (Rot(fiJ)*uj)'*Om*fiJdt;
        Fq(k+1,i) = Fq(k+1,i) + (Rot(fiJ)*uj)'*Rot(fiI)*sa*(fiIdt-fiJdt);
     end
     if j~=0
        Fq(k+1,j-2:j-1)=Fq(k+1,j-2:j-1) - (Rot(fiJ)*uj)'*Om*fiJdt;
        Fq(k+1,j) = Fq(k+1,j) + (-dri-Om*Rot(fiI)*sa*fiIdt+drj-Om*(rj-ri-Rot(fiI)*sa)*fiJdt)' *Om*Rot(katJ)*uj;
     end
     k = k+1;
 end
 fclose(temp);



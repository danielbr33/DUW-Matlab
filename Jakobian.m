function Fq=Jakobian(q, ParyObrotowe, ParyPostepowe)
%ALERT PLIK NIEDOKONCZONY
%NA PODST. PREZENTACJI Z ZAJÊÆ ORAZ SKRYPTU - STRONY 47 i 48

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
Fq=zeros(2*(nobr+npos+nwym),3*ncz);      %deklaracja rozm macierzy
k=0;                                %licznik równañ wiêzów

%% Obliczenie czesci Jakobianu dla par obrotowych 4.31-4.34
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
    if i~=0 
        Fq(k+1:k+2,i-2:i)=Fq(k+1:k+2,i-2:i) + [eye(2) Om*Rot(kat_i)*ParyObrotowe(m,3:4)'];
    end
    if j~=0
        Fq(k+1:k+2,j-2:j)=Fq(k+1:k+2,j-2:j) + [-eye(2) -Om*Rot(kat_j)*ParyObrotowe(m,5:6)'];
    end
    k=k+2;
end

%% Obliczenie czesci jakobiany dla par postepowych 2.43-2.46
for m=1:npos
    i=3*ParyPostepowe(m,1);
    j=3*ParyPostepowe(m,2);
    vj = ParyPostepowe(m, 4:5)';
    
    if i~=0
        Fq(k+1,i-2:i)=Fq(k+1,i-2:i) + [zeros(1,2) 1];
        Fq(k+2,i-2:i)=Fq(k+2,i-2:i) + [-(Rot(q(j))*vj)'  -(Rot(q(j))*vj)'*Om*Rot(q(i))*ParyPostepowe(m,3:4)']; 
    end
    if j~=0
        Fq(k+1,j-2:j)=Fq(k+1,j-2:j) + [zeros(1,2) -1];
        Fq(k+2,j-2:j)=Fq(k+2,j-2:j) + [(Rot(q(j))*vj)' -(Rot(q(j))*vj)'*Om*(q(j-2:j-1)-q(i-2:i-1)-Rot(q(i))*ParyPostepowe(m,3:4)')];
    end
    k=k+2;
end

%% Obliczenie czesci jakobiany dla par dynamicznych 2.61-2.64
 temp = fopen('DanePliki/Wymuszenia.txt', 'r');
 liczba = str2num(fgetl(temp));
 Om=[0 -1;1 0];
 for m=1:1:liczba
     dane = str2num(fgetl(temp));
     i = dane(1);
     j = dane(2);
     Fq(k+1:k+2, i-2:i-1) =Fq(k+1:k+2, i-2:i-1) -Rot(q(i));
     Fq(k+1:k+2, i) =Fq(k+1:k+2, i) -Rot(q(i))*Om*(q(j-2:j-1)-q(i-2:i-1));
     Fq(k+1:k+2, j-2:j-1) = Fq(k+1:k+2, j-2:j-1) + Rot(q(i));
     Fq(k+1:k+2, j) = Fq(k+1:k+2, j) + [0 0]';
 end
 fclose(temp);
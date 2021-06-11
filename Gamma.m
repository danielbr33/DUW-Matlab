function F = Gamma(Q,DQ, ParyObrotowe, ParyPostepowe, WymuszeniaParametry,t)

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
 F=zeros(2*(nobr+npos),1);      %deklaracja rozm macierzy
 k=0; 
 
%% Pary obrotowe, wzór 2.40
for m=1:1:nobr
    i=3*ParyObrotowe(m,1);
    j=3*ParyObrotowe(m,2);
    if j==0
        kat_j = 0;
    else
        kat_j = Q(j);
    end
    if i==0
        kat_i = 0;
    else
        kat_i = Q(i);
    end
    s_a = ParyObrotowe(m,3:4)';
    s_b = ParyObrotowe(m,5:6)';
    if i==0
        F(k+1:k+2)=F(k+1:k+2) - Rot(Q(j))*s_b*DQ(j)*DQ(j);
    elseif j==0
        F(k+1:k+2)=F(k+1:k+2) + Rot(Q(i))*s_a*DQ(i)*DQ(i);
    else
        F(k+1:k+2)=F(k+1:k+2) + Rot(Q(i))*s_a*DQ(i)*DQ(i) - Rot(Q(j))*s_b*DQ(j)*DQ(j);
    end
    k=k+2;
end

%% Pary postepowe, wzór  2.48 i 2.59
 for m=1:1:npos
     i=3*ParyPostepowe(m,1);
     j=3*ParyPostepowe(m,2);
     fi0 = ParyPostepowe(m,3);
     s_b = ParyPostepowe(m,8:9)';
     s_a = ParyPostepowe(m,6:7)';
     vj = ParyPostepowe(m,4:5)';
    
    if i==0
        ri=[0 0]';
        fii=0;
        dri=[0 0]';
        dfii=0;
    else
        ri=Q(i-2:i-1);
        fii=Q(i);
        dri=DQ(i-2:i-1);
        dfii=DQ(i);
    end
    if j==0
        rj=[0 0]';
        fij=0;
        drj=[0 0]';
        dfij=0;
    else
        rj=Q(j-2:j-1);
        fij=Q(j);
        drj=DQ(j-2:j-1);
        dfij=DQ(j);
    end
     F(k+1) = F(k+1);
     %wzor 2.59
     F(k+2)=F(k+2)+(Rot(fij)*vj)'*(2*Om*(drj-dri)*dfij+(rj-ri)*dfij*dfij-Rot(fii)*s_a*(dfij-dfii)^2);
    k=k+2;
 end
 
% %% Wymuszenia, wzór 2.59, opis na stronie 52
%   temp = fopen('DanePliki/Wymuszenia.txt', 'r');
%   number = str2num(fgetl(temp));
%   for m=1:1:number
%     dane = str2num(fgetl(temp));
%     i=3*dane(1);
%     j=3*dane(2);
%     if i==0
%         ri=[0 0]';
%         fii=0;
%         dri=[0 0]';
%         dfii=0;
%     else
%         ri=Q(i-2:i-1);
%         fii=Q(i);
%         dri=DQ(i-2:i-1);
%         dfii=DQ(i);
%     end
%     if j==0
%         rj=[0 0]';
%         fij=0;
%         drj=[0 0]';
%         dfij=0;
%     else
%         rj=Q(j-2:j-1);
%         fij=Q(j);
%         drj=DQ(j-2:j-1);
%         dfij=DQ(j);
%     end
%     sa = WymuszeniaParametry(m, 8:9)';
%     sb = WymuszeniaParametry(m, 10:11)';
%     kat = WymuszeniaParametry(m, 7);
%     uj = Rot(kat)*[1 0]';
%     f_AB = LiczWymuszenia(Q, t, 2, m, WymuszeniaParametry);
%     
%     F(k+1)=F(k+1)+(Rot(fij)*uj)'*(2*Om*(drj-dri)*dfij+(rj-ri)*dfij*dfij-Rot(fii)*s_a*(dfij-dfii)^2)+f_AB;
%     k=k+1;
%   end
% fclose(temp);

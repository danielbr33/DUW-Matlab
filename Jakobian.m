function Fq=Jakobian(q)
%ALERT PLIK NIEDOKONCZONY
%NA PODST. PREZENTACJI Z ZAJÊÆ ORAZ SKRYPTU - STRONY 47 i 48

 temp = fopen('Dane/UkladyWspolrzednych.txt', 'r');
 ncz = str2num(fgetl(temp)); 

 temp = fopen('Dane/ParyObrotowe.txt', 'r');
 nobr = str2num(fgetl(temp));
 
 temp = fopen('Dane/ParyPostepowe.txt', 'r');
 npos = str2num(fgetl(temp));

Om=[0 -1;1 0];

Fq=zeros(2*(nobr+npos),3*ncz);          %deklaracja rozm macierzy

k=0;                                    %licznik równañ wiêzów

for m=1:nobr
    i=3*RevoluteJoint(m,1);
    j=3*RevoluteJoint(m,2);
    if i ~= 0
        Fq(k+1:k+2,i-2:i)=[eye(2) Om*Rot(q(i))*RevoluteJoint(m,3:4)];
    end
    if j ~= 0
        Fq(k+1:k+2,j-2:j)=[-eye(2) -Om*Rot(q(j))*RevoluteJoint(m,5:6)];
    end
    k=k+2;
end

%IMPROWIZACJA NA PODSTAWIE STRONY 48 ZE SKRYPTU: (nadal nie wiem, sk¹d
%wzi¹æ vj)
for m=1:npos
    i=3*PrismaticJoint(m,1);
    j=3*PrismaticJoint(m,2);
    
        Fq(k+1,i-2:i)=[zeros(1,2) 1];
        Fq(k+1,j-2:j)=[zeros(1,2) -1];
        
        Fq(k+2,i-2:i)=[-(Rot(q(j))*vj)' -(Rot(q(j))*vj)'*Om*Rot(q(i))*PrismaticJoint(m,3:4)]; %sk¹d wzi¹æ vj - odwieczne pytanie
        Fq(k+2,j-2:j)=[(Rot(q(j))*vj)' -(Rot(q(j))*vj)'*Om*(q(j-2:j-1)-q(i-2:i-1)-Rot(q(i))*PrismaticJoint(m,3:4))];
   
end
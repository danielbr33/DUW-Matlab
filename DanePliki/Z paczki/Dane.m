function [Czlony, ParyObrotowe, ParyPostepowe, WymObrotowe, WymPostepowe] = Dane()
    %Funkcja wczytuj¹ca dane z plików txt 
    
    c = fopen('Dane/Cz³ony.txt', 'r');
    p = fopen('Dane/Pary.txt', 'r');
    w = fopen('Dane/Wymuszenia.txt', 'r');
    
    %Wczytanie cz³onów
    no = str2num(fgetl(c));  % wczytanie liczby cz³onów
    for i = 1:no
        Czlony(3*(i-1)+1:3*i) = str2num(fgetl(c));  %wczytanie poszczególnych cz³onów [x,y,fi]
    end
    Czlony
    Czlony = Czlony'   %macierz 3 x no
    
    %Wczytanie par obrotowych - rozdzial 2.3
    no = str2num(fgetl(p));     %pierwsza dana to liczba par obrotowych
    ParyObrotowe = zeros(no, 6);    
    for i = 1:no
        tmp = str2num(fgetl(p));
        Czlon1 = tmp(1); Czlon2 = tmp(2);
        Polozenie = [tmp(3); tmp(4)];

        if(Czlon1==0)
            q1 = [0;0]; f1 = 0;
        else
            q1 = Czlony(3*Czlon1-2 : 3*Czlon1-1); f1 = Czlony(3*Czlon1);
        end
        
        if(Czlon2==0)
            q2 = [0;0]; f2 = 0;
        else
            q2 = Czlony(3*Czlon2-2 : 3*Czlon2-1); f2 = Czlony(3*Czlon2);
        end
        
        R1 = Rot(f1); R2 = Rot(f2);

        ParyObrotowe(i,1:2) = [Czlon1,Czlon2];
        ParyObrotowe(i,3:4) = R1'*(Polozenie-q1);
        ParyObrotowe(i,5:6) = R2'*(Polozenie-q2);
        
    end
    ParyObrotowe
    %Wczytanie par postêpowych - rozdzia³ 2.3
    no = str2num(fgetl(p));
    ParyPostepowe = zeros(no,13);
    for i = 1:no
        tmp = str2num(fgetl(p));
        Czlon1 = tmp(1); Czlon2 = tmp(2);
        Polozenie1 = [tmp(3); tmp(4)];
        Polozenie2 = [tmp(5); tmp(6)];

        if(Czlon1==0)
            q1 = [0;0]; f1 = 0;
        else
            q1 = Czlony(3*Czlon1-2 : 3*Czlon1-1); f1 = Czlony(3*Czlon1);
        end
        
        if(Czlon2==0)
            q2 = [0;0]; f2 = 0;
        else
            q2 = Czlony(3*Czlon2-2 : 3*Czlon2-1); f2 = Czlony(3*Czlon2);
        end

    R1 = Rot(f1); R2 = Rot(f2);
    ParyPostepowe(i,1:2) = [Czlon1,Czlon2];
    ParyPostepowe(i,3) = f1 - f2;
    ParyPostepowe(i,6:7) = R1'*(Polozenie1-q1);
    ParyPostepowe(i,8:9) = R2'*(Polozenie2-q2);
    ParyPostepowe(i,10:13)=[Polozenie1',Polozenie2']
    U = [Polozenie2(1)-Polozenie1(1);Polozenie2(2)-Polozenie1(2)];
    U = U/norm(U);
    U = R2'*U;
    ParyPostepowe(i,4:5) = U';
    end
    ParyPostepowe
    %Wczytanie wymuszen obrotowych 
    no = str2num(fgetl(w));
    WymObrotowe = zeros(no,2);
    for i  = 1:no
        WymObrotowe(i,:) = str2num(fgetl(w));
    end
    WymObrotowe
    %Wczytanie wymuszen postepowych 
    no = str2num(fgetl(w));


    WymPostepowe = zeros(no,5);
    for i  = 1:no
        WymPostepowe(i,:) = str2num(fgetl(w));
        
    end
    WymPostepowe
end
        


function [DQ] = Predkosc(Q_TEMP, ParyObrotowe, ParyPostepowe, WymObrotowe, WymPostepowe,T_TEMP)
    %Funkcja rozwi¹zuj¹ca zadanie o prêdkoœci
    
    FT = zeros(length(Q_TEMP), 1);
    Pozycja = 2*(size(ParyObrotowe, 1) + size(ParyPostepowe, 1))+1;

    %Tutaj wstawi³bym wymuszenia obrotowe, ale ich nie ma
    
    %Wymuszenia postêpowe
    for i=1:size(WymPostepowe,1)
        FT(Pozycja, 1) = -1*WymuszenieP(WymPostepowe(i, 2), 1, T_TEMP,ParyPostepowe, WymPostepowe);
        Pozycja = Pozycja + 1;
    end

    FQ = Jakobian(Q_TEMP, ParyObrotowe, ParyPostepowe, WymObrotowe, WymPostepowe);
    DQ = -FQ \ FT;

    end


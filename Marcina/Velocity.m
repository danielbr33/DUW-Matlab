function [DQ] = Velocity(Q_TEMP, ParyObrotowe, ParyPostepowe, WymPostepowe,T_TEMP)
    %Funkcja rozwiązująca zadanie o prędkości
    
    FT = zeros(length(Q_TEMP), 1);
    tmp = 2*(size(ParyObrotowe) + size(ParyPostepowe))+1
    Pozycja = tmp(2);
    
    
    %Wymuszenia postępowe
    for i=1:size(WymPostepowe,1)
        FT(Pozycja, 1) = -1*Wymuszenie(WymPostepowe(i, 1), 1, T_TEMP,ParyPostepowe, WymPostepowe);
        Pozycja = Pozycja + 1;
    end

    FQ = Jacobian(Q_TEMP, ParyObrotowe, ParyPostepowe, WymPostepowe);
    DQ = -FQ \ FT;
end


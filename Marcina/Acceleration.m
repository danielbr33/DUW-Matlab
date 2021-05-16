function [DDQ] = Acceleration(DQ_TEMP,Q_TEMP, ParyObrotowe, ParyPostepowe, WymPostepowe,T_TEMP)
    %Funkcja wyznaczająca przyśpieszenie

    Om = [0 -1; 1 0]; 
    Gamma = zeros(length(Q_TEMP), 1);
    Pozycja = 1;
     
    %Pary obrotowe
    for i=1:size(ParyObrotowe,2) 
        
        [~, ~, Fi1, Fi2, sA, sB] = Positions(Q_TEMP, ParyObrotowe(i));
        Rot1 = Rot(Fi1);
        Rot2 = Rot(Fi2);
        
        [~, ~, DFi1, DFi2, ~, ~] = Positions(DQ_TEMP, ParyObrotowe(i));
        
        %Wzór 2.40 ze skryptu
        Gamma(Pozycja:Pozycja+1, 1) = Rot1 * sA * DFi1^2 - Rot2 * sB * DFi2^2;
    
        Pozycja = Pozycja + 2;
    end
    
    %Pary postępowe
    for i=1:size(ParyPostepowe,2) 
        %Wzór 2.46 ze skryptu        
        Gamma(Pozycja, 1) = 0;
        Pozycja = Pozycja + 1;

        U = ParyPostepowe(i).u';
        V = [-U(2); U(1)];

        [r1, r2, Fi1, Fi2, sA, ~] = Positions(Q_TEMP, ParyPostepowe(i));
        Rot1 = Rot(Fi1);
        Rot2 = Rot(Fi2);

        [dr1, dr2, dFi1, dFi2, ~, ~] = Positions(DQ_TEMP, ParyPostepowe(i));

        %Wzór 2.57 ze skryptu
        Gamma(Pozycja, 1) = (Rot2 * V)'*(2 * Omega() * (dr2 - dr1) * dFi2 + (r2 - r1) * dFi2^2 - Rot1 * sA * (dFi2 - dFi1)^2 ); 

        Pozycja = Pozycja + 1;
    end

    for i=1:size(WymPostepowe,1) %petla po wszystkich wymuszeniach postepowych    

        U = ParyPostepowe(WymPostepowe(i, 1)).u';
        
        [r1, r2, Fi1, Fi2, sA, ~] = Positions(Q_TEMP, ParyPostepowe(WymPostepowe(i, 1)));
        Rot1 = Rot(Fi1);
        Rot2 = Rot(Fi2);

        [dr1, dr2, dFi1, dFi2, ~, ~] = Positions(DQ_TEMP, ParyPostepowe(WymPostepowe(i, 1)));

        %Wzór 2.57 ze skryptu
        Gamma(Pozycja, 1) = (Rot2 * U)'*(2 * Om * (dr2 - dr1) * dFi2 + (r2 - r1) * dFi2^2 - Rot1 * sA * (dFi2 - dFi1)^2 ) + Wymuszenie(WymPostepowe(i, 1), 2, T_TEMP,ParyPostepowe, WymPostepowe); 

        Pozycja = Pozycja + 1;
    end

    %Obliczenie macierzy układu równań
    FQ = Jacobian(Q_TEMP, ParyObrotowe, ParyPostepowe, WymPostepowe);

    %Rozwiązanie
    DDQ = FQ \ Gamma;
end


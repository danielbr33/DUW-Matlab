function [DDQ] = Przyspieszenie(DQ_TEMP,Q_TEMP, ParyObrotowe, ParyPostepowe, WymObrotowe, WymPostepowe,T_TEMP)
    %Funkcja wyznaczaj¹ca przyœpieszenie

    Om = [0 -1; 1 0]; 
    Gamma = zeros(length(Q_TEMP), 1);
    Pozycja = 1;
     
    %Pary obrotowe
    for i=1:size(ParyObrotowe,1) 
        P1 = ParyObrotowe(i, 1);
        P2 = ParyObrotowe(i, 2);
    
        [~,~,Rot1] = Polozenia(Q_TEMP, P1);
        [~,~,Rot2] = Polozenia(Q_TEMP, P2);
    
        sA = ParyObrotowe(i, 3:4)';
        sB = ParyObrotowe(i, 5:6)';
    
        [~,Dfi1,~]= Polozenia(DQ_TEMP,P1);
        [~,DFi2,~]= Polozenia(DQ_TEMP,P2);
        
        %Wzór 2.40 ze skryptu
        Gamma(Pozycja:Pozycja+1, 1) = Rot1 * sA * Dfi1^2 - Rot2 * sB * DFi2^2;
    
        Pozycja = Pozycja + 2;
    end
    
    %Pary postêpowe
    for i=1:size(ParyPostepowe,1) 
        %Wzór 2.46 ze skryptu        
        Gamma(Pozycja, 1) = 0;
        Pozycja = Pozycja + 1;

        P1 = ParyPostepowe(i, 1);
        P2 = ParyPostepowe(i, 2);

        U = ParyPostepowe(i, 4:5)';
        V = [-U(2); U(1)];
        sA = ParyPostepowe(i, 6:7)';

        [R1,~,Rot1] = Polozenia(Q_TEMP, P1);
        [R2,~,Rot2] = Polozenia(Q_TEMP, P2);

        [DR1,Dfi1,~] = Polozenia(DQ_TEMP,P1);
        [DR2,DFi2,~] = Polozenia(DQ_TEMP,P2);

        %Wzór 2.57 ze skryptu
        Gamma(Pozycja, 1) = (Rot2 * V)'*(2 * Om * (DR2 - DR1) * DFi2 + (R2 - R1) * DFi2^2 - Rot1 * sA * (DFi2 - Dfi1)^2 ); 

        Pozycja = Pozycja + 1;
    end

    %Tu nale¿a³oby wstawiæ wymuszenia obrotowe

    for i=1:size(WymPostepowe,1) %petla po wszystkich wymuszeniach postepowych    
        P1 = ParyPostepowe(WymPostepowe(i, 1), 1);
        P2 = ParyPostepowe(WymPostepowe(i, 1), 2);

        U = ParyPostepowe(WymPostepowe(i, 1), 4:5)';
        sA = ParyPostepowe(WymPostepowe(i, 1), 6:7)';

        [R1,~,Rot1] = Polozenia(Q_TEMP, P1);
        [R2,~,Rot2] = Polozenia(Q_TEMP, P2);

        [DR1,Dfi1,~]=Polozenia(DQ_TEMP,P1);
        [DR2,DFi2,~]=Polozenia(DQ_TEMP,P2);

        %Wzór 2.57 ze skryptu
        Gamma(Pozycja, 1) = (Rot2 * U)'*(2 * Om * (DR2 - DR1) * DFi2 + (R2 - R1) * DFi2^2 - Rot1 * sA * (DFi2 - Dfi1)^2 ) +WymuszenieP(WymPostepowe(i, 2), 2, T_TEMP,ParyPostepowe, WymPostepowe); 

        Pozycja = Pozycja + 1;
    end

    %Obliczenie macierzy uk³adu równañ
    FQ = Jakobian(Q_TEMP, ParyObrotowe, ParyPostepowe, WymObrotowe, WymPostepowe);

    %Rozwi¹zanie
    DDQ = FQ \ Gamma;
end


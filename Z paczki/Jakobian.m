function [FQ] = Jakobian(Q_TEMP, ParyObrotowe, ParyPostepowe, ~, WymPostepowe)
    %Funkcja wyznaczaj¹ca Jakobian równañ wiêzów 
    
    Om = [0 -1; 1 0];
    FQ = zeros(length(Q_TEMP),length(Q_TEMP));
    Pozycja = 1;

    %Pary obrotowe
    for i = 1:size(ParyObrotowe,1)
        sA = ParyObrotowe(i,3:4)';
        sB = ParyObrotowe(i,5:6)';
        [~,~,Rot1] = Polozenia(Q_TEMP,ParyObrotowe(i,1));
        [~,~,Rot2] = Polozenia(Q_TEMP,ParyObrotowe(i,2));
        
        %Je¿eli dany cz³on nie jest podstaw¹
        if ParyObrotowe(i,1) ~= 0 
            %Wzór 2.29 ze skryptu
            FQ(Pozycja:Pozycja+1, ParyObrotowe(i,1)*3-2:ParyObrotowe(i,1)*3-1) = eye(2);
            
            %Wzór 2.30 ze skryptu
            FQ(Pozycja:Pozycja+1,ParyObrotowe(i,1)*3) = Om * Rot1 * sA; 
        end
        
        %Je¿eli dany cz³on nie jest podstaw¹
        if ParyObrotowe(i,2) ~= 0
            %Wzór 2.31 ze skryptu
            FQ(Pozycja:Pozycja+1, ParyObrotowe(i,2)*3-2:ParyObrotowe(i,2)*3-1) = -eye(2); 
            
            %Wzór 2.32 ze skryptu
            FQ(Pozycja:Pozycja+1, ParyObrotowe(i,2)*3) = -Om * Rot2 * sB; 
        end
    
        Pozycja = Pozycja + 2;
    end

    %Pary postepowe
    for i = 1:size(ParyPostepowe,1)
        U = ParyPostepowe(i,4:5)';
        V = [-U(2); U(1)];
        sA = ParyPostepowe(i,6:7)';
        
        [R1,~,Rot1] = Polozenia(Q_TEMP,ParyPostepowe(i,1));
        [R2,~,Rot2] = Polozenia(Q_TEMP,ParyPostepowe(i,2));
        
        %Je¿eli dany cz³on nie jest podstaw¹
        if ParyPostepowe(i,1) ~= 0
            %Wzór 2.42 ze skryptu
            FQ(Pozycja, ParyPostepowe(i,1)*3) = 1; 
            
            %Wzór 2.47 ze skryptu
            FQ(Pozycja+1, ParyPostepowe(i,1)*3-2:ParyPostepowe(i,1)*3-1) = -(Rot2 * V)'; 
            
            %Wzór 2.48 ze skryptu
            FQ(Pozycja+1, ParyPostepowe(i,1)*3) = -(Rot2 * V)' * Om * Rot1 * sA; 
        end
        
        %Je¿eli cz³on nie jest podstaw¹
        if ParyPostepowe(i,2) ~= 0
            %Wzór 2.44 ze skryptu
            FQ(Pozycja, ParyPostepowe(i,2)*3) = -1; 
            
            %Wzór 2.49 ze skryptu
            FQ(Pozycja+1, ParyPostepowe(i,2)*3-2:ParyPostepowe(i,2)*3-1) = (Rot2 * V)'; 
            
            %Wzór 2.50 ze skryptu
            FQ(Pozycja+1, ParyPostepowe(i,2)*3) = -(Rot2 * V)' * Om * (R2 - R1 - Rot1 * sA); 
        end
   
        Pozycja = Pozycja + 2;
    end

    %Gdyby byly wymuszenia obrotowe to tutaj trzeba by by³o coœ z nimi
    %zrobiæ, ale ich nie ma

    %Wymuszenia postepowe
    for i = 1:size(WymPostepowe,1)
        U = ParyPostepowe(WymPostepowe(i,1),4:5)';
        sA = ParyPostepowe(WymPostepowe(i,1),6:7)';
        
        [R1,~,Rot1] = Polozenia(Q_TEMP,ParyPostepowe(WymPostepowe(i,1),1));
        [R2,~,Rot2] = Polozenia(Q_TEMP,ParyPostepowe(WymPostepowe(i,1),2));
        
        %Je¿eli cz³on nie jest podstaw¹
        if ParyPostepowe(WymPostepowe(i,1),1) ~= 0
            %Wzór 2.47 ze skryptu
            FQ(Pozycja, ParyPostepowe(WymPostepowe(i,1),1)*3-2:ParyPostepowe(WymPostepowe(i,1),1)*3-1) = -(Rot2 * U)'; 
            
            %Wzór 2.48 ze skryptu
            FQ(Pozycja, ParyPostepowe(WymPostepowe(i,1),1)*3) = -(Rot2 * U)' * Om * Rot1 * sA; % 
        end
        
        %Je¿eli cz³on nie jest podstaw¹
        if ParyPostepowe(WymPostepowe(i,1),2) ~= 0
            %Wzór 2.49 ze skryptu
            FQ(Pozycja, ParyPostepowe(WymPostepowe(i,1),2)*3-2:ParyPostepowe(WymPostepowe(i,1),2)*3-1) = (Rot2 * U)'; 
            
            %Wzór 2.50 ze skryptu
            FQ(Pozycja, ParyPostepowe(WymPostepowe(i,1),2)*3) = -(Rot2 * U)' * Om * (R2 - R1 - Rot1 * sA); 
        end
        Pozycja = Pozycja + 1;
    end
    
    %Sprawdzenie osobliwoœci Jakobianu
    if(det(FQ)==0)
        disp('Uwaga - Jakobian jest osobliwy :c')
    end
end


function [FQ] = Jacobian(q, ParyObrotowe, ParyPostepowe, WymPostepowe)
    
    global Pos1 FQ1
    %Funkcja wyznaczająca Jakobian równań więzów
    
    Pos1 = 1;
    FQ1 = zeros(length(q), length(q));
    
    jacob_obr(q, ParyObrotowe);
    jacob_post(q, ParyPostepowe);
    jacob_wym_post(q, ParyPostepowe, WymPostepowe);
  
    %Sprawdzenie osobliwości Jakobianu
    if(det(FQ1)==0)
        disp('Uwaga - Jakobian jest osobliwy :c');
    end
    
    FQ = FQ1;
    
end

function FQ_obr = jacob_obr(q, ParyObrotowe)

    %FQ_obr = zeros(length(q),length(q));
    global Pos1 FQ1

    %Pary obrotowe
    for k = 1:size(ParyObrotowe, 2)
        
        [r1, r2, Fi1, Fi2, sA, sB] = Positions(q, ParyObrotowe(k));
        
        %Jeżeli dany człon nie jest podstawą
        if ParyObrotowe(k).i ~= 0 
            
            %Wzór 2.29 ze skryptu
            FQ1(Pos1:Pos1+1, ParyObrotowe(k).i*3-2:ParyObrotowe(k).i*3-1) = eye(2);
            
            %Wzór 2.30 ze skryptu
            FQ1(Pos1:Pos1+1,ParyObrotowe(k).i*3) = Omega() * Rot(Fi1) * sA; 
        end
        
        %Jeżeli dany człon nie jest podstawą
        if ParyObrotowe(k).j ~= 0
            
            %Wzór 2.31 ze skryptu
            FQ1(Pos1:Pos1+1, ParyObrotowe(k).j*3-2:ParyObrotowe(k).j*3-1) = -eye(2); 
            
            %Wzór 2.32 ze skryptu
            FQ1(Pos1:Pos1+1, ParyObrotowe(k).j*3) = -Omega() * Rot(Fi2) * sB; 
        end
    
        Pos1 = Pos1 + 2;
    end

end

function FQ_post = jacob_post(q, ParyPostepowe)
    
    global Pos1 FQ1
    
    %Pary postepowe
    for k = 1:size(ParyPostepowe, 2)
        
        U = ParyPostepowe(k).u;
        V = [-U(2); U(1)];
        
                    [r1, r2, Fi1, Fi2, sA, sB] = Positions(q, ParyPostepowe(k));
        
        %Jeżeli dany człon nie jest podstawą
        if ParyPostepowe(k).i ~= 0

            %Wzór 2.42 ze skryptu
            FQ1(Pos1, ParyPostepowe(k).i*3) = 1; 
            
            %Wzór 2.47 ze skryptu
            FQ1(Pos1+1, ParyPostepowe(k).i*3 - 2 : ParyPostepowe(k).i*3-1) = -(Rot(Fi2) * V)'; 
            
            %Wzór 2.48 ze skryptu
            FQ1(Pos1+1, ParyPostepowe(k).i*3) = -(Rot(Fi2) * V)' * Omega() * Rot(Fi1) * sA; 
        end
        
        %Jeżeli człon nie jest podstawą
        if ParyPostepowe(k).j ~= 0
            
            %Wzór 2.44 ze skryptu
            FQ1(Pos1, ParyPostepowe(k).j*3) = -1; 
            
            %Wzór 2.49 ze skryptu
            FQ1(Pos1+1, ParyPostepowe(k).j*3-2:ParyPostepowe(k).j*3-1) = (Rot(Fi2) * V)'; 
            
            %Wzór 2.50 ze skryptu
            FQ1(Pos1+1, ParyPostepowe(k).j*3) = -(Rot(Fi2) * V)' * Omega() * (r2 - r1 - Rot(Fi1) * sA); 
        end
   
        Pos1 = Pos1 + 2;
    end

end

function FQ_wym_post = jacob_wym_post(q, ParyPostepowe, WymPostepowe)

    global Pos1 FQ1
    
    %Wymuszenia postepowe
    for i = 1:size(WymPostepowe,1)
        
        U = ParyPostepowe(WymPostepowe(i,1)).u';
        [r1, r2, Fi1, Fi2, sA, sB] = Positions(q, ParyPostepowe(WymPostepowe(i,1)));
        
        Rot1 = Rot(Fi1);
        Rot2 = Rot(Fi2);
        
        %Jeżeli człon nie jest podstawą
        if ParyPostepowe(WymPostepowe(i,1)).i ~= 0
            %Wzór 2.47 ze skryptu
            FQ1(Pos1, ParyPostepowe(WymPostepowe(i,1)).i*3-2:ParyPostepowe(WymPostepowe(i,1)).i*3-1) = -(Rot2 * U)'; 
            
            %Wzór 2.48 ze skryptu
            FQ1(Pos1, ParyPostepowe(WymPostepowe(i,1)).i*3) = -(Rot2 * U)' * Omega() * Rot1 * sA; % 
        end
        
        %Jeżeli człon nie jest podstawą
        if ParyPostepowe(WymPostepowe(i,1)).j ~= 0
            %Wzór 2.49 ze skryptu
            FQ1(Pos1, ParyPostepowe(WymPostepowe(i,1)).j*3-2:ParyPostepowe(WymPostepowe(i,1)).j*3-1) = (Rot2 * U)'; 
            
            %Wzór 2.50 ze skryptu
            FQ1(Pos1, ParyPostepowe(WymPostepowe(i,1)).j*3) = -(Rot2 * U)' * Omega() * (r2 - r1 - Rot1 * sA); 
        end
        Pos1 = Pos1 + 1;
    end

end

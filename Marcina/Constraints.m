function F = Constraints(q, ParyObrotowe, ParyPostepowe, WymPostepowe, T_TEMP)
    %Funkcja wyznaczająca wartości funkcji opisujących więzy
 
    global Pos1 F1
    
    Pos1 = 1;
    F1 = zeros(length(q), 1);
    
    wiezy_pary_obrotowe(q, ParyObrotowe);
    wiezy_pary_post(q, ParyPostepowe);
    wiezy_wym_post(q, WymPostepowe, ParyPostepowe, T_TEMP);
    
    % F = F_obr + F_post + F_wym_post;
    
    F = F1;

end

function wiezy_pary_obrotowe(q, ParyObrotowe)

    global Pos1 F1

    %Stworzenie równań dla par obrotowych
    for i = 1:(size(ParyObrotowe,2))
        
        [r1, r2, Fi1, Fi2, sA, sB] = Positions(q, ParyObrotowe(i));
        F1(Pos1:Pos1+1,1) = r1 + Rot(Fi1) * sA - (r2 + Rot(Fi2) * sB);
        Pos1 = Pos1 + 2;
        
    end
end

function wiezy_pary_post(q, ParyPostepowe)

    %Stworzenie równań dla par postępowych
    global Pos1 F1
    
    for i = 1:(size(ParyPostepowe,2))
        
        [r1, r2, Fi1, Fi2, sA, sB] = Positions(q, ParyPostepowe(i)); 
       
        u = ParyPostepowe(i).u;
        v = [-u(2); u(1)];

        %Wzór 2.17
        F1(Pos1,1) = Fi1 - Fi2;
        
        %Wzór 2.20
        F1(Pos1+1,1) = (Rot(Fi2) * v)'*(r2 - r1 - Rot(Fi1) * sA) + v' * sB;
        
        Pos1 = Pos1 + 2;
    end
end

function wiezy_wym_post(Q_TEMP, WymPostepowe, ParyPostepowe, T_TEMP)

    global Pos1 F1

    %Stworzenie równań dla wymuszeń postępowych
    for i = 1:(size(WymPostepowe,1))
        
        [r1, r2, Fi1, Fi2, sA, sB] = Positions(Q_TEMP, ParyPostepowe(WymPostepowe(i,1)));
        U = ParyPostepowe(i).u';
        Rot1 = Rot(Fi1);
        Rot2 = Rot(Fi2);
        
        % wzor 2.26 na wymuszenie w parze postepowej
        F1(Pos1,1) = (Rot2 * U)'*(r2 + Rot2 * sB - r1 - Rot1 * sA) - Wymuszenie(WymPostepowe(i,1),0,T_TEMP,ParyPostepowe, WymPostepowe);
        
        Pos1 = Pos1 + 1;
    end

end


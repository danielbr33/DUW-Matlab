function [r1, r2, Fi1, Fi2, sA, sB] = Positions(q, para_kinematyczna)
    %Funkcja pobierająca aktualne współrzędne 
    
    [r1, Fi1] = get_r_fi(q, para_kinematyczna.i);
    [r2, Fi2] = get_r_fi(q, para_kinematyczna.j);
    sA = para_kinematyczna.sA;
    sB = para_kinematyczna.sB;

end

function [r, fi] = get_r_fi(q, index)

    if(index == 0)
        r = [0;0];
        fi = 0;
    else
        r = [q(3*index-2); q(3*index-1)]; 
        fi = q(3*index);
    end

end


function [M] = Jakobian_postepowy_D(czlon,Dane)

    Om=[0 -1; 1 0];
    
    i=Dane(1);
    j=Dane(2);
    n1=Dane(3);
    n2=Dane(4);

    % wczytanie danych ze struktury czlon
    
    ri=(czlon{i}.xc(1:2))';
    rj=(czlon{j}.xc(1:2))';
    fi_i=czlon{i}.xc(3);
    fi_j=czlon{j}.xc(3);
    si=czlon{i}.xs(n1,:)';
    sj=czlon{j}.xs(n2,:)';
    
    % obliczenie wektora prostopadlego do osi pary posepowej
        
    uj=sj/norm(sj);
    
    Ri=R(fi_i);
    Rj=R(fi_j);
    
      
    M1=[-(Rj*uj)' (-Rj*uj)'*Om*Ri*si];       
    M2=[(Rj*uj)' (-Rj*uj)'*Om*(rj-ri-Ri*si)];
    
    M=[M1,M2];
    
end
function [G] = Gamma_kierujaca(czlon,Dane,dq,t)

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
    
    dfi_i=dq(3*(i-1));
    dfi_j=dq(3*(j-1));
    dr_i=[dq(3*i-5);dq(3*i-4)];
    dr_j=[dq(3*j-5);dq(3*j-4)];
    
    Ri=R(fi_i);
    Rj=R(fi_j);
    
    uj=sj/norm(sj);
    
    G1=(Rj*uj)'*(2*Om*(dr_j-dr_i)*dfi_j+(rj-ri)*dfi_j*dfi_j-Ri*si*(dfi_j-dfi_i)*(dfi_j-dfi_i))+d2fk(t);    
    
    G=G1;
    
end
function [G] = Gamma_postepowa(czlon,Dane,dq)

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
        
%     if (abs(sj(1))>abs(sj(2)))
%         
%         vj=[-(sj(2)/sj(1)) 1]';
%         vj=vj/norm(vj);
%         
%     else
%         
%         vj=[1 -(sj(1)/sj(2))]';
%         vj=vj/norm(vj);
%         
%     end

    vpom=[0 0 1]';
    vpom1=[sj/norm(sj);0];
    
    vpom2=cross(vpom,vpom1);
    vj=[vpom2(1);vpom2(2)];
    
    dfi_i=dq(3*(i-1));
    dfi_j=dq(3*(j-1));
    dr_i=[dq(3*i-5);dq(3*i-4)];
    dr_j=[dq(3*j-5);dq(3*j-4)];
    
    Ri=R(fi_i);
    Rj=R(fi_j);
    
    G1(1,1)=0;
    G1(2,1)=(Rj*vj)'*(2*Om*(dr_j-dr_i)*dfi_j+(rj-ri)*dfi_j*dfi_j-Ri*si*(dfi_j-dfi_i)*(dfi_j-dfi_i));    
    
    G=G1;
    
end
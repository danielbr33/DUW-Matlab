function [G] = Gamma_obrotowa(czlon,Dane,dq)
    
    i=Dane(1);
    j=Dane(2);
    n1=Dane(3);
    n2=Dane(4);
    
    fi_i=czlon{i}.xc(3);
    fi_j=czlon{j}.xc(3);
    si=czlon{i}.xs(n1,:)';
    sj=czlon{j}.xs(n2,:)';
    
    if i==1
        
        dfi_j=dq(3*(j-1));
        Rj=R(fi_j);
        
        G1=-Rj*sj*dfi_j*dfi_j;
        
    else
    
        dfi_i=dq(3*(i-1));
        dfi_j=dq(3*(j-1));
        Ri=R(fi_i);
        Rj=R(fi_j);
        
        G1=Ri*si*dfi_i*dfi_i-Rj*sj*dfi_j*dfi_j;
        
    end
    
    G=G1;
    
end
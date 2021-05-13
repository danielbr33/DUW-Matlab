function [M] = Jakobian_obrotowy(czlon,Dane)

    Om=[0 -1; 1 0];
    
    i=Dane(1);
    j=Dane(2);
    n1=Dane(3);
    n2=Dane(4);
    
    fi_i=czlon{i}.xc(3);
    fi_j=czlon{j}.xc(3);
    si=czlon{i}.xs(n1,:)';
    sj=czlon{j}.xs(n2,:)';
    
    if i==1
        
        M1=zeros(2,3);
        
    else
    
        M1=[eye(2,2) Om*R(fi_i)*si];
        
    end
    
    M2=[-eye(2,2) -Om*R(fi_j)*sj];
    
    M=[M1,M2];

end


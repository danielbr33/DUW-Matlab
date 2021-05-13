function [Fi] = Para_postepowa_D(czlon,i,j,n1,n2,t,m)

    % wczytanie danych ze struktury czlon

    ri=(czlon{i}.xc(1:2))';
    rj=(czlon{j}.xc(1:2))';
    fi_i=czlon{i}.xc(3);
    fi_j=czlon{j}.xc(3);
    si=czlon{i}.xs(n1,:)';
    sj=czlon{j}.xs(n2,:)';
    uj=sj/norm(sj);
    
    % obliczenie prawych stron         
    
    Fi=((R(fi_j)*uj)')*(rj+R(fi_j)*sj-ri-R(fi_i)*si)-fk(t,m);

end
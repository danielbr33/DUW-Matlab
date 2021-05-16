function [Fi] = Para_obrotowa(czlon,i,j,n1,n2)

    ri=(czlon{i}.xc(1:2))';
    rj=(czlon{j}.xc(1:2))';
    fi_i=czlon{i}.xc(3);
    fi_j=czlon{j}.xc(3);
    si=czlon{i}.xs(n1,:)';
    sj=czlon{j}.xs(n2,:)';
    
    Fi=ri+R(fi_i)*si-(rj+R(fi_j)*sj);

end


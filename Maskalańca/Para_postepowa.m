function [Fi] = Para_postepowa(czlon,i,j,n1,n2)

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
    
    % obliczenie prawych stron         
    
    FiK=fi_i-fi_j;
    FiV=((R(fi_j)*vj)')*(rj-ri-R(fi_i)*si)+((vj)')*sj;
    
    Fi=[FiK ;FiV];

end
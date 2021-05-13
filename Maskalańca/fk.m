function [fk] = fk(t,i)

    L=[0.447 0.632]; %213595499958 455532033676
    A=0.05;
    w=1;
    fi0=0;
    
    fk=L(i)+A*sin(w*t+fi0);

end


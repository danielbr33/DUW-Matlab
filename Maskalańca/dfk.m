function [fk] = dfk(t)

    A=0.05;
    w=1;
    fi0=0;
    
    fk=A*w*cos(w*t+fi0);

end
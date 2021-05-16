function [fk] = d2fk(t)

    A=0.05;
    w=1;
    fi0=0;
    
    fk=-A*w*w*sin(w*t+fi0);

end
function [VRHS] = VRHS(t)

    VRHS=zeros(30,1);
    VRHS(29)=dfk(t);
    VRHS(30)=dfk(t);

end


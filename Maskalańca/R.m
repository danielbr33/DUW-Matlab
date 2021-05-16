function [Rot] = R(fi)

    Rot(1,1)=cos(fi);
    Rot(2,1)=sin(fi);
    Rot(1,2)=-sin(fi);
    Rot(2,2)=cos(fi);
    
end


function [r, Fi, Rot_i] = Polozenia(Q,i)
    if(i == 0) %podstawa
        r = [0;0];
        Fi = 0;
        Rot_i = Rot(Fi);
    else
        r = Q((3*i-2):(3*i-1));
        Fi = Q(3*i);
        Rot_i = Rot(Fi);
    end
end
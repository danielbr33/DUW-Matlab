function [F] = Sily (Q, DQ, ParyPostepowe, Masy)
    number = length(Q(:,1));
    Q=zeros(number,1);

    %% Sila wymuszajaca wzór 3.20
    P = 700*[cos(330/360*2*pi), sin(330/360*2*pi)]';
    Om=[0 -1;1 0];
    M_0 = [2    0.4]';
    C10_0 = [1.85  0.45]';
    M_10 = M_0 - C10_0;
    s = M_10;
    Q(10*3-2:10*3) = [eye(2,2); Om * Rot(Q(10*3)) * s] * P;

    %% grawitacja wzór 3.19
    g=[0  -9.81]';
    for i=1:1:number
        Q(i*3-2: i*3) = Q(i*3-2: i*3)+[Masy(i)*g; 0];
    end

    %% Sily od t³umika pierwszego, wzory 3.22-3.30
    A = [0 0]';
    D = [0.2 0.4]';
    Om=[0 -1;1 0];
    r3 = Q(3*3-2: 3*3-1);
    r4 = Q(4*3-2: 4*3-1);
    dr3 = DQ(3*3-2: 3*3-1);
    dr4 = DQ(4*3-2: 4*3-1);
    R3 = Rot(Q(3*3));
    R4 = Rot(Q(4*3));
    sA = ParyPostepowe(3,6:7)';
    sB = ParyPostepowe(3,8:9)';
    dfi3 = DQ(3*3);
    dfi4 = DQ(4*3);
    d = r3 + R3*sB - r4 - R4*sA;
    u = d/norm(d);
    d = nor(d);
    vA = dr3 + Om*R3*sA*fdi3;
    vB = dr4 + Om*R4*sB*dfi4;
    ddt = u'*(vB-vA);
    k = 70000;
    c = 1700;
    d0 = u * norm(D-A);
    Fk = u*k*(d-d0);
    Fc = u*c * ddt;
    Q(3*3-2:3*3-1) = Q(3*3-2:3*3-1) + Fk + Fc;
    Q(4*3-2:4*3-1) = Q(4*3-2:4*3-1) - Fk - Fc;

    %% Sily od t³umika drugiego, wzory 3.22-3.30
    B = [0 0.4]';
    H = [0.6 0.6]';
    Om=[0 -1;1 0];
    r5 = Q(5*3-2: 5*3-1);
    r6 = Q(6*3-2: 6*3-1);
    dr5 = DQ(5*3-2: 5*3-1);
    dr6 = DQ(6*3-2: 6*3-1);
    R5 = Rot(Q(5*3));
    R6 = Rot(Q(6*3));
    sA = ParyPostepowe(5,6:7)';
    sB = ParyPostepowe(6,8:9)';
    dfi5 = DQ(5*3);
    dfi6 = DQ(6*3);
    d = r5 + R5*sB - r6 - R6*sA;
    u = d/norm(d);
    d = norm(d);
    vA = dr5 + Om*R5*sA*fdi5;
    vB = dr6 + Om*R6*sB*dfi6;
    ddt = u'*(vB-vA);
    k = 70000;
    c = 1700;
    d0 = norm(D-A);
    Fk = u*k*(d-d0);
    Fc = u*c * ddt;
    Q(5*3-2:5*3-1) = Q(5*3-2:5*3-1) + Fk + Fc;
    Q(6*3-2:6*3-1) = Q(6*3-2:6*3-1) - Fk - Fc;

end

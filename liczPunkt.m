function [q, dq, ddq] = liczPunkt(Q, DQ, DDQ, UkladyWspolrzednych, WspolrzednePunktu, numerCzlonu)
    r = WspolrzednePunktu - (UkladyWspolrzednych(numerCzlonu, 1:2))';
    R = Rot(numerCzlonu*3);
    q = Q(numerCzlonu*3-2:numerCzlonu*3-1) + R*r;
    
    Om = [0 -1;
          1  0];
    dq = DQ(numerCzlonu*3-2:numerCzlonu*3-1) + Om*R*r*DQ(numerCzlonu*3);
    
    ddq = DDQ(numerCzlonu*3-2:numerCzlonu*3-1) - R*r*(DQ(numerCzlonu*3))^2 + Om*R*r*DDQ(numerCzlonu*3);
    
end
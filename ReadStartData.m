function [q, CoordinateSystem, RevoluteJoint, PrismaticJoint] = ReadStartData()
    temp = fopen('DanePliki/UkladyWspolrzednych.txt', 'r');
    number = str2num(fgetl(temp));
    for i=1:number
        dane = str2num(fgetl(temp));
        CoordinateSystem(i,:)=[dane(1) dane(2) dane(3)];
    end
    fclose(temp);

    temp = fopen('DanePliki/ParyObrotowe.txt', 'r');
    number = str2num(fgetl(temp));
    for i=1:number
        dane = str2num(fgetl(temp));
        czlon1 = dane(1);
        czlon2 = dane(2);
        OsObrotu = dane(3:4);
        if czlon1==0
            ukladWspolrz1 = [0 0];
            fi1 = 0;
        else
            ukladWspolrz1 = CoordinateSystem(czlon1,1:2);
            fi1 = CoordinateSystem(czlon1,3);
        end
        if czlon2==0
            ukladWspolrz2 = [0 0];
            fi2 = 0;
        else
            ukladWspolrz2 = CoordinateSystem(czlon2,1:2);
            fi2 = CoordinateSystem(czlon2,3);
        end
        R1 = Rot(fi1);
        R2 = Rot(fi2);
        sa = OsObrotu - ukladWspolrz1;
        sb = OsObrotu - ukladWspolrz2;
        RevoluteJoint(i,:) = [czlon1 czlon2 sa sb]; 
    end 
    fclose(temp);
    
    temp = fopen('DanePliki/ParyPostepowe.txt', 'r');
    number = str2num(fgetl(temp));
    for i=1:number
        dane = str2num(fgetl(temp));
        czlon1 = dane(1);
        czlon2 = dane(2);
        fi = 0;
        punktA = dane(3:4);
        punktB = dane(5:6);
        if czlon1==0
            ukladWspolrz1 = [0 0];
            fi1 = 0;
        else
            ukladWspolrz1 = CoordinateSystem(czlon1,1:2);
            fi1 = CoordinateSystem(czlon1,3);
        end
        if czlon2==0
            ukladWspolrz2 = [0 0];
            fi2 = 0;
        else
            ukladWspolrz2 = CoordinateSystem(czlon2,1:2);
            fi2 = CoordinateSystem(czlon2,3);
        end
        R1 = Rot(fi1);
        R2 = Rot(fi2);
        v = punktA - punktB;
        v = v/norm(v);
        v = v*Rot(pi/2);
        sa = punktA - ukladWspolrz1;
        sb = punktB - ukladWspolrz2;
        PrismaticJoint(i,:) = [czlon1 czlon2 fi v sa sb];
        PrismaticEnds(i,:) = [punktA, punktB];
    end
    fclose(temp);
    
    temp = fopen('DanePliki/UkladyWspolrzednych.txt', 'r');
    number = str2num(fgetl(temp));
    q = zeros(number*3,1);
    for i=1:1:number
        q(i*3-2:i*3) = CoordinateSystem(i, 1:3);
    end
    fclose(temp);
end

    
    

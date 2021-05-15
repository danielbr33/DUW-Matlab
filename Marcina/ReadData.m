function [Czlony, ParyObrotowe, ParyPostepowe, WymPostepowe] = ReadData()

    Czlony = read_links();
    ParyObrotowe = read_pary_obrotowe(Czlony);
    ParyPostepowe = read_pary_postepowe(Czlony);
    WymPostepowe = read_wym_postepowe();

end

function links = read_links()

    links_file = fopen('Dane/links.txt', 'r');
    
    %   Wczytanie członów
    amount = str2num(fgetl(links_file));  % wczytanie liczby członów
    
    links = zeros(3*amount, 1);
    
    for i = 1:amount
        tmp = str2num(fgetl(links_file));
        links(3*i - 2) = tmp(1);
        links(3*i - 1) = tmp(2);
        links(3*i) = 0;
    end

end

function ParyObrotowe = read_pary_obrotowe(Czlony)
    
    p_obr_file = fopen('Dane/pary_obr.txt', 'r');

    %  Wczytanie par obrotowych - rozdzial 2.3
    amount = str2num(fgetl(p_obr_file));     %pierwsza dana to liczba par obrotowych

    for k = 1:amount

        tmp = str2num(fgetl(p_obr_file));
        czlon1 = tmp(1);
        czlon2 = tmp(2);
        Polozenie = [tmp(3); tmp(4)];

        if(czlon1==0)
            q1 = [0;0];
        else
            q1 = Czlony(3*czlon1-2 : 3*czlon1-1);
        end

        if(czlon2==0)
            q2 = [0;0];
        else
            q2 = Czlony(3*czlon2-2 : 3*czlon2-1);
        end

        ParyObrotowe(k).i = czlon1;
        ParyObrotowe(k).j = czlon2;
        ParyObrotowe(k).sA = (Polozenie-q1);
        ParyObrotowe(k).sB = (Polozenie-q2);

    end
end

function ParyPostepowe = read_pary_postepowe(Czlony)

    %Wczytanie par postępowych - rozdział 2.3
    
    p_post_file = fopen('Dane/pary_post.txt', 'r');
    amount = str2num(fgetl(p_post_file));
    
    for k = 1:amount
        
        tmp = str2num(fgetl(p_post_file));
        czlon1 = tmp(1);
        czlon2 = tmp(2);
        Polozenie1 = [tmp(3); tmp(4)];
        Polozenie2 = [tmp(5); tmp(6)];

        if(czlon1==0)
            q1 = [0;0];
        else
            q1 = Czlony(3*czlon1-2 : 3*czlon1-1);
        end
        
        if(czlon2==0)
            q2 = [0;0];
        else
            q2 = Czlony(3*czlon2-2 : 3*czlon2-1);
        end

    ParyPostepowe(k).i = czlon1;
    ParyPostepowe(k).j = czlon2;
    ParyPostepowe(k).sA = (Polozenie1-q1);
    ParyPostepowe(k).sB = (Polozenie2-q2);
    ParyPostepowe(k).L_i = [Polozenie1'];
    ParyPostepowe(k).L_j = [Polozenie2'];
    
    U = [Polozenie2(1)-Polozenie1(1);Polozenie2(2)-Polozenie1(2)];
    U = U/norm(U);
    
    ParyPostepowe(k).u = U';
    end

end

function wym_postepowe = read_wym_postepowe()

    file = fopen('Dane/wym.txt');
    amount = str2num(fgetl(file));
    for k = 1:amount 
        wym_postepowe(k,:) = str2num(fgetl(file));
    end

end
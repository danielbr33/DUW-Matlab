function [time, q, dq, ddq, M] = Main(dt, time_max)
    
    c10_M = [(1.3-1.2); (-0.3+0.25)]; 

    %Pobranie danych z plików txt
    [Czlony, ParyObrotowe, ParyPostepowe, WymPostepowe] = ReadData();
    
    % Przybliżenie startowe  
    q_temp = Czlony;
    dq_temp = zeros(length(q_temp),1); 
    ddq_temp = zeros(length(q_temp),1);  
    
    %Wyznaczenie liczby wyników i zadeklarowanie licznika 
    Iterations = 1;
    Size = time_max/dt + 1;
    
    %Zadeklarowanie rozmiaru macierzy i wektorów gromadzących wyniki
    time = zeros(1, Size);
    q = zeros(length(q_temp), Size);
    dq = zeros(length(q_temp), Size);
    ddq = zeros(length(q_temp), Size);
    M = zeros(2, Size);

    %Rozwiązywanie zadań kinematyki w kolejnych chwilach T_TEMP
    for t = 0:dt:time_max
        
        q_temp = q_temp + dq_temp * dt + 0.5 * ddq_temp * dt * dt;
        
        %Rozwiązanie zadania o położenie
        q_temp = NewtonRaphson(q_temp, ParyObrotowe, ParyPostepowe, WymPostepowe, t); 
        
        %Rozwiązanie zadania o prędkości
        dq_temp = Velocity(q_temp, ParyObrotowe, ParyPostepowe, WymPostepowe, t); 
        
        %Rozwiązanie zadania o przyśpieszenia 
        ddq_temp = Acceleration(dq_temp, q_temp, ParyObrotowe, ParyPostepowe, WymPostepowe, t);

        
        %Zapisane wyników do macierzy i wektorów gromadzących
        time(1,Iterations) = t; 
        q(:,Iterations) = q_temp;
        dq(:,Iterations) = dq_temp;
        ddq(:,Iterations) = ddq_temp;
        
        c10x = q(28, Iterations);
        c10y = q(29, Iterations);
        c10fi = q(30, Iterations);
        c10 = [c10x;c10y];
        
        M(:, Iterations) = c10 + Rot(c10fi) * c10_M; 
    
        Iterations = Iterations + 1;
    end
end
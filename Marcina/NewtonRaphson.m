function q = NewtonRaphson(q, ParyObrotowe, ParyPostepowe, WymPostepowe, time)
    %Rozwiązanie układu równań metodą Newtona-Raphsona

    F = ones(length(q),1);
    EPS = 10e-9;
    Iteration = 1;
    MaxIteration = 25;

    while(norm(F) > EPS && Iteration < MaxIteration)
        
        F = Constraints(q, ParyObrotowe, ParyPostepowe, WymPostepowe, time);
        FQ = Jacobian(q, ParyObrotowe, ParyPostepowe, WymPostepowe);
        q = q - FQ \ F;
        Iteration = Iteration + 1;
        
    end
    
    if(Iteration > MaxIteration)
        disp('Nie udało się uzyskać zbieżności po założonej liczbie iteracji.')
    end
end


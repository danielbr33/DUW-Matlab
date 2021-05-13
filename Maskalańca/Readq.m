function [q] = Readq(czlon)

    q=zeros(1,3*(length(czlon)-1));

    for k=2:length(czlon)
        
        q((3*k-5):(3*k-3))=czlon{k}.xc;
        
    end
    
    q=q';

end


function [czlon] = Writeq(czlon,q)

    for k=2:length(czlon)
        
        czlon{k}.xc=q((3*k-5):(3*k-3))';
        
    end

end
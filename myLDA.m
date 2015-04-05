function [Lvector, newCoeff] = myLDA( coeff, pcaLength)
    [n,m] = size(coeff);
    cmeans = zeros(n,15);

    for x = 1:n
        k=1;
        for y = 1:7:m          
            for i=1:7
                cmeans(x,k) = cmeans(x,k) + coeff(x,(y-1)+i);
            end
            k = k + 1;
        end
        
        cmeans(x,k-1) = cmeans(x,k-1)/(m/15);
    end
    
    mean = zeros(n,1);
    for x = 1:n
        k = 1;
        for y = 1:15
            mean(x,k) = mean(x,k) + cmeans(x,y);
        end
        mean(x,k) = mean(x,k) / (m/15); 
        k = k + 1;
    end
    
    sw = zeros(pcaLength,pcaLength);
    for c = 1:15
        i = 1+((c-1)*7);
        temp = [cmeans(:,c),cmeans(:,c),cmeans(:,c),cmeans(:,c),cmeans(:,c),cmeans(:,c),cmeans(:,c)];
        mat = coeff(:,i:(i+6)) - temp;
        sw = sw + ((mat * mat'));
    end
    
    sb = zeros(pcaLength,pcaLength);
    for c = 1:15
        mat = mean - cmeans(:,c);
        sb = sb + ((m/15)*(mat * mat')); 
    end
    
    [vec, val] = eig(inv(sw) * sb);
    Lvector = vec(:,1);
    
    newCoeff = coeff' * Lvector;
end


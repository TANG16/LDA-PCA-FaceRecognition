function out = computeLBP(img)
    lbp = [];
    [n,m] = size(img);
    bN = floor(n/7);
    bM = floor(m/7);
    out = [];
    for y = 1:bN:(n-bN)
        for x = 1:bM:(m-bM)
            block = img(y:(y+bN), x:(x+bM));
            out = [out, blockLBP(block)];
        end
    end
    
    bN = floor(n/5);
    bM = floor(m/5);
    for y = 1:bN:(n-bN+1)
        for x = 1:bM:(m-bM+1)
            block = img(y:(y+bN-1), x:(x+bM-1));
            out = [out, blockLBP(block)];
        end
    end
    bN = floor(n/3);
    bM = floor(m/3);
    for y = 1:bN:(n-bN+1)
        for x = 1:bM:(m-bM+1)
            block = img(y:(y+bN-1), x:(x+bM-1));
            out = [out, blockLBP(block)];
        end
    end
end
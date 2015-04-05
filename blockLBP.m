function  out = blockLBP( block )
    out = [];
    [n,m] = size(block);
    for y = 2:(n-1)
        for x = 2:(m-1)
            bin = [];
            for i = -1:1
                if(block(y-1,x+1) > block(y,x))
                    bin = [bin, '0'];
                else 
                    bin = [bin,'1'];
                end
            end
                if(block(y,x+1) > block(y,x))
                    bin = [bin, '0'];
                else 
                    bin = [bin,'1'];
                end
            for i = 1:-1:0
                if(block(y+1,x+1) > block(y,x))
                    bin = [bin, '0'];
                else 
                    bin = [bin,'1'];
                end
            end
            if(block(y,x-1) > block(y,x))
                    bin = [bin, '0'];
                else 
                    bin = [bin,'1'];
            end
            bin = bin2dec(bin);
            out = [out, bin];
        end   
    end
    out = hist(out);
end


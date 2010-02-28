function [ I ]= trace( I, r, c, lo)
% Trace an edge from a hi point, and keep tracing neighbors 
% (following the edge) until we aren't bigger than lo anymore...
for y = r-1:r+1 
    for x = c-1:c+1
        if ( inside(I,y,x) & (I(y,x) > lo) & I(y,x) ~= 255)
            I(y,x) = 255;
            I = trace(I, y, x, lo);
        end
    end
end
return

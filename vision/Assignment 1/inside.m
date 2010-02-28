function [ in ] = inside(I, r, c)
% Check whether given coordinates are inside given image
[h, w] = size(I);
if( (c >= 1) & (c <= w) & (r >= 1) & (r <= h) )
    in = 1;
else
    in = 0;
end
return

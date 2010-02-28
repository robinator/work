function [ r, c ] = validate( I, r, c )
% Return valid coordinates given a point and image
[h, w] = size(I);
if(r < 1) r = 1;end
if(r > h) r = h;end
if(c < 1) c = 1;end
if(c > w) c = w;end
return

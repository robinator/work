function [ sumSD ] = ssd( I, r, c, w )
% Computes the ssd (sum of squared differences) given an image,
% a point, and a window size
[r1 c1] = validate(I, round(r - w/2), round(c - w/2));
[r2 c2] = validate(I, round(r + w/2), round(c + w/2));

sumSD = I(r2,c2) - I(r2,c1) - I(r1, c2) + I(r1, c1);

return

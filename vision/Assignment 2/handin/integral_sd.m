function [ intI ] = integral_sd(Il, Ir, d)
% Compute the integral image of the equation:
%   SD(x,y) = (L(x,y) - R(x-d,y))^2
% This image will help us compute window sums in time independent of window size

[hL, wL] = size(Il);  % image dimensions for left image
C = zeros(hL, wL);    % buffer image
S = zeros(hL, wL);    % the integral image

for r = 1:hL % for each row
    if 1-d > 0 
        x = 1-d; % make sure it's a valid location
    else
        x = 1;
    end
    C(r,1) = (Il(r,1) - Ir(r, x))^2;
    for c = 2:wL
        if c-d > 0
            y = c-d; % again, we want a valid location
        else
            y = c;
        end
        C(r,c) = C(r, c-1) + (Il(r,c) - Ir(r, y))^2;
    end
end

for c = 1:wL % for each column
    S(1,c) = C(1,c);
    for r = 2:hL;
        S(r,c) = S(r-1, c) + C(r,c);
    end
end

intI = S;
return
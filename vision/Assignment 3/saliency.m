% Assignment 3 - Saliency Network
% Robert Law
% CMSC 25030
% 05.23.2008
function [output] = saliency(I, K)
% Given an image (left and right) a max disparity, and (optionally) a
% window size, return a disparity image using a window-based, sum of

[H, W] = size(I);  % image dimensions
I = double(I);     % convert to double for processing


dMap = ones(H,W, 1+D); % 3d array of (x,y,d) values

for d = 0:D
    intI = integral_sd(Il, Ir, d); % compute integral image at this disparity
    for r = 1:H
        for c = 1:W
            if w > 0 % fixed or dynamic?
                sumSD = ssd(intI,r,c,w);
            else
                sumSD = min_window(intI,r,c);
            end
            dMap(r,c,d+1) = sumSD; % save the best sum of squared difference
        end
    end
end

outI = zeros(H, W);

scaler = 255/D; 
for r = 1:H
    for c = 1:W
        [minVal minD] = min(dMap(r,c,:)); % save disparity with minimum SSD
        outI(r,c) = minD * scaler; % normalize disparities from 0 to 255
    end
end

output = outI;

return


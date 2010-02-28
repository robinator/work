function [ sumSD ] = min_window( I, r, c )
% Given an image and a point inside it, return the sum of squared
% difference using an 'optimal' window size. An optimal window is chosen
% from within a range of window sizes by finding the window that offers the
% lowest (normalized) ssd. Normalization is computed by dividing the SSD of
% a given window by the window size squared. 
minW = 10; % window size range
maxW = 20;
SDs = zeros(1,maxW-minW);
norm = zeros(1,maxW-minW);

for w = minW:maxW
    SSD = ssd(I,r,c,w); % actual SSD
    SDs(w-minW+1) = SSD; 
    norm(w-minW+1) = SSD/(w^2); % normalized SSD (used for comparing window sizes)
end
[minVal loc] = min(norm(1,:)); % save the location of the normalized min SSD
sumSD = SDs(1,loc); % return the ACTUAL ssd from that location

return
    

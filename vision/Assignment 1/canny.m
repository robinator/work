% Assignment 1 - Edge Detection
% Robert Law
% CMSC 25030
% 04.13.2008

function [output] = canny(I, lo, hi, sigma);

[h, w] = size(I);                       % image dimensions
I = double(I);                          % convert to double for processing
sigma = double(sigma);                  % think we need this to be a double b/c matlab is weird
GaussianFactor = double(4);             % preassigned in class readings
halfw = round(GaussianFactor * sigma);  % half width of our Gaussian
ver = (-halfw : halfw)';                % a vertical Gaussian mask
[u2, v2] = size(ver);                   % and dimensions
hor = (-halfw : halfw);                 % a horizontal Gaussian mask
[u1, v1] = size(hor);                   % and dimensions

% Our Gaussian function...
gauss = inline('exp( (-(t^2)) / (2 * (sigma^2))) / (sigma*sqrt(2*pi))', 't', 'sigma');

% create horizontal Gaussian mask
for x = 1:v1
    hor(x) = double(gauss(hor(x),sigma));
end

% create vertical Gaussian mask
for y = 1:u2
    ver(y) = double(gauss(ver(y),sigma));
end

O = zeros(h, w);      % initialize output array

% Convolve Gx with I
for Oy = 1:h           % loop over output rows & columns
    for Ox = 1:w
        sum = 0;
        for Gr = -halfw:halfw % loop over vector mask rows or columns
            for Gc = 1:1  % not really a loop is it?
                % let's not overstep our bounds 
                if (inside(I, (Oy-Gr), (Ox-Gc)))
                    sum = sum + I(Oy-Gr, Ox-Gc) * ver(Gr+halfw+1, Gc);
                % but if we do let's just use the border replication technique
                else
                    sum = sum + I(Oy, Ox) * ver(Gr+halfw+1, Gc);
                end
            end
        end
        O(Oy, Ox) = sum;  % store result
    end
end
I = O; % save what we did

O = zeros(h, w);      % re-initialize output array

% Convolve Gy with I (our Gx * I)
for Oy = 1:h            % loop over output rows & columns
    for Ox = 1:w
        sum = 0;
        for Gr = 1:1    % loop over vector mask rows or columns
            for Gc = -halfw:halfw              
                % let's not overstep our bounds 
                if ( inside(I, (Oy-Gr), (Ox-Gc)))
                    sum = sum + I(Oy-Gr, Ox-Gc) * hor(Gr, Gc+halfw+1);
                % but if we do let's just the border replication technique
                else
                    sum = sum + I(Oy, Ox) * hor(Gr, Gc+halfw+1);
                end
            end
        end
        O(Oy, Ox) = sum;  % store result
    end
end

G = O; % our Gaussian-ed image

m = zeros(h,w);     % new output array
dxI = zeros(h, w);  % Derivative of x
dyI = zeros(h, w);  % Derivative of y
dX = (1:w);
dY = (1:h)';

% Let's find the gradient, gradient magnitude, gm^2...
% We do this by deriving the x's and y's of the image, then 
% squaring and adding them, then taking the sqaure root of that 
for Mr = 2:(h-1)            % loop over output rows & columns. Avoid edges b/c of issues
    for Mc = 2:(w-1)
        dX(Mc) = G(Mr+1, Mc) - G(Mr-1, Mc); % this is the dx of the gradient
        dY(Mr) = G(Mr, Mc+1) - G(Mr, Mc-1); % this is the dy of the gradient
        dxI(Mr,Mc) = dX(Mc);
        dyI(Mr,Mc) = dY(Mr);
        m(Mr, Mc) = dX(Mc)^2 + dY(Mr)^2;    % this is the squared gradient magnitude
    end
end

mag = sqrt(m); % gradient magnitude

% Now let's do non-maximum suppression
% We do this by finding 'peaks' where a point is higher than it's neighbors
% and it's neighbors are sloping away from it.
P = zeros(h, w);    % new output array
for mr = 2:(h-1) 
    for mc = 2:(w-1)
        if mag(mr,mc) > 0   % you can't divide by zero in this house!
            dx = round( (dxI(mr,mc) / mag(mr,mc) ));
            dy = round( (dyI(mr,mc) / mag(mr,mc) ));
        else
            dx = 0;
            dy = 0;
        end
        p = m(mr,mc); % current point
        pplus = m(mr+dx, mc+dy);  % direction forward
        pminus = m(mr-dx, mc-dy); % direction backward

        if ( (p > pplus) & (p >= pminus) ) | ( (p > pminus) & (p >= pplus) )
            P(mr,mc) = p; 
        else
            P(mr,mc) = 0; % you call that a peak?!
        end
    end
end

I = P; % save our work...
% compute hysteresis, using trace and the thresholds given.
% We do this by finding a peak above 'hi', then walking down it's edge
% until we are lower than lo
for y = 2:(h-1)
    for x = 2:(w-1)
        if (I(y,x) > hi)
            I(y,x) = 255;        % found a peak!
            I = trace(I,y,x,lo); % now let's walk down the edge...
        end
    end
end

% We need to add a second pass over the image to remove everything that 
% isn't an edge...While we're at it, let's reverse the image to make it 
% look like the edges are black...This is trivial, but I think it was 
% required for the assignment...
for y = 1:h
    for x = 1:w
        if (I(y,x) < 255)
            I(y,x) = 1;
        elseif (I(y,x) == 255)
            I(y,x) = 0;
        end
    end
end

output = I;
return


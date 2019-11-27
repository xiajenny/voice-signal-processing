% Jenny Xia 20562574, Burhan Drak Sibai 20717420, Mickey Dang 20704978, Andrew Wentzell 20711153

% Assumes aperiodic

% xt is array of values at time interval t
% w is array of frequecies
function ft = fourier_transform(Xt, t, w) 
    deltaT = 0;
    ft = zeros(length(w),1);
    if length(t) > 1
    deltaT = t(2) - t(1);
  else
    deltaT = 1;
    end
    % For each frequency value w
    for freq = 1: length(w)
        % Sum all values in signal xt across t
        for n = 1:length(Xt)
            ft(freq) = ft(freq) + (deltaT)*Xt(n) * exp(-1j * w(freq) * t(n));
        end        
    end
    
end

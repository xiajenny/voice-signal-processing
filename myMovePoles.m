function [ aOut ] = myMovePoles(aIn,ratio)
% input argument:
% aIn: the coefficients of the original models
% ratio: the amount of movement
% output:
% aOut: the coefficients of the modified models

% the size of input models
aOut = zeros(size(aIn));

for aIdx = 1:size(aIn,1)
    % find the poles of the current model
    poles = roots(aIn(aIdx,:));
    % get the magnitude of poles 
    magnitude = abs(poles);
    % get the angles of the poles  
    angles = angle(poles);
    
    % Question 4
    % moving the poles according the ratio 
    % write your code to move the poles' positions using the input
    % argument 'ratio'.
    % please comment on why all the poles obtained are either real or
    % complex conjugate pairs
    %
    %
    %
    %
    % You need to achieve the following:
    % 1, do NOT move real poles
    % 2, after the move, the poles that are conjugate pair should still be conjugate pairs
    % 3, maintain the relative positions of the poles, 
    % 4, Keep the magnitude of each pole.
    % 5, store the new poles in the variable named newPoles
    % end of Question 4
    
    % using poly command to generate output coefficients according to the new poles
    aOut(aIdx,:) = real(poly(newPoles));
end

end
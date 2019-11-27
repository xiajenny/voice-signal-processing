function newData = synthVoice(a,g,b,excitation,ratio)

% processing window moving increment (number of data points)
incrementLen = round(128*ratio);

% processing window width (number of data points)
winWidth = 2*incrementLen;

% number of data epoches
[nEpoches,~] = size(a);

% exictation length (number of data points)
excitationLen = length(excitation);

% house keeping
dataLength = excitationLen - (winWidth-incrementLen);
excitation = [excitation, zeros(1, winWidth)];

% init output
newData = zeros(1,dataLength);
epochIdx = 1;
% working through the epoches
while epochIdx <= nEpoches
    % getting current epoch pointer
    currPointer = (epochIdx-1)*incrementLen;
    % prepare to add new data
    preData = newData(currPointer + [1:incrementLen]);
    % getting the model of the current epoch
    currentA = a(epochIdx,:);
    % getting current gain
    currentGain = g(epochIdx);
    % calculate new data using the current model and current excitation
    %     newbit = currentGain*filter(b, currentA, excitation(currPointer + [1:winWidth]));
    newbit = currentGain*filter(b, currentA, excitation(currPointer + [1:winWidth]));
    % adding new data to the proper place in the output variable
    newData(currPointer + [1:winWidth]) = [preData, zeros(1,(winWidth-incrementLen))] + (hanning(winWidth)'.*newbit);
    % move on to the next epoch
    epochIdx = epochIdx + 1;
end

% De-emphasis (must match pre-emphasis in lpcfit)
pre = [1 -0.9];
newData = filter(1,pre,newData);

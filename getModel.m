function [a,g,excitations] = getModel(data,p)
% data: input data, in 1 data N format
% p:    the order of the model
% 
incrementLen = 128;
winWidth = 256;
dataLenth = length(data);
nEpochs = floor(dataLenth/incrementLen);
if size(data,2) == 1
    data = data';
end
data = [zeros(1,(winWidth-incrementLen)/2),data,zeros(1,(winWidth-incrementLen/2))];

% model coefficients
a = zeros(nEpochs, p+1);
% gain
g = zeros(nEpochs, 1);
% excitations
excitations = zeros(1, (nEpochs-1)*incrementLen+winWidth);


% Pre-emphasis
pre = [1 -0.9];
data = filter(pre,1,data);

for epochIdx = 1:nEpochs

  % Extract current epochs
  datadata = data((epochIdx - 1)*incrementLen + [1:winWidth]);
  % Apply hanning window
  wdatadata = datadata .* hann(winWidth)';
  % LPC model fitting
  [dummya,dummyG] = lpc(wdatadata,p);
  
  % performing modeling prediction: using the obtained current model and
  % data to get the current excitation
  dummy = filter(dummya,dummyG,wdatadata);
  excitations((epochIdx - 1)*incrementLen + [1:winWidth]) = excitations((epochIdx - 1)*incrementLen +[1:winWidth]) + dummy;
  
  % save current model coefficients and Gain
  a(epochIdx,:) = dummya; 
  g(epochIdx) = dummyG; 
  
end

excitations = excitations((1+((winWidth-incrementLen)/2)):end);
end

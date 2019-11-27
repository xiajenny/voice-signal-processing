% the process of speech analysis and synthesis
clear all;
close all;

%load voice data
load('SYDE252FUN.mat');
% play the original sound
sound(y,sr);
% get the model parameters for a 40-order filter
[a,g,x] = getModel(y,20);

% synthesis voice from the estimated parameters
newY = synthVoice(a,g,1,x,1);
% play the synthesized audio signal
sound(newY,sr);

% Question 1
% add your code here, using your Fourier Transform to show 
% the spectra of the original signal and the synthesized signal
% Comment on your observation










% end of Question 1
%% Changing the speed of the speech, without significantly modifying the tone of the speech
% play the audio at half speed
sound(y,sr/2);
% play the audio at double speed
sound(y,sr*2);
% Question 2


% end of Question 2
% Question 3: changing the length of x, without changing its general shape
x_f = interp1(); % finish this line to generate x_f[n] for faster speech
x_s = interp1(); % finish this line to generate x_s[n] for slower speech
% end of Question 3

% synthesis voices using the x_fast and x_slow you just generated
y_f = synthVoice(a,g,1,x_f,0.5);
y_s = synthVoice(a,g,1,x_s,2);

% play the synthesized audio signal
sound(y_f,sr);
sound(y_s,sr);


%% changing the tone without changing the speed

% move the poles so the resulting system function would have a higher gain
% at higher frequencies
aHigh = myMovePoles(a,0.2);
% synthesis the speech with the new system and the original x[n], resulting in a speech with
% higher tone, but at the same speed as the original signal
yHigh = synthVoice(aHigh,g,1,x,1);
% play the new signal
sound(yHigh,sr);


% move the poles so the resulting system function would have a higher gain
% at lower frequencies
aLow = myMovePoles(a,-0.2);
% synthesis the speech with the new system and the original x[n], resulting in a speech with
% lower tone, but at the same speed as the original signal
yLow = synthVoice(aLow,g,1,x,1);
% play the new signal
sound(yLow,sr);
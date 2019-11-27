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

figure;

% Original Spectrum
Fsampling = sr;
dt = 1/Fsampling;
N = length(y);
t = 0 + (0:N-1)*dt;
freq = horzcat(-linspace(0,N/2,N/2 )*Fsampling/N,linspace(N/2 + 1 ,0,N/2 + 1)*Fsampling/N);
rad = freq * 2 * pi;
% spectrum = fourier_transform(y, t, rad); 
% our function from the last assignment is much slower than fft()
spectrum = fft(y);
subplot(2, 1, 1);
plot(freq, spectrum);
title('Original Spectrum');
xlabel('Frequency (Hz)');

% New Spectrum
N = length(newY);
t = 0 + (0:N-1)*dt;
freq = horzcat(-linspace(0,N/2,N/2 )*Fsampling/N,linspace(N/2,0,N/2)*Fsampling/N);
rad = freq * 2 * pi;
% spectrum2 = fourier_transform(newY, t, rad); 
% our function from the last assignment is much slower than fft()
spectrum2 = fft(newY);
subplot(2, 1, 2);
plot(freq, spectrum2);
title('New Spectrum');
xlabel('Frequency (Hz)');

% We can see that the synthesized spectrum has roughly the same frequency
% peaks as the original spectrum. However, the synthesized spectrum appears
% to contain artifacts in the lower frequencies. For example, there
% are frequencies present around the 0-500Hz range in the synthesized
% fourier transform plot that were not present in the original spectrum. In
% addition, the original spectrum had clear peaks at around 150Hz and
% 250Hz, with the peak at 250Hz having a higher magnitude than the 150Hz
% peak. However, in the synthesized spectrum, the peak at 150Hz appears to
% be slightly larger than the 250Hz peak instead.

% end of Question 1
%% Changing the speed of the speech, without significantly modifying the tone of the speech
% play the audio at half speed
sound(y,sr/2);
% play the audio at double speed
sound(y,sr*2);
% Question 2

% The time scaling property of the fourier transform can be used to explain
% the phenomenon where when we play the audio signal at half speed, the
% tone is significantly lower, and when we play the audio at double the
% speed, the tone is significantly higher. We can note that if an aperiodic
% signal x(t) is scaled in time by a to become x(at), that the fourier
% transform of the new signal is (1/|a|)X((jw)/a). This shows that when the
% signal is stretched or compressed in the time domain, the reciprocal
% occurs in the frequency domain. For example, when the signal is stretched by
% playing it at half speed (a = 0.5), there is a compression in the
% frequency domain due to the X((jw)/a)) term => (X(2jw)), causing the frequencies to be 
% lower and thus the audio tone to sound lower.

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

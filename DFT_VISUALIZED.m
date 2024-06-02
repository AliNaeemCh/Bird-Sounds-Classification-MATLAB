clc
clear all
Fs=1024;
T=1/Fs;
n=linspace(0,Fs,Fs);
%To get one cycle of a pure sine wave with time period Tsig and sampling
%period T, where T=1/Fs, n=0:Tsig/T
%%%%%signal contains 1 DC value and two frequencies i-e 50Hz and 100Hz%%%%%
signal=5+1*sin(2*pi*50*n*T)+10*sin(2*pi*100*n*T);

signalength = length(signal);
fftlength = signalength;
resolution = Fs/fftlength;
fouriertranstwosided = fft(signal, fftlength);
fouriertranstwosidedmag = abs(fouriertranstwosided);
fouriertransformagnorm = fouriertranstwosidedmag/signalength;
fouriertransonesided = fouriertransformagnorm(1:fix(fftlength/2)+1);
fouriertransonesided(2:end-1) = 2*fouriertransonesided(2:end-1);   %normalizing the magnitude
freqHz = 0:resolution:Fs/2;                     
figure
stem(freqHz,fouriertransonesided,'filled','linewidth',2) 
title('Spectrum of Signal')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
function fouriertransonesided=dft(signal,Fs,dftpoints)
signalength = length(signal);
  if ~exist('dftpoints','var')
      dftpoints=signalength;
  end
 if ~exist('Fs','var')
      Fs = getFs;     %Default Sampling Freq
 end
signalength = length(signal);
fouriertranstwosidedmag = abs(fft(signal,dftpoints));
fouriertransformagnorm = fouriertranstwosidedmag/signalength;
fouriertransonesided = fouriertransformagnorm(1:fix(dftpoints/2)+1);
fouriertransonesided(2:end-1) = 2*fouriertransonesided(2:end-1);   %normalizing the magnitude
end
%Below code is used to plot the Amplitude vs Frequency (Hz) Graph

% Fs=16000;
% freqHz = Fs*(0:(dftpoints/2))/dftpoints;                        
% figure
% plot(freqHz,fouriertransonesided) 
% title('Spectrum of Signal')
% xlabel('Frequency (Hz)')
% ylabel('Amplitude')
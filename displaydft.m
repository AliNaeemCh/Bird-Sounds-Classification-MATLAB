function displaydft(signal,Fs,plotype,dftpoints)
signalength = length(signal);
 if ~exist('Fs','var')
      Fs = getFs;     %Default Sampling Freq
 end
  if ~exist('dftpoints','var')
      dftpoints=signalength;
  end
if dftpoints<signalength
    disp('Warning!')
    disp('Results would be wrong since the total DFT Points are less than the input samples');
end
fouriertranstwosidedmag = abs(fft(signal,dftpoints));
fouriertransformagnorm = fouriertranstwosidedmag/signalength;
fouriertransonesided = fouriertransformagnorm(1:fix(dftpoints/2)+1);
fouriertransonesided(2:end-1) = 2*fouriertransonesided(2:end-1);   %normalizing the magnitude
freqHz = Fs*(0:(dftpoints/2))/(dftpoints);        
 if ~exist('plotype','var') | plotype=='line'
    plot(freqHz,fouriertransonesided,'linewidth',2)
    title('Spectrum of Signal')
    xlabel('Frequency (Hz)')
    ylabel('Amplitude')
elseif(plotype=='stem')
    stem(freqHz,fouriertransonesided,'filled','linewidth',2)
    title('Spectrum of Signal')
    xlabel('Frequency (Hz)')
    ylabel('Amplitude')
end
end
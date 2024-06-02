function plotaudio(birdaudio)
for i=1:gettotalbirds
   signal=birdaudio( (i-1)*get_total_audios_per_bird+1 ).inputaudio;
   signal_length=length(signal);
   timeaxis=linspace(0,signal_length/getFs,signal_length);
   subplot(4,2,i)
   plot(timeaxis,signal)
   title(getbirdnames(i))
   xlabel('Time (s)')
   ylabel('Amplitude')
   set(gca,'fontsize',13)
end
end
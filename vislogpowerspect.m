%If you want to display the spectrogram with frequency axis marked with
%all the center frequencies of mel filter banks, you can do this by 
%specifying freqlin argument, When freqlin='linear', the freq axis values
%are spaced linearly and when freqlin='nonlinear', the freq axis values are
%spaced non-linearly
function vislogpowerspect(birdaudio,freqlin)
  if ~exist('freqlin','var')
        freqlin = 'auto';
  end
birdaudio.logpowerspect=transpose(birdaudio.logpowerspect);
[melbands,totalframes]=size(birdaudio.logpowerspect);
maxmel=hztomel(getFs/2);
spacing=maxmel/(melbands+1);
centerfreqmel=zeros(1,melbands);
for i=1:melbands
    centerfreqmel(i)=spacing*i;
end
for i=1:melbands
    centerfreqhz(i)=quantizeit(meltohz(centerfreqmel(i)));
end
temporalbinsize=(getframesize/getFs);         %Duration of 1 frame
temporalbins=[];
for i=1:totalframes
    temporalbins(i)=(i-1)*temporalbinsize;
end
if strcmp(freqlin,'auto')
    contourf(temporalbins,centerfreqhz,birdaudio.logpowerspect)
    title('Log Power Spectrum')
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    c = colorbar;
    c.Label.String = 'Magnitude (dB)';
    set(gca,'fontsize',15)
    ax=gca;
    ax.YGrid='on';
    set(gca,'Linewidth',2)
elseif strcmp(freqlin,'nonlinear')
    contourf(temporalbins,centerfreqmel,birdaudio.logpowerspect)
    title('Log Power Spectrum')
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    c = colorbar;
    c.Label.String = 'Magnitude (dB)';
    set(gca,'fontsize',15)
    ax=gca;
    ax.YGrid='on';
    set(gca,'Linewidth',2)
    set(gca,'YLim',[centerfreqmel(1,1) centerfreqmel(end)],'YTick',centerfreqmel(1,:))
    set(gca,'YTicklabel',centerfreqhz(1,:));
elseif strcmp(freqlin,'linear')
    contourf(temporalbins,centerfreqhz,birdaudio.logpowerspect)
    title('Log Power Spectrum')
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    c = colorbar;
    c.Label.String = 'Magnitude (dB)';
    set(gca,'fontsize',15)
    ax=gca;
    ax.YGrid='on';
    set(gca,'Linewidth',2)
    set(gca,'YLim',[centerfreqhz(1,1) centerfreqhz(end)],'YTick',centerfreqhz(1,:))
end
% set(gca,'YLim',[centerfreqmel(1,1) centerfreqmel(end)],'YTick',centerfreqmel(1,:))
% set(gca,'YTick',centerfreqmel(1,:));
% set(gca,'YTicklabel',centerfreqhz(1,:));
% yticks(centerfreqmel(1,:))
% yticklabels(centerfreqhz(1,:))
end